set debug remote 1
set remotebaud 38400
target remote /dev/ttyS0
c
load out.out
i reg
x/x 0xd200
x/x 0xd208
