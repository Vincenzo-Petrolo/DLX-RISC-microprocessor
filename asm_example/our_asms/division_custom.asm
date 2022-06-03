addi r1, r0, 81
addi r2, r0, 9
xor r3, r3, r3
	nop
	nop
	nop
divide:
	sne r5, r1, r2
	nop
	nop
	nop
	beqz r5, finish
	nop
	nop
	nop
	sub r1, r1, r2
	addi r3, r3, 1
	j divide
	nop
	nop
	nop
finish:
add r4, r0, r1
stop: 
j stop
nop
nop
nop
