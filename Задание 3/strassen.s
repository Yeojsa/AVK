	.file	"strassen.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.def	"naive";	.scl	3;	.type	32;	.endef
	.seh_proc	"naive"
"naive":
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
	mov	esi, DWORD PTR "n"[rip]
	test	esi, esi
	jle	.L1
	mov	r14d, esi
	mov	edi, esi
	lea	r10, "a"[rip]
	mov	r11, rcx
	mov	rbp, r14
	shr	edi
	lea	rbx, "b"[rip]
	sal	rbp, 13
	mov	r12d, edi
	sal	r14, 10
	add	edi, edi
	lea	r13, [r10+rbp]
	sal	r12, 4
	add	rbp, rbx
.L3:
	cmp	esi, 1
	je	.L11
.L9:
	lea	r15, [r12+r11]
	mov	rcx, rbp
	mov	r8, r11
	mov	r9, rbx
	.p2align 4
	.p2align 3
.L5:
	mov	rdx, r10
	mov	rax, r9
	pxor	xmm1, xmm1
	.p2align 6
	.p2align 4
	.p2align 3
.L4:
	movsd	xmm0, QWORD PTR [rdx]
	add	rax, 8192
	add	rdx, 8
	unpcklpd	xmm0, xmm0
	mulpd	xmm0, XMMWORD PTR -8192[rax]
	addpd	xmm1, xmm0
	cmp	rax, rcx
	jne	.L4
	movaps	XMMWORD PTR [r8], xmm1
	add	r8, 16
	add	r9, 16
	lea	rcx, 16[rax]
	cmp	r8, r15
	jne	.L5
	cmp	esi, edi
	je	.L6
	mov	r8d, edi
.L10:
	lea	rdx, [r8+r14]
	lea	rax, [rbx+r8*8]
	pxor	xmm1, xmm1
	lea	rcx, [rbx+rdx*8]
	mov	rdx, r10
	.p2align 5
	.p2align 4
	.p2align 3
.L7:
	movsd	xmm0, QWORD PTR [rax]
	mulsd	xmm0, QWORD PTR [rdx]
	add	rax, 8192
	add	rdx, 8
	addsd	xmm1, xmm0
	cmp	rax, rcx
	jne	.L7
	add	r10, 8192
	movsd	QWORD PTR [r11+r8*8], xmm1
	add	r11, 8192
	cmp	r10, r13
	jne	.L3
.L1:
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
	add	r10, 8192
	cmp	r10, r13
	je	.L1
	add	r11, 8192
	jmp	.L9
.L11:
	xor	r8d, r8d
	jmp	.L10
	.seh_endproc
	.p2align 4
	.def	"strassen_rec";	.scl	3;	.type	32;	.endef
	.seh_proc	"strassen_rec"
