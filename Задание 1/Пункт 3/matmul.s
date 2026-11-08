	.file	"matmul.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.def	"mul_ijk";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_ijk"
"mul_ijk":
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 24
	.seh_stackalloc	24
	.seh_endprologue
	mov	esi, DWORD PTR "n"[rip]
	test	esi, esi
	jle	.L1
	mov	eax, esi
	mov	edi, esi
	lea	r12, "c"[rip]
	xor	ebx, ebx
	lea	rax, [rax+rax*2]
	shr	edi
	lea	rbp, "b"[rip]
	mov	r11, r12
	mov	r10, rax
	sal	rax, 8
	mov	r13d, edi
	add	edi, edi
	mov	QWORD PTR 8[rsp], rax
	sal	r10, 11
	lea	r9, "a"[rip]
	sal	r13, 4
	lea	r14, 0[rbp+r10]
.L3:
	cmp	esi, 1
	je	.L11
.L9:
	lea	r15, 0[r13+r11]
	mov	rcx, r14
	mov	r8, r11
	.p2align 4
	.p2align 3
.L5:
	mov	rax, rcx
	movapd	xmm1, XMMWORD PTR [r8]
	mov	rdx, r9
	sub	rax, r10
	.p2align 6
	.p2align 4
	.p2align 3
.L4:
	movsd	xmm0, QWORD PTR [rdx]
	add	rax, 6144
	add	rdx, 8
	unpcklpd	xmm0, xmm0
	mulpd	xmm0, XMMWORD PTR -6144[rax]
	addpd	xmm1, xmm0
	cmp	rax, rcx
	jne	.L4
	movaps	XMMWORD PTR [r8], xmm1
	add	r8, 16
	lea	rcx, 16[rax]
	cmp	r8, r15
	jne	.L5
	cmp	edi, esi
	je	.L6
	mov	r8d, edi
.L10:
	mov	r15d, ebx
	mov	rcx, QWORD PTR 8[rsp]
	lea	rax, [r15+r15*2]
	sal	rax, 8
	lea	rdx, [r8+rcx]
	add	rax, r8
	lea	rcx, 0[rbp+rdx*8]
	mov	rdx, r9
	movsd	xmm1, QWORD PTR [r12+rax*8]
	lea	rax, 0[rbp+r8*8]
	.p2align 5
	.p2align 4
	.p2align 3
.L7:
	movsd	xmm0, QWORD PTR [rax]
	mulsd	xmm0, QWORD PTR [rdx]
	add	rax, 6144
	add	rdx, 8
	addsd	xmm1, xmm0
	cmp	rax, rcx
	jne	.L7
	lea	rax, [r15+r15*2]
	add	ebx, 1
	add	r9, 6144
	add	r11, 6144
	sal	rax, 8
	add	rax, r8
	movsd	QWORD PTR [r12+rax*8], xmm1
	cmp	ebx, esi
	jne	.L3
.L1:
	add	rsp, 24
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L6:
	add	ebx, 1
	add	r9, 6144
	add	r11, 6144
	cmp	edi, ebx
	jne	.L9
	jmp	.L1
.L11:
	xor	r8d, r8d
	jmp	.L10
	.seh_endproc
	.p2align 4
	.def	"mul_ikj";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_ikj"
"mul_ikj":
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	r11d, DWORD PTR "n"[rip]
	test	r11d, r11d
	jle	.L19
	mov	ebx, r11d
	lea	rsi, "c"[rip]
	xor	r14d, r14d
	mov	r12d, r11d
	shr	ebx
	mov	rdx, rsi
	lea	rdi, "a"[rip]
	mov	r8d, ebx
	lea	r13, "b"[rip]
	add	ebx, ebx
	sal	r8, 4
	.p2align 4
	.p2align 3
.L21:
	mov	eax, r14d
	lea	rcx, "b"[rip]
	xor	r9d, r9d
	lea	rbp, [rax+rax*2]
	sal	rbp, 8
	.p2align 4
	.p2align 3
