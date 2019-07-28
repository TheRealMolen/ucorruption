
import array
import disasm

# To remove RNG and bp on microfunc buffer:
#   let 44c2=430f; let 44c4=430f; let 456e=430f; let 4570=430f; b e000; b e4c6; b 44c6; b 5000; b 8000
#
# with RNG set to 0, layout is:
#   5000-50dc: 0
#   50dc: ??
#   8000: copied from relo_to_r15
#   e000: decoded microfunc


class CPU(object):

    def __init__(self, memfile):
        self.r = [0] * 16
        self.mem, _ = disasm.load_memory(memfile)
        self.fetch_mem = lambda addr: self.mem[(addr & 0xffff) >> 1]

    def __str__(self):
        s = (
"""pc  %04x  sp  %04x  sr  %04x  cg  %04x
r04 %04x  r05 %04x  r06 %04x  r07 %04x
r08 %04x  r09 %04x  r10 %04x  r11 %04x
r12 %04x  r13 %04x  r14 %04x  r15 %04x""" % tuple(self.r))
        return s

    def at(self, addr):
        return self.fetch_mem(addr)

    @property
    def pc(self):
        return self.r[0]
    @pc.setter
    def pc(self, pc):
        self.r[0] = pc

    @property
    def sr(self):
        return self.r[2]
    @sr.setter
    def sr(self, sr):
        self.r[2] = sr

    @property
    def carry(self):
        return (self.sr & 1) != 0

    @property
    def r14(self):
        return self.r[14]


    def setsr(self, carry=None, overflow=None, negative=None, zero=None):
        sr = self.sr
        if carry is not None:
            sr = (sr & 0xfffe) | carry
        if zero is not None:
            sr = (sr & 0xfffd) | (zero << 1)
        if negative is not None:
            sr = (sr & 0xfffb) | (negative << 2)
        if overflow is not None:
            sr = (sr & 0xff7f) | (overflow << 7)
        self.sr = sr


    def mov( self, rs, rd ):
        self.r[rd] = self.r[rs]

    def swpb( self, rd ):
        t = self.r[rd]
        self.r[rd] = ((t >> 8) | (t << 8)) & 0xffff

    def xor( self, rs, rd ):
        a = self.r[rs]
        b = self.r[rd]
        res = a ^ b
        self.setsr( carry = False,
                    overflow = False,                   # TODO: wtf is this?
                    negative = ((res & 0x8000) != 0),
                    zero = (res == 0))
        self.r[rd] = res & 0xffff

    def addi( self, i, rd ):
        prev = self.r[rd]
        res = prev + i
        self.setsr(carry = (res > 0xffff),
                    overflow = False,                   # TODO: wtf is this?
                    negative = ((res & 0x8000) != 0),
                    zero = (res == 0))
        self.r[rd] = res & 0xffff

    def add( self, rs, rd ):
        self.addi( self.r[rs], rd )

    def dadd_nyb( self, n, a, b, c ):
        na = (a >> (n*4)) & 0xf
        nb = (b >> (n*4)) & 0xf
        nr = na + nb + c
        if nr <= 9:
            return nr,0
        return ((nr + 6) & 0xf), 1

    def daddi_wk( self, a, rd ):
        b = self.r[rd]

        t1 = a + 0x0666
        t2 = t1 ^ b
        t1 = t1 + b
        t2 = t1 ^ t2
        t2 = ~t2 & 0x1110
        t2 = (t2 >> 2) | (t2 >> 3)
        res = t1 - t2
        self.setsr(carry = False, # TODO nuts
                    overflow = False,                   # TODO: wtf is this?
                    negative = ((res & 0x8000) != 0),
                    zero = (res == 0))
        self.r[rd] = res

    def daddi( self, i, rd ):
        prev = self.r[rd]
        #print 'dadd #%04x, #%04x' % (i,prev)
        nr0,nc = self.dadd_nyb( 0, i, prev, 0 )
        nr1,nc = self.dadd_nyb( 1, i, prev, nc )
        nr2,nc = self.dadd_nyb( 2, i, prev, nc )
        nr3,nc = self.dadd_nyb( 3, i, prev, nc )
        res = (nr3<<12) | (nr2<<8) | (nr1<<4) | nr0
        self.setsr(carry = (nc != 0),
                    overflow = False,                   # TODO: wtf is this?
                    negative = True if ((res & 0x8000) != 0) or (nc != 0) else None,
                    zero = (res == 0))
        self.r[rd] = res

    def dadd( self, rs, rd ):
        self.daddi( self.r[rs], rd )


    # overflow rules for subtract
    # Positive - Negative = Negative,
    # Negative - Positive = Positive,
    # otherwise reset
    # p i r N
    # 0 0 0 0
    # 0 0 1 0
    # 0 1 0 0
    # 0 1 1 1
    # 1 0 0 1
    # 1 0 1 0
    # 1 1 0 0
    # 1 1 1 0
    def subi( self, i, rd ):
        prev = self.r[rd]
        res = prev - i
        self.setsr(carry = (prev >= i),
                    overflow = False,                   # TODO: wtf is this?
                    negative = ((res & 0x8000) != 0),
                    zero = (res == 0))
        self.r[rd] = res & 0xffff

    def rra(self, rd):
        prev = self.r[rd]
        res = (prev & 0x8000) | (prev >> 1)
        self.setsr( carry = None,
                    overflow = False,                   # TODO: wtf is this?
                    negative = None,
                    zero = False)
        self.r[rd] = res & 0xffff

    def rrc(self, rd):
        prev = self.r[rd]
        oldc = self.carry
        newc = prev & 1
        res = (self.carry << 15) | (prev >> 1)
        self.setsr( carry = newc,
                    overflow = False,                   # TODO: wtf is this?
                    negative = True if oldc else None,  # this sounds wrong!
                    zero = True if (res == 0) else None)
        self.r[rd] = res & 0xffff



