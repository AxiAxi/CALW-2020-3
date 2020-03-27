.syntax unified
.cpu cortex-m4
.thumb

#define A #8
#define B #5
#define C #3

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	start: .asciz "Kernel started...\n"
	finish: .asciz "Kernel finished. Register #5 value: "

.section .text
__kernel_reset__:
	ldr r0, =start
	bl dbgput_line

	mov r0, #1
	mov r1, A
	mov r2, B
	mov r3, C
	mov r4, #3

	lsl r0, r0, r3
	sub r1, r2
	mla r5, r1, r4, r0

	ldr r0, =finish
	bl dbgput
	mov r0, r5
	bl dbgput_num

	end:
		b end