.L23:
	movsd	xmm2, QWORD PTR [rdi+r9*8]
	mov	r10d, r9d
	cmp	r11d, 1
	je	.L29
.L27:
	movapd	xmm1, xmm2
	xor	eax, eax
	unpcklpd	xmm1, xmm1
	.p2align 5
	.p2align 4
	.p2align 3
.L25:
	movapd	xmm0, XMMWORD PTR [rcx+rax]
	mulpd	xmm0, xmm1
	addpd	xmm0, XMMWORD PTR [rdx+rax]
	movaps	XMMWORD PTR [rdx+rax], xmm0
	add	rax, 16
	cmp	r8, rax
	jne	.L25
	cmp	ebx, r11d
	je	.L22
	mov	eax, ebx
.L28:
	lea	r10, [r10+r10*2]
	lea	r15, 0[rbp+rax]
	add	r9, 1
	add	rcx, 6144
	sal	r10, 8
	add	r10, rax
	mulsd	xmm2, QWORD PTR 0[r13+r10*8]
	addsd	xmm2, QWORD PTR [rsi+r15*8]
	movsd	QWORD PTR [rsi+r15*8], xmm2
	cmp	r9, r12
	jne	.L23
.L24:
	add	r14d, 1
	add	rdx, 6144
	add	rdi, 6144
	cmp	r14d, r11d
	jne	.L21
.L19:
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.L22:
	add	r9, 1
	cmp	r9, r12
	je	.L24
	movsd	xmm2, QWORD PTR [rdi+r9*8]
	add	rcx, 6144
	mov	r10d, r9d
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L29:
	xor	eax, eax
	jmp	.L28
	.seh_endproc
	.p2align 4
	.def	"mul_jik";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_jik"
"mul_jik":
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	eax, DWORD PTR "n"[rip]
	test	eax, eax
	jle	.L34
	lea	r11, [rax+rax*2]
	lea	r10, "b"[rip]
	sal	r11, 11
	lea	rbx, "c"[rip]
	lea	rsi, "a"[rip]
	lea	rcx, [r10+r11]
	lea	rdi, [rbx+rax*8]
	add	r11, rsi
	.p2align 4
	.p2align 3
.L36:
	mov	r9, rsi
	mov	r8, rbx
	.p2align 4
	.p2align 3
.L39:
	movsd	xmm1, QWORD PTR [r8]
	mov	rax, r10
	mov	rdx, r9
	.p2align 5
	.p2align 4
	.p2align 3
.L37:
	movsd	xmm0, QWORD PTR [rdx]
	mulsd	xmm0, QWORD PTR [rax]
	add	rax, 6144
	add	rdx, 8
	addsd	xmm1, xmm0
	cmp	rax, rcx
	jne	.L37
	add	r9, 6144
	movsd	QWORD PTR [r8], xmm1
	add	r8, 6144
	cmp	r9, r11
	jne	.L39
	add	rbx, 8
	add	r10, 8
	add	rcx, 8
	cmp	rbx, rdi
	jne	.L36
.L34:
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	.seh_endproc
	.p2align 4
	.def	"mul_jki";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_jki"
"mul_jki":
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	eax, DWORD PTR "n"[rip]
	test	eax, eax
	jle	.L41
	lea	r10, 0[0+rax*8]
	lea	rdx, "c"[rip]
	lea	rbx, "a"[rip]
	lea	r8, [rax+rax*2]
	lea	rsi, [rdx+r10]
	lea	r11, "b"[rip]
	add	r10, rbx
	sal	r8, 11
	.p2align 4
	.p2align 3
.L43:
	mov	rcx, rbx
	mov	r9, r11
	.p2align 4
	.p2align 3
.L46:
	movsd	xmm1, QWORD PTR [r9]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L44:
	movsd	xmm0, QWORD PTR [rcx+rax]
	mulsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR [rdx+rax], xmm0
	add	rax, 6144
	cmp	r8, rax
	jne	.L44
	add	rcx, 8
	add	r9, 6144
	cmp	rcx, r10
	jne	.L46
	add	rdx, 8
	add	r11, 8
	cmp	rdx, rsi
	jne	.L43