def decrypt_instr(instr_addr, cpu):
    "<decrypt_instr>:    ; r10 = instr addr + 1w,  r15 = instr, return decrypted in r15"
    cpu.r[10] = instr_addr + 2
    cpu.r[15] = cpu.fetch_mem( instr_addr )

    #45c2:  0e4a           mov   r10, r14
    cpu.pc = 0x45c2
    cpu.mov( 10, 14 )

    #45c4:  8e10           swpb  r14
    cpu.pc = 0x45c4
    cpu.swpb( 14 )

    #45ca:  3e80 d204      sub   #0x04d2, r14
    cpu.pc = 0x45ca
    cpu.subi( 0x04d2, 14 )

    #45d2:  0e52           add   sr, r14
    cpu.pc = 0x45d2
    cpu.add( 2, 14 )

    #45d4:  0e10           rrc   r14
    cpu.pc = 0x45d4
    cpu.rrc( 14 )

    #45da:  0eaa           dadd  r10, r14
    cpu.pc = 0x45da
    cpu.dadd( 10, 14 )
    
    #45e0:  0e11           rra   r14
    cpu.pc = 0x45e0
    cpu.rra( 14 )

    #45e6:  0e10           rrc   r14
    cpu.pc = 0x45e6
    cpu.rrc( 14 )

    #45e8:  2ea0           dadd  @pc, r14
    cpu.pc = 0x45e8
    cpu.daddi( cpu.at(cpu.pc+2), 14 )   # juicy twist: pc is incremented before address is taken

    #45ee:  0e52           add   sr, r14
    cpu.pc = 0x45ee
    cpu.add( 2, 14 )

    #45f0:  0e10           rrc   r14
    cpu.pc = 0x45f0
    cpu.rrc( 14 )

    #45f6:  2e50           add   @pc, r14
    cpu.pc = 0x45f6
    cpu.addi( cpu.at(cpu.pc+2), 14 )
    
    #45f8:  0e10           rrc   r14
    cpu.pc = 0x45f8
    cpu.rrc( 14 )

    #45fe:  0e10           rrc   r14
    cpu.pc = 0x45fe
    cpu.rrc( 14 )

    #4604:  0fee           xor   r14, r15
    cpu.pc = 0x4604
    cpu.xor( 14, 15 )

    return cpu.r[15]


def decrypt_nugget(addr, cpu, write_mem):

    movr12 = 0x403c

    next_addr = -1
    next_word_is_addr = False
    for i in range(7):
        iaddr = addr + (i*2)
        dc = decrypt_instr( iaddr, cpu )
        write_mem( iaddr, dc )

        if next_word_is_addr:
            next_addr = dc - 0x3194
            next_word_is_addr = False
        elif dc == movr12:
            next_word_is_addr = True

    return next_addr




def test_decrypt(addr, shouldbe, cpu):
    decrypted = decrypt_instr( addr, cpu )
    assert decrypted == shouldbe, 'Decrypted address %04x wrong; should be %04x, got %04x' % (addr,shouldbe,decrypted)

