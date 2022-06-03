; emulate a MOV
addi r1, r0, #1
addi r2, r0, #2
addi r3, r0, #3
addi r4, r0, #4
sll r1, r1, #2 ; 4
sll r2, r2, #2 ; 8
sll r3, r3, #2 ; 12
sll r4, r4, #2 ; 16
srl r1, r1, #2 ; 1
srl r2, r2, #2 ; 2
srl r3, r3, #2 ; 3
srl r4, r4, #2 ; 4
; Same as multiplying by 2
add r1, r1, r1
add r2, r2, r2
add r3, r3, r3
add r4, r4, r4
nop
sub r5, r1, r2 ;r5 is -2
nop
sub r6, r3, r4 ;r6 is -2
; Now perform some logical operation
and r7, r1,r2
or r8, r3,r4
xor r9, r1, r4
sne r10, r1, r2 ; r10 is 1
sle r11, r1, r2 ;r11 is 1
sge r12, r1, r2 ;r12 is 0

; now halt the processor
stop:
j stop
nop
nop
;two nops because branch delay slot is 2
