
test.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <multiply_matrices>:
   0:	e92d07f0 	push	{r4, r5, r6, r7, r8, r9, sl}
   4:	e3a06000 	mov	r6, #0
   8:	e59fa07c 	ldr	sl, [pc, #124]	; 8c <multiply_matrices+0x8c>
   c:	e59f407c 	ldr	r4, [pc, #124]	; 90 <multiply_matrices+0x90>
  10:	e59f807c 	ldr	r8, [pc, #124]	; 94 <multiply_matrices+0x94>
  14:	e3a07e7d 	mov	r7, #2000	; 0x7d0
  18:	e0050697 	mul	r5, r7, r6
  1c:	e3a00000 	mov	r0, #0
  20:	e2455004 	sub	r5, r5, #4
  24:	e088c005 	add	ip, r8, r5
  28:	e08a5005 	add	r5, sl, r5
  2c:	eddf7a15 	vldr	s15, [pc, #84]	; 88 <multiply_matrices+0x88>
  30:	e1a01005 	mov	r1, r5
  34:	e0842100 	add	r2, r4, r0, lsl #2
  38:	e3a03000 	mov	r3, #0
  3c:	e2811004 	add	r1, r1, #4
  40:	ed927a00 	vldr	s14, [r2]
  44:	edd16a00 	vldr	s13, [r1]
  48:	e2833001 	add	r3, r3, #1
  4c:	e3530f7d 	cmp	r3, #500	; 0x1f4
  50:	e1a09001 	mov	r9, r1
  54:	ee467a87 	vmla.f32	s15, s13, s14
  58:	e2822e7d 	add	r2, r2, #2000	; 0x7d0
  5c:	1afffff6 	bne	3c <multiply_matrices+0x3c>
  60:	ee173a90 	vmov	r3, s15
  64:	e2800001 	add	r0, r0, #1
  68:	e3500f7d 	cmp	r0, #500	; 0x1f4
  6c:	e5ac3004 	str	r3, [ip, #4]!
  70:	1affffed 	bne	2c <multiply_matrices+0x2c>
  74:	e2866001 	add	r6, r6, #1
  78:	e3560f7d 	cmp	r6, #500	; 0x1f4
  7c:	1affffe5 	bne	18 <multiply_matrices+0x18>
  80:	e8bd07f0 	pop	{r4, r5, r6, r7, r8, r9, sl}
  84:	e12fff1e 	bx	lr
	...

00000098 <initialize_matrices>:
  98:	e92d4ff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
  9c:	e3a0a000 	mov	sl, #0
  a0:	e59fb068 	ldr	fp, [pc, #104]	; 110 <initialize_matrices+0x78>
  a4:	e3a09e7d 	mov	r9, #2000	; 0x7d0
  a8:	e3a08000 	mov	r8, #0
  ac:	e0050a99 	mul	r5, r9, sl
  b0:	e59f305c 	ldr	r3, [pc, #92]	; 114 <initialize_matrices+0x7c>
  b4:	e2455004 	sub	r5, r5, #4
  b8:	e0837005 	add	r7, r3, r5
  bc:	e59f3054 	ldr	r3, [pc, #84]	; 118 <initialize_matrices+0x80>
  c0:	e3a04f7d 	mov	r4, #500	; 0x1f4
  c4:	e0836005 	add	r6, r3, r5
  c8:	e08b5005 	add	r5, fp, r5
  cc:	ebfffffe 	bl	0 <rand>
  d0:	ee070a10 	vmov	s14, r0
  d4:	eef87ac7 	vcvt.f32.s32	s15, s14
  d8:	ee173a90 	vmov	r3, s15
  dc:	e5a73004 	str	r3, [r7, #4]!
  e0:	ebfffffe 	bl	0 <rand>
  e4:	e2544001 	subs	r4, r4, #1
  e8:	e5a58004 	str	r8, [r5, #4]!
  ec:	ee070a10 	vmov	s14, r0
  f0:	eef87ac7 	vcvt.f32.s32	s15, s14
  f4:	ee173a90 	vmov	r3, s15
  f8:	e5a63004 	str	r3, [r6, #4]!
  fc:	1afffff2 	bne	cc <initialize_matrices+0x34>
 100:	e28aa001 	add	sl, sl, #1
 104:	e35a0f7d 	cmp	sl, #500	; 0x1f4
 108:	1affffe7 	bne	ac <initialize_matrices+0x14>
 10c:	e8bd8ff8 	pop	{r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
	...

Disassembly of section .text.startup:

00000000 <main>:
   0:	e92d4008 	push	{r3, lr}
   4:	ebfffffe 	bl	98 <initialize_matrices>
   8:	ebfffffe 	bl	0 <main>
   c:	e8bd8008 	pop	{r3, pc}
