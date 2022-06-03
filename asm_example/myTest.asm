addi r1, r0, #128
subi r2, r0, #128
nop
andi r3, r1, #-128
andi r4, r2, #128
ori r5, r1, #1
xori r1, r1, #-128
slli r6, r2, #4
srli r7, r2, #4
snei r8, r2, #127
slei r9, r2, #129
sgei r10, r2, #127
