	.syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
	.section .text
	.thumb_func
	.global cputst_work
	.type cputst_work, %function
cputst_work:
	add r0, r0, r1
	mov pc, lr
	