.L41:
	pop	rbx
	pop	rsi
	ret
	.seh_endproc
	.p2align 4
	.def	"mul_kij";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_kij"
"mul_kij":
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	r11d, DWORD PTR "n"[rip]
	test	r11d, r11d
	jle	.L48
	mov	ebx, r11d
	lea	rbp, "b"[rip]
	xor	r12d, r12d
	shr	ebx
	mov	rcx, rbp
	lea	r13, "a"[rip]
	mov	r8d, ebx
	lea	rsi, "c"[rip]
	add	ebx, ebx
	sal	r8, 4
	.p2align 4
	.p2align 3
.L50:
	mov	eax, r12d
	lea	rdx, "c"[rip]
	mov	r10, r13
	xor	r9d, r9d
	lea	rdi, [rax+rax*2]
	sal	rdi, 8
	.p2align 4
	.p2align 3
.L52:
	movsd	xmm2, QWORD PTR [r10]
	cmp	r11d, 1
	je	.L58
.L56:
	movapd	xmm1, xmm2
	xor	eax, eax
	unpcklpd	xmm1, xmm1
	.p2align 5
	.p2align 4
	.p2align 3
.L54:
	movapd	xmm0, XMMWORD PTR [rcx+rax]
	mulpd	xmm0, xmm1
	addpd	xmm0, XMMWORD PTR [rdx+rax]
	movaps	XMMWORD PTR [rdx+rax], xmm0
	add	rax, 16
	cmp	r8, rax
	jne	.L54
	cmp	ebx, r11d
	je	.L51
	mov	r14d, ebx
.L57:
	mov	eax, r9d
	add	r9d, 1
	add	r10, 6144
	add	rdx, 6144
	lea	rax, [rax+rax*2]
	sal	rax, 8
	add	rax, r14
	add	r14, rdi
	mulsd	xmm2, QWORD PTR 0[rbp+r14*8]
	addsd	xmm2, QWORD PTR [rsi+rax*8]
	movsd	QWORD PTR [rsi+rax*8], xmm2
	cmp	r9d, r11d
	jne	.L52
.L53:
	add	r12d, 1
	add	rcx, 6144
	add	r13, 8
	cmp	r12d, r11d
	jne	.L50
.L48:
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.p2align 4,,10
	.p2align 3
.L51:
	add	r9d, 1
	cmp	r9d, ebx
	je	.L53
	add	r10, 6144
	add	rdx, 6144
	movsd	xmm2, QWORD PTR [r10]
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L58:
	xor	r14d, r14d
	jmp	.L57
	.seh_endproc
	.p2align 4
	.def	"mul_kji";	.scl	3;	.type	32;	.endef
	.seh_proc	"mul_kji"
"mul_kji":
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	ebx, DWORD PTR "n"[rip]
	test	ebx, ebx
	jle	.L62
	mov	esi, ebx
	mov	eax, ebx
	lea	rbp, "b"[rip]
	xor	r11d, r11d
	shr	esi
	lea	r8, [rax+rax*2]
	lea	rcx, "a"[rip]
	mov	r10, rbp
	mov	edi, esi
	sal	r8, 11
	lea	r12, "c"[rip]
	add	esi, esi
	sal	rdi, 4
.L64:
	cmp	ebx, 1
	je	.L72
.L70:
	lea	rdx, "c"[rip]
	lea	r13, [rdi+r10]
	mov	r9, r10
	.p2align 4
	.p2align 3
.L66:
	movapd	xmm1, XMMWORD PTR [r9]
	xor	eax, eax
	.p2align 6
	.p2align 4
	.p2align 3
.L65:
	movsd	xmm0, QWORD PTR [rcx+rax]
	unpcklpd	xmm0, xmm0
	mulpd	xmm0, xmm1
	addpd	xmm0, XMMWORD PTR [rdx+rax]
	movaps	XMMWORD PTR [rdx+rax], xmm0
	add	rax, 6144
	cmp	rax, r8
	jne	.L65
	add	r9, 16
	add	rdx, 16
	cmp	r9, r13
	jne	.L66
	cmp	esi, ebx
	je	.L67
	mov	edx, esi
