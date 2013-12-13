	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"test.c"
	.text
	.align	2
	.global	multiply_matrices
	.type	multiply_matrices, %function
multiply_matrices:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	mov	r6, #0
	ldr	sl, .L9+4
	ldr	r4, .L9+8
	ldr	r8, .L9+12
	mov	r7, #2000
.L2:
	mul	r5, r7, r6
	mov	r0, #0
	sub	r5, r5, #4
	add	ip, r8, r5
	add	r5, sl, r5
.L6:
	flds	s15, .L9
	mov	r1, r5
	add	r2, r4, r0, asl #2
	mov	r3, #0
.L3:
	add	r1, r1, #4
	flds	s14, [r2, #0]
	flds	s13, [r1, #0]
	add	r3, r3, #1
	cmp	r3, #500
	mov	r9, r1
	fmacs	s15, s13, s14
	add	r2, r2, #2000
	bne	.L3
	fmrs	r3, s15
	add	r0, r0, #1
	cmp	r0, #500
	str	r3, [ip, #4]!	@ float
	bne	.L6
	add	r6, r6, #1
	cmp	r6, #500
	bne	.L2
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	bx	lr
.L10:
	.align	2
.L9:
	.word	0
	.word	matrix_a
	.word	matrix_b
	.word	matrix_r
	.size	multiply_matrices, .-multiply_matrices
	.align	2
	.global	initialize_matrices
	.type	initialize_matrices, %function
initialize_matrices:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	sl, #0
	ldr	fp, .L16
	mov	r9, #2000
	mov	r8, #0
.L12:
	mul	r5, r9, sl
	ldr	r3, .L16+4
	sub	r5, r5, #4
	add	r7, r3, r5
	ldr	r3, .L16+8
	mov	r4, #500
	add	r6, r3, r5
	add	r5, fp, r5
.L13:
	bl	rand
	fmsr	s14, r0	@ int
	fsitos	s15, s14
	fmrs	r3, s15
	str	r3, [r7, #4]!	@ float
	bl	rand
	subs	r4, r4, #1
	str	r8, [r5, #4]!	@ float
	fmsr	s14, r0	@ int
	fsitos	s15, s14
	fmrs	r3, s15
	str	r3, [r6, #4]!	@ float
	bne	.L13
	add	sl, sl, #1
	cmp	sl, #500
	bne	.L12
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L17:
	.align	2
.L16:
	.word	matrix_r
	.word	matrix_a
	.word	matrix_b
	.size	initialize_matrices, .-initialize_matrices
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	bl	initialize_matrices
	bl	multiply_matrices
	ldmfd	sp!, {r3, pc}
	.size	main, .-main
	.comm	matrix_r,1000000,4
	.comm	matrix_b,1000000,4
	.comm	matrix_a,1000000,4
	.ident	"GCC: (Debian 4.6.3-14+rpi1) 4.6.3"
	.section	.note.GNU-stack,"",%progbits