"strassen_rec":
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
	sub	rsp, 200
	.seh_stackalloc	200
	.seh_endprologue
	mov	QWORD PTR 160[rsp], r9
	mov	ebp, ecx
	mov	rdi, rdx
	mov	r12, r8
	cmp	ecx, 64
	jle	.L57
	mov	ebx, ecx
	sar	ebx
	mov	esi, ebx
	mov	DWORD PTR 36[rsp], ebx
	imul	esi, ebx
	sal	rsi, 3
	mov	rcx, rsi
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 40[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 64[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 72[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 48[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	r15, rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 80[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 88[rsp], rax
	call	"malloc"
	mov	QWORD PTR 104[rsp], rsi
	mov	QWORD PTR 56[rsp], rax
	mov	eax, ebp
	imul	ebp, ebx
	lea	rdx, 0[0+rax*8]
	mov	eax, ebx
	mov	QWORD PTR 96[rsp], r15
	xor	r15d, r15d
	lea	rbx, 0[0+rax*8]
	mov	QWORD PTR 168[rsp], rdx
	mov	rsi, rdx
	add	rax, rbp
	lea	r14, 0[0+rbp*8]
	xor	ebp, ebp
	sal	rax, 3
	mov	QWORD PTR 176[rsp], r14
	mov	QWORD PTR 184[rsp], rax
	mov	r13, rax
	.p2align 4
	.p2align 3
.L27:
	mov	rax, QWORD PTR 40[rsp]
	mov	rdx, rdi
	mov	r8, rbx
	add	r15d, 1
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 64[rsp]
	lea	rdx, [rbx+rdi]
	mov	r8, rbx
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 72[rsp]
	lea	rdx, [rdi+r14]
	mov	r8, rbx
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 48[rsp]
	lea	rdx, [rdi+r13]
	mov	r8, rbx
	add	rdi, rsi
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 96[rsp]
	mov	rdx, r12
	mov	r8, rbx
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 80[rsp]
	lea	rdx, [rbx+r12]
	mov	r8, rbx
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 88[rsp]
	lea	rdx, [r12+r14]
	mov	r8, rbx
	lea	rcx, [rax+rbp]
	call	"memcpy"
	mov	rax, QWORD PTR 56[rsp]
	lea	rdx, [r12+r13]
	mov	r8, rbx
	add	r12, rsi
	lea	rcx, [rax+rbp]
	add	rbp, rbx
	call	"memcpy"
	cmp	DWORD PTR 36[rsp], r15d
	jne	.L27
	mov	rsi, QWORD PTR 104[rsp]
	mov	r15, QWORD PTR 96[rsp]
	mov	rcx, rsi
	call	"malloc"
	mov	rcx, rsi
	mov	rdi, rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 96[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 104[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 112[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 120[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 128[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 136[rsp], rax
	call	"malloc"
	mov	rcx, rsi
	mov	QWORD PTR 144[rsp], rax
	call	"malloc"
	mov	rdx, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 48[rsp]
	mov	QWORD PTR 152[rsp], rax
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L28:
	movsd	xmm0, QWORD PTR [rdx+rax]
	addsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [rdi+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L28
	mov	rdx, QWORD PTR 56[rsp]
	mov	rcx, QWORD PTR 96[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L29:
	movsd	xmm0, QWORD PTR [r15+rax]
	addsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR [rcx+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L29
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 104[rsp]
	mov	rdx, rdi
	mov	r8, QWORD PTR 96[rsp]
	call	"strassen_rec"
	mov	rdx, QWORD PTR 72[rsp]
	mov	rcx, QWORD PTR 48[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L30:
	movsd	xmm0, QWORD PTR [rdx+rax]
	addsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [rdi+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L30
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 112[rsp]
	mov	r8, r15
	mov	rdx, rdi
	call	"strassen_rec"
	mov	rdx, QWORD PTR 80[rsp]
	mov	rcx, QWORD PTR 56[rsp]
	xor	eax, eax
	mov	r8, QWORD PTR 96[rsp]
	.p2align 5
	.p2align 4
	.p2align 3
.L31:
	movsd	xmm0, QWORD PTR [rdx+rax]
	subsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [r8+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L31
	mov	r14, QWORD PTR 96[rsp]
	mov	rdx, QWORD PTR 40[rsp]
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 120[rsp]
	mov	r8, r14
	call	"strassen_rec"
	mov	rdx, QWORD PTR 88[rsp]
	xor	eax, eax
	mov	rcx, r14
	.p2align 5
	.p2align 4
	.p2align 3
.L32:
	movsd	xmm0, QWORD PTR [rdx+rax]
	subsd	xmm0, QWORD PTR [r15+rax]
	movsd	QWORD PTR [rcx+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L32
	mov	rdx, QWORD PTR 48[rsp]
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 128[rsp]
	mov	r8, QWORD PTR 96[rsp]
	call	"strassen_rec"
	mov	rdx, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 64[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L33:
	movsd	xmm0, QWORD PTR [rdx+rax]
	addsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [rdi+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L33
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 136[rsp]
	mov	rdx, rdi
	mov	r8, QWORD PTR 56[rsp]
	call	"strassen_rec"
	mov	rdx, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 72[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L34:
	movsd	xmm0, QWORD PTR [rcx+rax]
	subsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR [rdi+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L34
	mov	rdx, QWORD PTR 80[rsp]
	mov	rcx, QWORD PTR 96[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L35:
	movsd	xmm0, QWORD PTR [r15+rax]
	addsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR [rcx+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L35
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, QWORD PTR 144[rsp]
	mov	rdx, rdi
	mov	r8, QWORD PTR 96[rsp]
	call	"strassen_rec"
	mov	rdx, QWORD PTR 64[rsp]
	mov	rcx, QWORD PTR 48[rsp]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L36:
	movsd	xmm0, QWORD PTR [rdx+rax]
	subsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [rdi+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L36
	mov	rdx, QWORD PTR 88[rsp]
	mov	rcx, QWORD PTR 56[rsp]
	xor	eax, eax
	mov	r8, QWORD PTR 96[rsp]
	.p2align 5
	.p2align 4
	.p2align 3
.L37:
	movsd	xmm0, QWORD PTR [rdx+rax]
	addsd	xmm0, QWORD PTR [rcx+rax]
	movsd	QWORD PTR [r8+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L37
	mov	rbp, QWORD PTR 152[rsp]
	mov	r8, QWORD PTR 96[rsp]
	mov	rdx, rdi
	mov	ecx, DWORD PTR 36[rsp]
	mov	r9, rbp
	call	"strassen_rec"
	mov	r14, QWORD PTR 104[rsp]
	mov	rsi, QWORD PTR 120[rsp]
	mov	r8, QWORD PTR 160[rsp]
	mov	rcx, QWORD PTR 176[rsp]
	mov	QWORD PTR 176[rsp], rdi
	mov	rdx, QWORD PTR 184[rsp]
	mov	r13, QWORD PTR 128[rsp]
	mov	QWORD PTR 160[rsp], r15
	xor	r15d, r15d
	mov	r12, QWORD PTR 136[rsp]
	mov	r10, QWORD PTR 112[rsp]
	lea	r11, [r8+rbx]
	add	rcx, r8
	mov	r9, QWORD PTR 144[rsp]
	mov	rdi, QWORD PTR 168[rsp]
	add	rdx, r8
	.p2align 4
	.p2align 3
.L38:
	xor	eax, eax
	.p2align 4
	.p2align 3
.L39:
	movsd	xmm0, QWORD PTR [r14+rax]
	movsd	xmm2, QWORD PTR 0[r13+rax]
	movsd	xmm3, QWORD PTR [r12+rax]
	movapd	xmm1, xmm0
	addsd	xmm1, xmm2
	subsd	xmm1, xmm3
	addsd	xmm1, QWORD PTR 0[rbp+rax]
	movsd	QWORD PTR [r8+rax], xmm1
	movsd	xmm1, QWORD PTR [rsi+rax]
	addsd	xmm3, xmm1
	movsd	QWORD PTR [r11+rax], xmm3
	movsd	xmm3, QWORD PTR [r10+rax]
	subsd	xmm0, xmm3
	addsd	xmm2, xmm3
	addsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR [r9+rax]
	movsd	QWORD PTR [rcx+rax], xmm2
	movsd	QWORD PTR [rdx+rax], xmm0
	add	rax, 8
	cmp	rax, rbx
	jne	.L39
	add	r15d, 1
	add	r14, rax
	add	r13, rax
	add	r12, rax
	add	rbp, rax
	add	r8, rdi
	add	rsi, rax
	add	r11, rdi
	add	r10, rax
	add	rcx, rdi
	add	r9, rax
	add	rdx, rdi
	cmp	DWORD PTR 36[rsp], r15d
	jne	.L38
	mov	rcx, QWORD PTR 40[rsp]
	mov	r15, QWORD PTR 160[rsp]
	mov	rdi, QWORD PTR 176[rsp]
	call	"free"
	mov	rcx, QWORD PTR 64[rsp]
	call	"free"
	mov	rcx, QWORD PTR 72[rsp]
	call	"free"
	mov	rcx, QWORD PTR 48[rsp]
	call	"free"
	mov	rcx, r15
	call	"free"
	mov	rcx, QWORD PTR 80[rsp]
	call	"free"
	mov	rcx, QWORD PTR 88[rsp]
	call	"free"
	mov	rcx, QWORD PTR 56[rsp]
	call	"free"
	mov	rcx, rdi
	call	"free"
	mov	rcx, QWORD PTR 96[rsp]
	call	"free"
	mov	rcx, QWORD PTR 104[rsp]
	call	"free"
	mov	rcx, QWORD PTR 112[rsp]
	call	"free"
	mov	rcx, QWORD PTR 120[rsp]
	call	"free"
	mov	rcx, QWORD PTR 128[rsp]
	call	"free"
	mov	rcx, QWORD PTR 136[rsp]
	call	"free"
	mov	rcx, QWORD PTR 144[rsp]
	call	"free"
	mov	rcx, QWORD PTR 152[rsp]
	add	rsp, 200
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	jmp	"free"
.L57:
	test	ecx, ecx
	jle	.L18
	mov	rbx, QWORD PTR 160[rsp]
	mov	esi, ecx
	xor	r13d, r13d
	sal	rsi, 3
	mov	rcx, rbx
	.p2align 4
	.p2align 3
.L23:
	mov	r8, rsi
	xor	edx, edx
	add	r13d, 1
	call	"memset"
	lea	rcx, [rax+rsi]
	cmp	ebp, r13d
	jne	.L23
	add	rdi, rsi
	xor	r8d, r8d
	.p2align 4
	.p2align 3
.L22:
	mov	rcx, rdi
	mov	rdx, r12
	sub	rcx, rsi
	.p2align 4
	.p2align 3
.L26:
	movsd	xmm1, QWORD PTR [rcx]
	xor	eax, eax
	.p2align 5
	.p2align 4
	.p2align 3
.L25:
	movsd	xmm0, QWORD PTR [rdx+rax]
	mulsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR [rbx+rax]
	movsd	QWORD PTR [rbx+rax], xmm0
	add	rax, 8
	cmp	rsi, rax
	jne	.L25
	add	rcx, 8
	add	rdx, rsi
	cmp	rdi, rcx
	jne	.L26
	lea	eax, 1[r8]
	add	rdi, rsi
	add	rbx, rsi
	cmp	r13d, eax
	je	.L18
	mov	r8d, eax
	jmp	.L22
.L18:
	add	rsp, 200
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "strassen\0"
.LC2:
	.ascii "naive\0"
	.align 8
.LC3:
	.ascii "n,method,run,seconds,gflops,maxdiff\0"
.LC7:
	.ascii "%d,%s,%d,%.6f,%.3f,%.3e\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	"main"
	.def	"main";	.scl	2;	.type	32;	.endef
	.seh_proc	"main"
"main":
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
	sub	rsp, 216
	.seh_stackalloc	216
	movaps	XMMWORD PTR 160[rsp], xmm6
	.seh_savexmm	xmm6, 160
	movaps	XMMWORD PTR 176[rsp], xmm7
	.seh_savexmm	xmm7, 176
	movaps	XMMWORD PTR 192[rsp], xmm8
	.seh_savexmm	xmm8, 192
	.seh_endprologue
	mov	edi, 128
	call	"__main"
	lea	rcx, .LC3[rip]
	movabs	rax, 4398046511616
	mov	DWORD PTR 132[rsp], 256
	mov	QWORD PTR 136[rsp], rax
	lea	rbx, 128[rsp]
	call	"puts"
	movsd	xmm6, QWORD PTR .LC5[rip]
	movsd	xmm7, QWORD PTR .LC8[rip]
.L79:
	mov	DWORD PTR "n"[rip], edi
	test	edi, edi
	jle	.L59
	movsd	xmm8, QWORD PTR .LC4[rip]
	lea	r12, "a"[rip]
	lea	rbp, "b"[rip]
	xor	r13d, r13d
	.p2align 4
	.p2align 3
.L61:
	xor	esi, esi
	.p2align 4
	.p2align 3
.L60:
	call	"rand"
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, xmm8
	movsd	QWORD PTR [r12+rsi*8], xmm0
	call	"rand"
	pxor	xmm0, xmm0
	mov	edi, DWORD PTR "n"[rip]
	cvtsi2sd	xmm0, eax
	divsd	xmm0, xmm8
	movsd	QWORD PTR 0[rbp+rsi*8], xmm0
	add	rsi, 1
	cmp	edi, esi
	jg	.L60
	add	r13d, 1
	add	r12, 8192
	add	rbp, 8192
	cmp	edi, r13d
	jg	.L61
.L59:
	lea	rcx, "ref"[rip]
	call	"naive"
	lea	rax, .LC2[rip]
	mov	QWORD PTR 120[rsp], rbx
	mov	DWORD PTR 100[rsp], 0
	mov	QWORD PTR 104[rsp], rax
.L77:
	mov	r12d, 1
.L62:
	test	edi, edi
	jle	.L75
	mov	ebx, edi
	lea	rcx, "c"[rip]
	mov	rsi, rbx
	sal	rbx, 3
	sal	rsi, 13
	add	rsi, rcx
	.p2align 4
	.p2align 3
.L63:
	mov	r8, rbx
	xor	edx, edx
	call	"memset"
	lea	rcx, 8192[rax]
	cmp	rcx, rsi
	jne	.L63
.L75:
	lea	rdx, 144[rsp]
	mov	ecx, 1
	pxor	xmm8, xmm8
	call	"clock_gettime64"
	mov	eax, DWORD PTR 100[rsp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm8, DWORD PTR 152[rsp]
	cvtsi2sd	xmm0, QWORD PTR 144[rsp]
	mulsd	xmm8, xmm6
	addsd	xmm8, xmm0
	test	eax, eax
	je	.L64
	mov	r13d, DWORD PTR "n"[rip]
	mov	ebx, r13d
	imul	ebx, r13d
	lea	rcx, 0[0+rbx*8]
	call	"malloc"
	lea	rcx, 0[0+rbx*8]
	mov	QWORD PTR 72[rsp], rax
	mov	r15, rax
	call	"malloc"
	lea	rcx, 0[0+rbx*8]
	mov	QWORD PTR 80[rsp], rax
	mov	rdi, rax
	call	"malloc"
	mov	QWORD PTR 88[rsp], rax
	test	r13d, r13d
	jle	.L65
	mov	eax, r13d
	lea	r14, "a"[rip]
	lea	rsi, "b"[rip]
	lea	rbx, 0[0+rax*8]
	sal	rax, 13
	mov	QWORD PTR 112[rsp], rax
	lea	rbp, [r14+rax]
	.p2align 4
	.p2align 3
.L66:
	mov	rdx, r14
	mov	rcx, r15
	mov	r8, rbx
	add	r14, 8192
	call	"memcpy"
	mov	rdx, rsi
	mov	rcx, rdi
	mov	r8, rbx
	call	"memcpy"
	add	r15, rbx
	add	rdi, rbx
	add	rsi, 8192
	cmp	r14, rbp
	jne	.L66
	mov	rdi, QWORD PTR 88[rsp]
	mov	r8, QWORD PTR 80[rsp]
	mov	ecx, r13d
	mov	rdx, QWORD PTR 72[rsp]
	mov	r9, rdi
	call	"strassen_rec"
	mov	rsi, QWORD PTR 112[rsp]
	lea	rcx, "c"[rip]
	add	rsi, rcx
	.p2align 4
	.p2align 3
.L69:
	mov	rdx, rdi
	mov	r8, rbx
	add	rdi, rbx
	call	"memcpy"
	lea	rcx, 8192[rax]
	cmp	rcx, rsi
	jne	.L69
.L68:
	mov	rcx, QWORD PTR 72[rsp]
	call	"free"
	mov	rcx, QWORD PTR 80[rsp]
	call	"free"
	mov	rcx, QWORD PTR 88[rsp]
	call	"free"
.L70:
	lea	rdx, 144[rsp]
	mov	ecx, 1
	call	"clock_gettime64"
	pxor	xmm2, xmm2
	pxor	xmm0, xmm0
	cvtsi2sd	xmm2, DWORD PTR 152[rsp]
	mulsd	xmm2, xmm6
	mov	r10d, DWORD PTR "n"[rip]
	cvtsi2sd	xmm0, QWORD PTR 144[rsp]
	addsd	xmm2, xmm0
	subsd	xmm2, xmm8
	test	r10d, r10d
	jle	.L80
	mov	r8d, r10d
	lea	rdx, "c"[rip]
	lea	rcx, "ref"[rip]
	mov	r9, r8
	pxor	xmm1, xmm1
	sal	r8, 3
	sal	r9, 13
	add	r9, rdx
	.p2align 4
	.p2align 3
.L72:
	xor	eax, eax
	.p2align 6
	.p2align 4
	.p2align 3
.L73:
	movsd	xmm0, QWORD PTR [rdx+rax]
	subsd	xmm0, QWORD PTR [rcx+rax]
	add	rax, 8
	andpd	xmm0, XMMWORD PTR .LC6[rip]
	maxsd	xmm0, xmm1
	movapd	xmm1, xmm0
	cmp	rax, r8
	jne	.L73
	add	rdx, 8192
	add	rcx, 8192
	cmp	r9, rdx
	jne	.L72
.L71:
	pxor	xmm3, xmm3
	mov	r8, QWORD PTR 104[rsp]
	mov	r9d, r12d
	mov	edx, r10d
	cvtsi2sd	xmm3, r10d
	movapd	xmm0, xmm3
	movsd	QWORD PTR 48[rsp], xmm1
	lea	rcx, .LC7[rip]
	addsd	xmm0, xmm3
	movsd	QWORD PTR 32[rsp], xmm2
	add	r12d, 1
	mulsd	xmm0, xmm3
	mulsd	xmm0, xmm3
	divsd	xmm0, xmm2
	divsd	xmm0, xmm7
	movsd	QWORD PTR 40[rsp], xmm0
	call	__mingw_printf
	cmp	r12d, 6
	je	.L74
	mov	edi, DWORD PTR "n"[rip]
	jmp	.L62
.L64:
	lea	rcx, "c"[rip]
	call	"naive"
	jmp	.L70
.L74:
	cmp	DWORD PTR 100[rsp], 1
	jne	.L89
	mov	rbx, QWORD PTR 120[rsp]
	lea	rax, 144[rsp]
	add	rbx, 4
	cmp	rbx, rax
	je	.L78
	mov	edi, DWORD PTR [rbx]
	jmp	.L79
.L89:
	lea	rax, .LC1[rip]
	mov	DWORD PTR 100[rsp], 1
	mov	edi, DWORD PTR "n"[rip]
	mov	QWORD PTR 104[rsp], rax
	jmp	.L77
.L80:
	pxor	xmm1, xmm1
	jmp	.L71
.L65:
	mov	r9, QWORD PTR 88[rsp]
	mov	r8, QWORD PTR 80[rsp]
	mov	ecx, r13d
	mov	rdx, QWORD PTR 72[rsp]
	call	"strassen_rec"
	jmp	.L68
.L78:
	movaps	xmm6, XMMWORD PTR 160[rsp]
	movaps	xmm7, XMMWORD PTR 176[rsp]
	xor	eax, eax
	movaps	xmm8, XMMWORD PTR 192[rsp]
	add	rsp, 216
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.seh_endproc
.lcomm "ref",8388608,32
.lcomm "c",8388608,32
.lcomm "b",8388608,32
.lcomm "a",8388608,32
.lcomm "n",4,4
	.section .rdata,"dr"
	.align 8
.LC4:
	.long	0
	.long	1088421824
	.align 8
.LC5:
	.long	-400107883
	.long	1041313291
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC8:
	.long	0
	.long	1104006501
	.def	"__main";	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 16.2.0"
	.def	"malloc";	.scl	2;	.type	32;	.endef
	.def	"memcpy";	.scl	2;	.type	32;	.endef
	.def	"free";	.scl	2;	.type	32;	.endef
	.def	"memset";	.scl	2;	.type	32;	.endef
	.def	"puts";	.scl	2;	.type	32;	.endef
	.def	"rand";	.scl	2;	.type	32;	.endef
	.def	"clock_gettime64";	.scl	2;	.type	32;	.endef