.L71:
	mov	eax, r11d
	lea	rax, [rax+rax*2]
	sal	rax, 8
	add	rax, rdx
	lea	rdx, [r12+rdx*8]
	movsd	xmm1, QWORD PTR 0[rbp+rax*8]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L68:
	movsd	xmm0, QWORD PTR [rcx+rax]
	mulsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR [rdx+rax], xmm0
	add	rax, 6144
	cmp	rax, r8
	jne	.L68
	add	r11d, 1
	add	rcx, 8
	add	r10, 6144
	cmp	r11d, ebx
	jne	.L64
.L62:
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	ret
.L67:
	add	r11d, 1
	add	rcx, 8
	add	r10, 6144
	cmp	esi, r11d
	jne	.L70
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	ret
.L72:
	xor	edx, edx
	jmp	.L71
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "ijk\0"
.LC1:
	.ascii "ikj\0"
.LC2:
	.ascii "jik\0"
.LC3:
	.ascii "jki\0"
.LC4:
	.ascii "kij\0"
.LC5:
	.ascii "kji\0"
	.align 8
.LC6:
	.ascii "n,method,run,seconds,gflops,control\0"
.LC9:
	.ascii "%d,%s,%d,%.6f,%.3f,%.9f\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	"main"
	.def	"main";	.scl	2;	.type	32;	.endef
	.seh_proc	"main"
"main":
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 256
	.seh_stackalloc	256
	movaps	XMMWORD PTR 192[rsp], xmm6
	.seh_savexmm	xmm6, 192
	movaps	XMMWORD PTR 208[rsp], xmm7
	.seh_savexmm	xmm7, 208
	movaps	XMMWORD PTR 224[rsp], xmm8
	.seh_savexmm	xmm8, 224
	movaps	XMMWORD PTR 240[rsp], xmm9
	.seh_savexmm	xmm9, 240
	.seh_endprologue
	lea	r12, "c"[rip]
	call	"__main"
	lea	r13, 64[rsp]
	lea	rbp, 80[rsp]
	movabs	rax, 2199023255936
	mov	QWORD PTR 72[rsp], rax
	lea	rax, .LC0[rip]
	lea	rcx, .LC6[rip]
	mov	QWORD PTR 96[rsp], rax
	lea	rax, "mul_ijk"[rip]
	mov	QWORD PTR 104[rsp], rax
	lea	rax, .LC1[rip]
	mov	QWORD PTR 112[rsp], rax
	lea	rax, "mul_ikj"[rip]
	mov	QWORD PTR 120[rsp], rax
	lea	rax, .LC2[rip]
	mov	QWORD PTR 128[rsp], rax
	lea	rax, "mul_jik"[rip]
	mov	QWORD PTR 136[rsp], rax
	lea	rax, .LC3[rip]
	mov	QWORD PTR 144[rsp], rax
	lea	rax, "mul_jki"[rip]
	mov	QWORD PTR 152[rsp], rax
	lea	rax, .LC4[rip]
	mov	QWORD PTR 160[rsp], rax
	lea	rax, "mul_kij"[rip]
	mov	QWORD PTR 168[rsp], rax
	lea	rax, .LC5[rip]
	mov	QWORD PTR 176[rsp], rax
	lea	rax, "mul_kji"[rip]
	mov	DWORD PTR 68[rsp], 256
	mov	QWORD PTR 184[rsp], rax
	call	"puts"
	movsd	xmm7, QWORD PTR .LC8[rip]
	mov	eax, 128
	movsd	xmm8, QWORD PTR .LC10[rip]
	movsd	xmm6, QWORD PTR .LC7[rip]
.L90:
	mov	DWORD PTR "n"[rip], eax
	test	eax, eax
	jle	.L80
	lea	rdi, "a"[rip]
	lea	rsi, "b"[rip]
	xor	r14d, r14d
.L82:
	xor	ebx, ebx
	.p2align 4
	.p2align 3
