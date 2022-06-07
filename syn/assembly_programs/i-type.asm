; emulate a MOV
addi r1, r0, #-193
nop
nop
nop
subi r1, r1, #-193
;Now perform some logic functions
ori r2, r0, #0xAAAA ; load 101010... pattern on r2
nop
nop
nop
; once again nops for data dependecy...
slli r2, r2, #16 ; move to the top side of the register
nop
nop
nop
; nop for dd
ori r2, r2, #0xAAAA ; load 101010... pattern on r2
nop
nop
nop
;Now we have a complete mask with 1010 pattern, now complement the mask to 0101
ori r3, r0, #0xFFFF
nop
nop
nop
; once again nops for data dependecy...
slli r3, r3, #16 ; move to the top side of the register
nop
nop
nop
; nop for dd
ori r3, r3, #0xFFFF
nop
nop
nop
; Now i have r2 filled with 1010 pattern
; Now i have r3 filled with 1111 pattern
; Let's save 0101 pattern into r4 to create another mask
xor r4 r2, r3
nop
nop
nop
; Now r4 has 0101 pattern
; Start performing logical operations in pipeline avoiding data dependencies
andi r5, r3, #0
; I should obtain r5 with 16 top bits at 1, and the bottom part full of 0s
srli r6, r2, #1 ;shift r2 in order to go from 1010 -> 0101 pattern


; now halt the processor
stop:
j stop
nop
nop
;two nops because branch delay slot is 2