def test_cpu():
    cpu = CPU('holly-encrypted.mem')

    cpu.setsr(carry=True)
    assert cpu.sr == 0x0001, cpu.sr
    cpu.setsr(zero=True, carry=False)
    assert cpu.sr == 0x0002
    cpu.setsr(negative=True, zero=False)
    assert cpu.sr == 0x0004
    cpu.setsr(overflow=True)
    assert cpu.sr == 0x0084, hex(cpu.sr)
    cpu.setsr(carry=True, zero=False, negative=True, overflow=True)
    assert cpu.sr == 0x0085

    cpu.r[14] = 0x0845
    cpu.daddi( 0x3c01, 14 )
    assert cpu.r[14] == 0x4a46, hex(cpu.r[14])
    cpu.r[14] = 0x0dd0
    cpu.daddi( 0x3c01, 14 )
    assert cpu.r[14] == 0x4031, hex(cpu.r[14])

    test_decrypt(0x160c, 0x8231, cpu)


def decode_lines(init_addrs, fetch_mem):
    addrs = set(init_addrs)
    done = set()

    instrs = {}
    def write_instr( addr, instr ):
        assert addr not in instrs
        instrs[addr] = instr

    while addrs:
        naddrs = set()
        for addr in addrs:
            naddrs |= disasm.decode(fetch_mem, addr, with_addr=True, write_instr=write_instr)

        done |= addrs
        addrs = naddrs - done

    lines = []
    for addr in sorted(instrs.keys()):
        line = instrs[addr]
        lines.append( line )

    return lines


def main():

    test_cpu()

    M, _ = disasm.load_memory('hollywood-init.mem')
    U, _ = disasm.load_memory('holly-micro.mem')


    uaddrs = []
    ucomments = {}
    with open('holly-micro.mem', 'rt') as uf:
        for line in uf.readlines():
            if len(line.strip()) == 0:
                continue
            if line[4] != ':':
                print 'Ignoring complicated line: ' + line

            addr = int(line[:4], 16)
            uaddrs.append(addr)

            try:
                ucomments[addr] = line.split('   ',2)[2]
            except:
                ucomments[addr] = '---'
            

    main.mread = set()

    def fetch_mem(addr):
        ix = (addr & 0xffff) >> 1
        main.mread |= set((ix,))
        return M[ix]

    def fetch_umem(addr):
        ix = (addr & 0xffff) >> 1
        return U[ix]


    startaddrs = [0x4400, 0x44d8, 0x44e2, 0x44ec, 0x44fe, 0x4508, 0x4512, 0x451c,
                  0x4614, 0x4626, 0x4628, 0x4536]
    lines = decode_lines( startaddrs, fetch_mem )

    ulines = decode_lines( uaddrs, fetch_umem )

    # clean up jump-to-next-address noise
    cleanlines = []
    for i,line in enumerate(lines):
        if ('jmp' not in line) or (line[-4:] != lines[i+1][:4]):
            cleanlines.append( line )

    # comment microcode
    readable_micro = []
    for line in ulines:
        addr = int(line[:4],16)
        if addr in ucomments:
            readable_micro.append('; ' + ucomments[addr].strip())
        readable_micro.append( line )


    with open('holly-full.s', 'wt') as outf:
        outf.write('\n'.join(lines))

    with open('holly-clean.s', 'wt') as outf:
        outf.write('\n'.join(cleanlines))

    with open('holly-micro.s', 'wt') as outf:
        outf.write('\n'.join(readable_micro))

            
    cpu = CPU('holly-encrypted.mem')
    decrypted_mem = array.array('H', (0 for _ in xrange(1<<15)))
    fetch_dc_mem = lambda addr: decrypted_mem[ addr >> 1 ]
    def write_dc_mem(addr,val):
        decrypted_mem[ addr >> 1 ] = val

    decrypted_addrs = set()
    dclines = []
    def write_dc_instr( addr, instr ):
        dclines.append( instr )

    next_addr = 0x160c
    while next_addr >= 0:
        if next_addr in decrypted_addrs:
            break

        this_addr = next_addr
        next_addr = decrypt_nugget( this_addr, cpu, write_dc_mem )
        decrypted_addrs.add( this_addr )

        addrs = set((this_addr,))
        done = set()

        while addrs:
            naddrs = set()
            for addr in addrs:
                naddrs |= disasm.decode(fetch_dc_mem, addr, with_addr=True, write_instr=write_dc_instr)
            done |= addrs
            addrs = naddrs - done

        dclines.append('')
    
    with open('holly-decrypted.s', 'wt') as outf:
        outf.write('\n'.join(dclines))

    with open('holly-unravelled.s', 'wt') as outf:
        outf.write('\n'.join([line for ix,line in enumerate(dclines) if ix%4==0]))


main()


