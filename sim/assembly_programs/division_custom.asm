	addi r1, r0, #81
	addi r2, r0, #9
	jal proc_iterative_division
	nop
	nop
after_division_proc:
	j stop
	nop
	nop


; =====Procedure Iterative Division=====
;Gets on r1,r2 dividend and divisor 
;and store the result both in memory at address 0 and 
;and on register r5

proc_iterative_division:
	xor r3, r3, r3
	nop
	nop
	nop
divide:
	sne r5, r1, r2
	nop
	nop
	beqz r5, finish
	nop
	nop
	sub r1, r1, r2
	addi r3, r3, 1
	j divide
	nop
	nop
finish:
	add r4, r0, r1
	nop
	nop
	nop
	sw 0(r0), r4
	lw r5, 0(r0)
	j after_division_proc
	nop
	nop
; =====End Procedure Iterative Division=====


stop: 
	j stop
	nop
	nop
	nop
