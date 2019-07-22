import sys


def read_memfile(filename):
    "Returns a list of tuples of (address,[words])"

    infile = file( filename, 'rt' )
    blocks = []
    block = None
    lastaddr = -16

    for line in infile.xreadlines():
        addr,contents = line.split(':',1)
        addr = int(addr,16)

        if block == None or lastaddr+16 != addr:
            if block != None:
                blocks.append(block)
            block = (addr, [])
            lastaddr = addr - 16

        contents = contents.strip()
        if contents == '*':
            # just skip the memory
            continue

        words = contents.split('  ',1)[0].strip()
        block[1].extend( words.split(' ') )
        lastaddr += 16

    if block != None:
        blocks.append( block )

    return blocks


def string_to_words(s):
    if ' ' in s:
        return [w.strip() for w in s.strip().split(' ')]

    assert len(s) % 4 == 0
    words = []
    for i in range(0, len(s), 4):
        words.append( s[i:i+4] )
    return words


def main(argv):
    if len(argv) < 3:
        print 'Usage:', argv[0], '<memfile> <hex_to_find>'
        sys.exit(1)

    filename = argv[1]
    needle = string_to_words( argv[2] )

    memblocks = read_memfile(filename)

    for block in memblocks:
        haystack = block[1]
        for offs in xrange(0, len(haystack) - len( needle ) + 1):
            if haystack[offs] != needle[0]:
                continue

            for i in range(1,len(needle)):
                if needle[i] != haystack[offs+i]:
                    break
            else:
                # found one!
                print 'Found at %x' % (block[0] + (offs * 2))


if __name__ == '__main__':
    main(sys.argv)