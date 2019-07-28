
asm1 = '12c334401111'
asm2 = '0410'

addr = 0x4400
for i in range(0,len(asm1),4):
    print 'let %04x=%s%s; ' % (addr, asm1[i+2:i+4], asm1[i:i+2]),
    addr += 2

for i in range(9):
    print 'let %04x=%s%s; ' % (addr, asm2[2:], asm2[:2]),
    addr += 2

print ''

