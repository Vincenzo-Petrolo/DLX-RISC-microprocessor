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
	addi	r15,#0,#1
	nop	
	nop	
	nop	
	sw	-20(r8),r15
	addi	r15,#0,#3
	nop	
	nop	
	nop	
	sw	-24(r8),r15
	lw	r14,-20(r8)
	nop	
	nop	
	lw	r15,-24(r8)
	nop	
	nop	
	nop	
	add	r15,r14,r15
	nop	
	nop	
	nop	
	sw	-28(r8),r15
	lw	r15,-28(r8)
	nop	
	nop	
	nop	
	addi	r10,r15,#0
	lw	r8,28(r2)
	addi	r2,r2,#32
	jr	r31
	nop	
	nop	
