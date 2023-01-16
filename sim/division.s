	addi	r2,r0,#256
	nop	
	nop	
	nop	
main:
	addi	r2,r2,#-32
	nop	
	nop	
	nop	
	sw	28(r2),r8
	addi	r8,r2,#32
	nop	
	nop	
	nop	
	sw	-20(r8),r0
	addi	r15,#0,#100
	nop	
	nop	
	nop	
	sw	-24(r8),r15
	addi	r15,#0,#34
	nop	
	nop	
	nop	
	sw	-28(r8),r15
	j	L2
	nop	
	nop	
L3:
	lw	r14,-24(r8)
	nop	
	nop	
	lw	r15,-28(r8)
	nop	
	nop	
	nop	
	sub	r15,r14,r15
	nop	
	nop	
	nop	
	sw	-24(r8),r15
	lw	r15,-20(r8)
	nop	
	nop	
	nop	
	addi	r15,r15,#1
	nop	
	nop	
	nop	
	sw	-20(r8),r15
L2:
	lw	r14,-24(r8)
	nop	
	nop	
	lw	r15,-28(r8)
	nop	
	nop	
	nop	
	sub	r15,r14,r15
	nop	
	nop	
	nop	
	sge	r28,r15,r0
	nop	
	nop	
	nop	
	bnez	r28,L3
	nop	
	nop	
	lw	r15,-20(r8)
	nop	
	nop	
	nop	
	addi	r10,r15,#0
	lw	r8,28(r2)
	addi	r2,r2,#32
	jr	r31
	nop	
	nop	
