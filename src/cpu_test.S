	.syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
	.section .text
	.thumb_func
	.global cputst_work
	.type cputst_work, %function
cputst_work:
	// TODO Arithmetic operation
	// Unsigned 8-bit addition
	ldr r0, =125
	ldr r1, =120
	add r0, r0, r1
	ldr r2, =245
	cmp r0, r2
	bne cputst_work_failed
	bcs cputst_work_failed
	bmi cputst_work_failed
	bvs cputst_work_failed

	// Unsigned 16-bit addition
	ldr r0, =5789
	ldr r1, =8945
	add r0, r0, r1
	ldr r2, =14734
	cmp r0, r2
	bne cputst_work_failed
	bcs cputst_work_failed
	bmi cputst_work_failed
	bvs cputst_work_failed

	// Unsigned 32-bit addition
	ldr r0, =5789
	ldr r1, =8945
	add r0, r0, r1
	ldr r2, =14734
	cmp r0, r2
	bne cputst_work_failed
	bcs cputst_work_failed
	bmi cputst_work_failed
	bvs cputst_work_failed

	// TODO Conditional branches
	// TODO Unconditional branches
	// TODO Stack Pop and Push operations

	mov r0, #1
	mov pc, lr

cputst_work_failed:
	mov r0, #0
	mov pc, lr
	
