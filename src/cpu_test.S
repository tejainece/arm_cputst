	.syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
	.section .text
	.thumb_func
	.global cputst_work
	.type cputst_work, %function
cputst_work:
	// Unconditional branches
branch_unconditional:
	b branch_conditional
	b cputst_work_failed

	// Conditional branches
branch_conditional:
	// Branch if-equal
branch_eq:
	ldr r0, =125
	ldr r1, =125
	ldr r2, =200
	
	cmp r0, r1
	beq branch_lt
	b cputst_work_failed
	
	// Branch if-less-than
branch_lt:
	cmp r0, r2
	blt branch_gt
	b cputst_work_failed
	
	// Branch if-greater-than
branch_gt:
	cmp r2, r1
	bgt branch_cs
	b cputst_work_failed


	// Branch if-carry-set
branch_cs:
	ldr r0, =2294967295 
	ldr r1, =2223456789
	adds r0, r0, r1
	bcs branch_cc	
	b cputst_work_failed
	
	// Branch if-carry-clear
branch_cc:
	ldr r0, =5789
	ldr r1, =8945
	adds r0, r0, r1
	bcc branch_tests_success	
	b cputst_work_failed
	
branch_tests_success:

	// Arithmetic operations
	// add instruction tests
add:
	// Unsigned 16-bit addition
	ldr r0, =5789
	ldr r1, =8945
	add r0, r0, r1
	ldr r2, =14734
	cmp r0, r2
	bne cputst_work_failed
	
adds:
	// Unsigned 16-bit addition
	ldr r0, =5789
	ldr r1, =8945
	adds r0, r0, r1
	beq cputst_work_failed
	bcs cputst_work_failed
	bmi cputst_work_failed
	bvs cputst_work_failed
	ldr r2, =14734
	cmp r0, r2
	bne cputst_work_failed

adds_negative_overflow:
	// Unsigned 32-bit addition
	ldr r0, =2094967295 
	ldr r1, =2123456789
	adds r0, r0, r1
	beq cputst_work_failed
	bcs cputst_work_failed
	bpl cputst_work_failed
	bvc cputst_work_failed
	ldr r2, =4218424084
	cmp r0, r2
	bne cputst_work_failed

adds_carry:
	// Unsigned 32-bit addition
	ldr r0, =2294967295 
	ldr r1, =2323456789
	adds r0, r0, r1
	beq cputst_work_failed
	bcc cputst_work_failed
	bmi cputst_work_failed
	bvc cputst_work_failed
	ldr r2, =323456788
	cmp r0, r2
	bne cputst_work_failed
	
	//TODO subtract
	
	//TODO multiply
	
	//TODO divide
	
	// Stack Pop and Push operations
	// Push and pop byte, halfword and word to and from stack
stack:
	mov r0, sp
	mov r1, r7
	push	{r7}
	sub r0, r0, #4
	cmp sp, r0
	bne cputst_work_failed
	add r0, r0, #4
	
	sub	sp, sp, #20
	add	r7, sp, #0
	ldr	r3, =6
	strb	r3, [r7, #15]
	ldr	r3, =314
	strh	r3, [r7, #12]	@ movhi
	ldr	r3, =68902
	str	r3, [r7, #8]
	ldrb	r3, [r7, #15]	@ zero_extendqisi2
	ldr	r2, =6
	cmp r3, r2
	bne cputst_work_failed
	ldrh	r3, [r7, #12]
	ldr	r2, =314
	cmp r3, r2
	bne cputst_work_failed
	ldr	r3, [r7, #8]
	ldr	r2, =68902
	cmp r3, r2
	bne cputst_work_failed
	
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4

cputst_work_success:
	mov r0, #1
	mov pc, lr

cputst_work_failed:
	mov r0, #0
	mov pc, lr
	