.L81:
	call	"rand"
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, xmm6
	movsd	QWORD PTR [rdi+rbx*8], xmm0
	call	"rand"
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, xmm6
	mov	eax, DWORD PTR "n"[rip]
	movsd	QWORD PTR [rsi+rbx*8], xmm0
	add	rbx, 1
	cmp	eax, ebx
	jg	.L81
	add	r14d, 1
	add	rdi, 6144
	add	rsi, 6144
	cmp	eax, r14d
	jg	.L82
.L80:
	lea	rdi, 96[rsp]
.L83:
	mov	esi, 1
.L88:
	test	eax, eax
	jle	.L86
	lea	r14, [rax+rax*2]
	lea	rcx, "c"[rip]
	sal	r14, 11
	lea	rbx, 0[0+rax*8]
	add	r14, r12
	.p2align 4
	.p2align 3
.L84:
	mov	r8, rbx
	xor	edx, edx
	call	"memset"
	lea	rcx, 6144[rax]
	cmp	rcx, r14
	jne	.L84
.L86:
	mov	rdx, rbp
	mov	ecx, 1
	pxor	xmm9, xmm9
	call	"clock_gettime64"
	cvtsi2sd	xmm9, DWORD PTR 88[rsp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR 80[rsp]
	mulsd	xmm9, xmm7
	addsd	xmm9, xmm0
	call	[QWORD PTR 8[rdi]]
	mov	rdx, rbp
	mov	ecx, 1
	call	"clock_gettime64"
	pxor	xmm1, xmm1
	pxor	xmm0, xmm0
	mov	r9d, esi
	cvtsi2sd	xmm1, DWORD PTR 88[rsp]
	mulsd	xmm1, xmm7
	pxor	xmm2, xmm2
	cvtsi2sd	xmm0, QWORD PTR 80[rsp]
	mov	edx, DWORD PTR "n"[rip]
	lea	rcx, .LC9[rip]
	add	esi, 1
	cvtsi2sd	xmm2, edx
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR 43064[r12]
	movsd	QWORD PTR 48[rsp], xmm0
	movapd	xmm0, xmm2
	addsd	xmm0, xmm2
	subsd	xmm1, xmm9
	mulsd	xmm0, xmm2
	movsd	QWORD PTR 32[rsp], xmm1
	mulsd	xmm0, xmm2
	divsd	xmm0, xmm1
	divsd	xmm0, xmm8
	movsd	QWORD PTR 40[rsp], xmm0
	mov	r8, QWORD PTR [rdi]
	call	__mingw_printf
	cmp	esi, 6
	je	.L85
	mov	eax, DWORD PTR "n"[rip]
	jmp	.L88
.L85:
	add	rdi, 16
	lea	rax, 192[rsp]
	cmp	rdi, rax
	je	.L87
	mov	eax, DWORD PTR "n"[rip]
	jmp	.L83
.L87:
	add	r13, 4
	cmp	r13, rbp
	je	.L89
	mov	eax, DWORD PTR 0[r13]
	jmp	.L90
.L89:
	movaps	xmm6, XMMWORD PTR 192[rsp]
	xor	eax, eax
	movaps	xmm7, XMMWORD PTR 208[rsp]
	movaps	xmm8, XMMWORD PTR 224[rsp]
	movaps	xmm9, XMMWORD PTR 240[rsp]
	add	rsp, 256
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.seh_endproc
.lcomm "c",4718592,32
.lcomm "b",4718592,32
.lcomm "a",4718592,32
.lcomm "n",4,4
	.section .rdata,"dr"
	.align 8
.LC7:
	.long	0
	.long	1088421824
	.align 8
.LC8:
	.long	-400107883
	.long	1041313291
	.align 8
.LC10:
	.long	0
	.long	1104006501
	.def	"__main";	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 16.2.0"
	.def	"puts";	.scl	2;	.type	32;	.endef
	.def	"rand";	.scl	2;	.type	32;	.endef
	.def	"memset";	.scl	2;	.type	32;	.endef
	.def	"clock_gettime64";	.scl	2;	.type	32;	.endef
