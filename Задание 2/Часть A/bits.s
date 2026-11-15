	.file	"bits.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.def	"cmp_double";	.scl	3;	.type	32;	.endef
"cmp_double":
	movsd	xmm1, QWORD PTR [rdx]
	movsd	xmm0, QWORD PTR [rcx]
	xor	eax, eax
	comisd	xmm0, xmm1
	seta	al
	xor	edx, edx
	comisd	xmm1, xmm0
	seta	dl
	sub	eax, edx
	ret
	.p2align 4
	.globl	"bswap32"
	.def	"bswap32";	.scl	2;	.type	32;	.endef
"bswap32":
	mov	eax, ecx
	bswap	eax
	ret
	.p2align 4
	.globl	"is_pow2"
	.def	"is_pow2";	.scl	2;	.type	32;	.endef
"is_pow2":
	lea	rax, -1[rcx]
	test	rax, rcx
	sete	dl
	xor	eax, eax
	test	rcx, rcx
	setne	al
	and	eax, edx
	ret
	.p2align 4
	.globl	"parity32"
	.def	"parity32";	.scl	2;	.type	32;	.endef
"parity32":
	mov	edx, ecx
	shr	edx, 16
	xor	edx, ecx
	mov	eax, edx
	shr	eax, 8
	xor	eax, edx
	mov	ecx, eax
	shr	ecx, 4
	xor	ecx, eax
	mov	eax, 27030
	and	ecx, 15
	shr	eax, cl
	and	eax, 1
	ret
	.p2align 4
	.globl	"popcount32"
	.def	"popcount32";	.scl	2;	.type	32;	.endef
"popcount32":
	mov	eax, ecx
	shr	eax
	and	eax, 1431655765
	sub	ecx, eax
	mov	edx, ecx
	shr	ecx, 2
	and	edx, 858993459
	and	ecx, 858993459
	add	edx, ecx
	mov	eax, edx
	shr	eax, 4
	add	eax, edx
	and	eax, 252645135
	imul	eax, eax, 16843009
	shr	eax, 24
	ret
	.p2align 4
	.globl	"ctz32"
	.def	"ctz32";	.scl	2;	.type	32;	.endef
"ctz32":
	xor	eax, eax
	xor	edx, edx
	rep bsf	eax, ecx
	test	ecx, ecx
	cmove	eax, edx
	sete	dl
	movzx	edx, dl
	sal	edx, 5
	add	eax, edx
	ret
	.p2align 4
	.globl	"clz32"
	.def	"clz32";	.scl	2;	.type	32;	.endef
"clz32":
	xor	eax, eax
	cmp	ecx, 65535
	mov	edx, ecx
	setbe	al
	sal	eax, 4
	mov	ecx, eax
	sal	edx, cl
	xor	ecx, ecx
	cmp	edx, 16777215
	setbe	cl
	sal	ecx, 3
	sal	edx, cl
	add	eax, ecx
	xor	ecx, ecx
	cmp	edx, 268435455
	setbe	cl
	sal	ecx, 2
	sal	edx, cl
	add	eax, ecx
	xor	ecx, ecx
	cmp	edx, 1073741823
	setbe	cl
	add	ecx, ecx
	sal	edx, cl
	add	eax, ecx
	mov	ecx, edx
	not	ecx
	shr	ecx, 31
	sal	edx, cl
	cmp	edx, 1
	adc	eax, ecx
	ret
	.p2align 4
	.globl	"next_pow2"
	.def	"next_pow2";	.scl	2;	.type	32;	.endef
"next_pow2":
	cmp	rcx, 1
	adc	rcx, -1
	mov	rdx, rcx
	shr	rdx
	or	rdx, rcx
	mov	rax, rdx
	shr	rax, 2
	or	rax, rdx
	mov	rdx, rax
	shr	rdx, 4
	or	rdx, rax
	mov	rax, rdx
	shr	rax, 8
	or	rax, rdx
	mov	rdx, rax
	shr	rdx, 16
	or	rdx, rax
	mov	rax, rdx
	shr	rax, 32
	or	rax, rdx
	add	rax, 1
	ret
	.p2align 4
	.globl	"sign_extend"
	.def	"sign_extend";	.scl	2;	.type	32;	.endef
"sign_extend":
	mov	r8, rcx
	lea	ecx, -1[rdx]
	mov	edx, 1
	sal	rdx, cl
	lea	rax, -1[rdx+rdx]
	and	rax, r8
	xor	rax, rdx
	sub	rax, rdx
	ret
	.p2align 4
	.globl	"sat_add32"
	.def	"sat_add32";	.scl	2;	.type	32;	.endef
"sat_add32":
	lea	r8d, [rcx+rdx]
	mov	eax, ecx
	shr	ecx, 31
	xor	eax, r8d
	xor	edx, r8d
	add	ecx, 2147483647
	and	eax, edx
	xor	ecx, r8d
	sar	eax, 31
	and	eax, ecx
	xor	eax, r8d
	ret
	.section .rdata,"dr"
.LC4:
	.ascii "run %d: %.6f s, sum %llu\12\0"
	.align 8
.LC5:
	.ascii "median %.6f s, min %.6f, max %.6f, ns/element %.2f\12\0"
.LC8:
	.ascii "popcount32\0"
	.align 8
.LC9:
	.ascii "FAIL %-12s got %llu, want %llu\12\0"
.LC10:
	.ascii "parity32\0"
.LC11:
	.ascii "ctz32\0"
.LC12:
	.ascii "clz32\0"
.LC13:
	.ascii "is_pow2\0"
.LC14:
	.ascii "sign_extend\0"
	.align 8
.LC15:
	.ascii "FAIL %-12s got %lld, want %lld\12\0"
.LC18:
	.ascii "sat_add32\0"
.LC25:
	.ascii "FAIL next_pow2(%llu) = %llu\12\0"
.LC26:
	.ascii "FAILED: %d\12\0"
.LC27:
	.ascii "OK\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	"main"
	.def	"main";	.scl	2;	.type	32;	.endef
"main":
	sub	rsp, 280
	mov	QWORD PTR 232[rsp], rbx
	mov	ebx, ecx
	mov	QWORD PTR 240[rsp], rsi
	mov	rsi, rdx
	mov	QWORD PTR 248[rsp], rdi
	movaps	XMMWORD PTR 192[rsp], xmm6
	movaps	XMMWORD PTR 208[rsp], xmm7
	call	"__main"
	cmp	ebx, 1
	jle	.L64
	mov	rax, QWORD PTR 8[rsi]
	cmp	BYTE PTR [rax], 45
	je	.L100
.L64:
	mov	esi, 200000
	mov	eax, 14
	mov	ebx, 1
	mov	QWORD PTR 256[rsp], rbp
	mov	QWORD PTR 264[rsp], r12
	mov	QWORD PTR 272[rsp], r13
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L19:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L18:
	mov	ecx, ebx
	mov	eax, ebx
	xor	r9d, r9d
	mov	r8d, 27030
	shr	ecx, 16
	xor	eax, ecx
	xor	al, ah
	setnp	r9b
	xor	ecx, ebx
	mov	eax, ecx
	shr	eax, 8
	xor	ecx, eax
	mov	eax, ecx
	shr	eax, 4
	xor	ecx, eax
	and	ecx, 15
	shr	r8d, cl
	and	r8d, 1
	cmp	r9, r8
	je	.L20
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jle	.L101
.L21:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L20:
	test	ebx, ebx
	je	.L22
	mov	ecx, ebx
	bsr	r9d, ebx
	call	"clz32"
	xor	r9d, 31
	mov	r8d, eax
	cmp	r9, r8
	je	.L25
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jle	.L102
.L26:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L25:
	mov	eax, ebx
	add	ebp, 1013904222
	xor	r9d, r9d
	lea	rdx, -1[rax]
	test	ebp, ebx
	sete	r9b
	xor	r8d, r8d
	test	rdx, rax
	sete	r8b
	cmp	r9, r8
	je	.L22
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jle	.L103
.L27:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L22:
	sub	esi, 1
	je	.L65
	imul	eax, ebx, 1664525
	lea	ecx, 1013904223[rax]
	call	"__popcountdi2"
.L29:
	imul	ebp, ebx, 1664525
	mov	r9d, eax
	lea	ebx, 1013904223[rbp]
	mov	eax, ebx
	mov	edx, ebx
	shr	eax
	and	eax, 1431655765
	sub	edx, eax
	mov	eax, edx
	shr	edx, 2
	and	eax, 858993459
	and	edx, 858993459
	add	eax, edx
	mov	r8d, eax
	shr	r8d, 4
	add	r8d, eax
	and	r8d, 252645135
	imul	r8d, r8d, 16843009
	shr	r8d, 24
	cmp	r9, r8
	je	.L18
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jg	.L19
	lea	rdx, .LC8[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L103:
	lea	rdx, .LC13[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L101:
	lea	rdx, .LC10[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L102:
	lea	rdx, .LC12[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L26
.L65:
	movabs	r13, 1085102592571150095
	mov	esi, 63
	movabs	rbp, -9223372036854775808
	movabs	r12, -1085102592571150096
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L31:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L30:
	and	rbx, r12
	mov	ecx, esi
	mov	r9, r12
	mov	r8, rbx
	sal	r9, cl
	xor	r8, rdi
	sar	r9, cl
	sub	r8, rdi
	cmp	r8, r9
	je	.L32
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jle	.L104
.L33:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L32:
	sub	esi, 1
	jb	.L105
.L28:
	mov	ecx, esi
	mov	rdi, rbp
	mov	r9, r13
	shr	rdi, cl
	sal	r9, cl
	lea	rbx, -1[rdi+rdi]
	sar	r9, cl
	mov	r8, rbx
	and	r8, r13
	xor	r8, rdi
	sub	r8, rdi
	cmp	r8, r9
	je	.L30
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jg	.L31
	lea	rdx, .LC14[rip]
	lea	rcx, .LC15[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L104:
	lea	rdx, .LC14[rip]
	lea	rcx, .LC15[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L33
.L105:
	lea	rbp, 92[rsp]
	lea	r13, 64[rsp]
	mov	esi, 2147483647
	movabs	rax, 53021371269121
	movdqa	xmm0, XMMWORD PTR .LC16[rip]
	mov	QWORD PTR 80[rsp], rax
	mov	DWORD PTR 88[rsp], -12345
	movaps	XMMWORD PTR 64[rsp], xmm0
	.p2align 4
	.p2align 3
.L34:
	mov	edi, esi
	movsxd	r12, esi
	lea	rbx, 64[rsp]
	shr	edi, 31
	add	edi, 2147483647
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L36:
	add	eax, 1
	mov	DWORD PTR "fails"[rip], eax
.L35:
	add	rbx, 4
	cmp	rbx, rbp
	je	.L106
.L37:
	movsxd	r9, DWORD PTR [rbx]
	mov	rdx, -2147483648
	mov	rax, r9
	add	r9, r12
	cmp	r9, rdx
	cmovl	r9, rdx
	mov	edx, 2147483647
	cmp	r9, rdx
	cmovg	r9, rdx
	lea	edx, [rax+rsi]
	mov	r8d, edx
	xor	eax, edx
	xor	r8d, esi
	and	r8d, eax
	mov	eax, edx
	sar	r8d, 31
	xor	eax, edi
	and	r8d, eax
	xor	r8d, edx
	movsxd	r8, r8d
	cmp	r8, r9
	je	.L35
	mov	eax, DWORD PTR "fails"[rip]
	cmp	eax, 9
	jg	.L36
	lea	rdx, .LC18[rip]
	lea	rcx, .LC15[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L106:
	add	r13, 4
	cmp	rbp, r13
	je	.L38
	mov	esi, DWORD PTR 0[r13]
	jmp	.L34
.L38:
	movdqa	xmm0, XMMWORD PTR .LC19[rip]
	lea	rbx, 96[rsp]
	movaps	XMMWORD PTR 96[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC20[rip]
	movaps	XMMWORD PTR 112[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC21[rip]
	movaps	XMMWORD PTR 128[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC22[rip]
	movaps	XMMWORD PTR 144[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC23[rip]
	movaps	XMMWORD PTR 160[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC24[rip]
	movaps	XMMWORD PTR 176[rsp], xmm0
	.p2align 4
	.p2align 3
.L41:
	mov	rdx, QWORD PTR [rbx]
	cmp	rdx, 1
	mov	rax, rdx
	adc	rax, -1
	mov	rcx, rax
	shr	rcx
	or	rax, rcx
	mov	rcx, rax
	shr	rcx, 2
	or	rax, rcx
	mov	rcx, rax
	shr	rcx, 4
	or	rax, rcx
	mov	rcx, rax
	shr	rcx, 8
	or	rax, rcx
	mov	rcx, rax
	shr	rcx, 16
	or	rax, rcx
	mov	rcx, rax
	shr	rcx, 32
	or	rax, rcx
	lea	r8, 1[rax]
	cmp	r8, rdx
	jb	.L39
	test	rax, r8
	jne	.L39
	cmp	rdx, 1
	jbe	.L40
	mov	rax, r8
	shr	rax
	cmp	rax, rdx
	jb	.L40
	.p2align 4
	.p2align 3
.L39:
	lea	rcx, .LC25[rip]
	call	__mingw_printf
	add	DWORD PTR "fails"[rip], 1
.L40:
	add	rbx, 8
	lea	rax, 192[rsp]
	cmp	rax, rbx
	jne	.L41
	mov	ebx, DWORD PTR "fails"[rip]
	mov	ebp, 31
	xor	r8d, r8d
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L108:
	cmp	ebx, 9
	jle	.L43
	lea	r8d, 1[rbx]
	mov	ecx, esi
	mov	DWORD PTR "fails"[rip], r8d
	call	"clz32"
	mov	eax, eax
	cmp	rbp, rax
	je	.L44
	lea	r12d, -1[rsi]
	add	ebx, 2
	or	r12d, esi
	mov	DWORD PTR "fails"[rip], ebx
	test	r12b, 1
	jne	.L46
.L45:
	add	ebx, 1
	mov	ecx, r12d
	mov	DWORD PTR "fails"[rip], ebx
	call	"clz32"
	mov	eax, eax
	cmp	rbp, rax
	je	.L107
.L51:
	add	ebx, 1
	mov	DWORD PTR "fails"[rip], ebx
.L53:
	mov	edx, esi
	mov	eax, esi
	shr	edx
	and	edx, 1431655765
	sub	eax, edx
	mov	edx, eax
	shr	eax, 2
	and	edx, 858993459
	and	eax, 858993459
	add	eax, edx
	mov	r8d, eax
	shr	r8d, 4
	add	r8d, eax
	and	r8d, 252645135
	imul	r8d, r8d, 16843009
	shr	r8d, 24
	cmp	r8d, 1
	je	.L54
	cmp	ebx, 9
	jg	.L55
	mov	r9d, 1
	lea	rdx, .LC8[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	ebx, DWORD PTR "fails"[rip]
.L55:
	add	ebx, 1
	mov	DWORD PTR "fails"[rip], ebx
.L54:
	mov	eax, esi
	shr	eax, 16
	xor	eax, esi
	mov	edx, eax
	shr	edx, 8
	xor	eax, edx
	mov	edx, eax
	shr	edx, 4
	xor	eax, edx
	mov	edx, 27030
	and	eax, 15
	bt	edx, eax
	jc	.L56
	cmp	ebx, 9
	jle	.L57
	sal	rsi, 32
	add	ebx, 1
	lea	rax, -1[rsi]
	mov	DWORD PTR "fails"[rip], ebx
	test	rax, rsi
	je	.L58
.L59:
	add	ebx, 1
	mov	DWORD PTR "fails"[rip], ebx
.L58:
	sub	rbp, 1
	jb	.L60
	mov	ecx, edi
	mov	r8d, 1
	neg	ecx
	sal	r8d, cl
	rep bsf	r8d, r8d
.L61:
	mov	r9d, 31
	mov	esi, -2147483648
	mov	ecx, ebp
	mov	edi, ebp
	sub	r9, rbp
	shr	esi, cl
	cmp	r8, r9
	jne	.L108
.L42:
	mov	ecx, esi
	call	"clz32"
	mov	r8d, eax
	cmp	r8, rbp
	je	.L47
	cmp	ebx, 9
	jg	.L109
	mov	r9, rbp
	lea	rdx, .LC12[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	lea	ebx, 1[rax]
	mov	DWORD PTR "fails"[rip], ebx
.L47:
	lea	r12d, -1[rsi]
	xor	r8d, r8d
	or	r12d, esi
	rep bsf	r8d, r12d
	test	r8d, r8d
	je	.L46
	cmp	ebx, 9
	jg	.L45
	xor	r9d, r9d
	lea	rdx, .LC11[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	lea	ebx, 1[rax]
	mov	DWORD PTR "fails"[rip], ebx
.L46:
	mov	ecx, r12d
	call	"clz32"
	mov	r8d, eax
	cmp	r8, rbp
	je	.L53
	cmp	ebx, 9
	jg	.L51
	mov	r9, rbp
	lea	rdx, .LC12[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	ebx, DWORD PTR "fails"[rip]
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L57:
	mov	r9d, 1
	xor	r8d, r8d
	lea	rdx, .LC10[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	lea	ebx, 1[rax]
	mov	DWORD PTR "fails"[rip], ebx
.L56:
	sal	rsi, 32
	lea	rax, -1[rsi]
	test	rax, rsi
	je	.L58
	cmp	ebx, 9
	jg	.L59
	mov	r9d, 1
	xor	r8d, r8d
	lea	rdx, .LC13[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	ebx, DWORD PTR "fails"[rip]
	jmp	.L59
	.p2align 4,,10
	.p2align 3
.L43:
	lea	rdx, .LC11[rip]
	lea	rcx, .LC9[rip]
	call	__mingw_printf
	mov	eax, DWORD PTR "fails"[rip]
	lea	ebx, 1[rax]
	mov	DWORD PTR "fails"[rip], ebx
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L109:
	lea	r12d, -1[rsi]
	add	ebx, 1
	or	r12d, esi
	mov	DWORD PTR "fails"[rip], ebx
	test	r12b, 1
	je	.L45
.L99:
	mov	ecx, r12d
	call	"clz32"
	mov	eax, eax
	cmp	rbp, rax
	jne	.L51
	jmp	.L53
	.p2align 4,,10
	.p2align 3
.L44:
	lea	r12d, -1[rsi]
	mov	ebx, r8d
	or	r12d, esi
	test	r12b, 1
	je	.L45
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L107:
	mov	edx, esi
	mov	eax, esi
	shr	edx
	and	edx, 1431655765
	sub	eax, edx
	mov	edx, eax
	shr	eax, 2
	and	eax, 858993459
	and	edx, 858993459
	add	edx, eax
	mov	eax, edx
	shr	eax, 4
	add	eax, edx
	and	eax, 252645135
	imul	eax, eax, 16843009
	shr	eax, 24
	cmp	eax, 1
	jne	.L55
	jmp	.L54
.L60:
	test	ebx, ebx
	jne	.L110
	lea	rcx, .LC27[rip]
	call	"puts"
	mov	rbp, QWORD PTR 256[rsp]
	mov	r12, QWORD PTR 264[rsp]
	mov	r13, QWORD PTR 272[rsp]
.L12:
	mov	eax, ebx
	movaps	xmm6, XMMWORD PTR 192[rsp]
	movaps	xmm7, XMMWORD PTR 208[rsp]
	mov	rbx, QWORD PTR 232[rsp]
	mov	rsi, QWORD PTR 240[rsp]
	mov	rdi, QWORD PTR 248[rsp]
	add	rsp, 280
	ret
.L110:
	mov	edx, ebx
	lea	rcx, .LC26[rip]
	mov	ebx, 1
	call	__mingw_printf
	mov	rbp, QWORD PTR 256[rsp]
	mov	r12, QWORD PTR 264[rsp]
	mov	r13, QWORD PTR 272[rsp]
	jmp	.L12
.L100:
	lea	rsi, "a.0"[rip]
	mov	eax, -1831433054
	lea	rbx, 16777216[rsi]
	mov	rdx, rsi
	.p2align 6
	.p2align 4
	.p2align 3
.L14:
	mov	ecx, eax
	add	rdx, 4
	sal	ecx, 13
	xor	eax, ecx
	mov	ecx, eax
	shr	ecx, 17
	xor	eax, ecx
	mov	ecx, eax
	sal	ecx, 5
	xor	eax, ecx
	mov	DWORD PTR -4[rdx], eax
	cmp	rbx, rdx
	jne	.L14
	mov	edi, 1
.L16:
	lea	rdx, 64[rsp]
	mov	ecx, 1
	call	"clock_gettime64"
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	mov	rax, rsi
	cvtsi2sd	xmm0, DWORD PTR 72[rsp]
	mulsd	xmm0, QWORD PTR .LC0[rip]
	cvtsi2sd	xmm1, QWORD PTR 64[rsp]
	movdqa	xmm4, XMMWORD PTR .LC3[rip]
	movdqa	xmm3, XMMWORD PTR .LC2[rip]
	movdqa	xmm5, XMMWORD PTR .LC1[rip]
	pxor	xmm2, xmm2
	addsd	xmm0, xmm1
	pxor	xmm1, xmm1
	movapd	xmm7, xmm0
	.p2align 4
	.p2align 3
.L15:
	movdqa	xmm0, XMMWORD PTR [rax]
	add	rax, 16
	movdqa	xmm6, xmm0
	psrld	xmm6, 1
	pand	xmm6, xmm5
	psubd	xmm0, xmm6
	movdqa	xmm6, xmm0
	pand	xmm0, xmm3
	psrld	xmm6, 2
	pand	xmm6, xmm3
	paddd	xmm0, xmm6
	movdqa	xmm6, xmm0
	psrld	xmm6, 4
	paddd	xmm6, xmm0
	pand	xmm6, xmm4
	movdqa	xmm0, xmm6
	pslld	xmm0, 8
	paddd	xmm0, xmm6
	movdqa	xmm6, xmm0
	pslld	xmm6, 16
	paddd	xmm0, xmm6
	psrld	xmm0, 24
	movdqa	xmm6, xmm0
	punpckldq	xmm0, xmm2
	punpckhdq	xmm6, xmm2
	paddq	xmm0, xmm6
	paddq	xmm1, xmm0
	cmp	rbx, rax
	jne	.L15
	lea	rdx, 64[rsp]
	mov	ecx, 1
	movaps	XMMWORD PTR 48[rsp], xmm1
	call	"clock_gettime64"
	pxor	xmm0, xmm0
	pxor	xmm2, xmm2
	mov	edx, edi
	cvtsi2sd	xmm0, DWORD PTR 72[rsp]
	mulsd	xmm0, QWORD PTR .LC0[rip]
	cvtsi2sd	xmm2, QWORD PTR 64[rsp]
	movdqa	xmm1, XMMWORD PTR 48[rsp]
	lea	rcx, .LC4[rip]
	addsd	xmm0, xmm2
	subsd	xmm0, xmm7
	movq	r8, xmm0
	movsd	QWORD PTR 88[rsp+rdi*8], xmm0
	movdqa	xmm0, xmm1
	add	rdi, 1
	psrldq	xmm0, 8
	movq	xmm2, r8
	paddq	xmm1, xmm0
	movq	r9, xmm1
	call	__mingw_printf
	cmp	rdi, 6
	jne	.L16
	lea	r9, "cmp_double"[rip]
	mov	r8d, 8
	mov	edx, 5
	xor	ebx, ebx
	lea	rcx, 96[rsp]
	call	"qsort"
	movsd	xmm1, QWORD PTR 112[rsp]
	movsd	xmm0, QWORD PTR .LC6[rip]
	lea	rcx, .LC5[rip]
	movsd	xmm3, QWORD PTR 128[rsp]
	movsd	xmm2, QWORD PTR 96[rsp]
	mulsd	xmm0, xmm1
	movq	rdx, xmm1
	mulsd	xmm0, QWORD PTR .LC7[rip]
	movq	r9, xmm3
	movq	r8, xmm2
	movsd	QWORD PTR 32[rsp], xmm0
	call	__mingw_printf
	jmp	.L12
.lcomm "a.0",16777216,32
.lcomm "fails",4,4
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	-400107883
	.long	1041313291
	.align 16
.LC1:
	.long	1431655765
	.long	1431655765
	.long	1431655765
	.long	1431655765
	.align 16
.LC2:
	.long	858993459
	.long	858993459
	.long	858993459
	.long	858993459
	.align 16
.LC3:
	.long	252645135
	.long	252645135
	.long	252645135
	.long	252645135
	.align 8
.LC6:
	.long	0
	.long	1104006501
	.align 8
.LC7:
	.long	0
	.long	1049624576
	.align 16
.LC16:
	.long	2147483647
	.long	-2147483648
	.long	-1
	.long	0
	.align 16
.LC19:
	.quad	0
	.quad	1
	.align 16
.LC20:
	.quad	2
	.quad	3
	.align 16
.LC21:
	.quad	7
	.quad	8
	.align 16
.LC22:
	.quad	9
	.quad	2147483647
	.align 16
.LC23:
	.quad	2147483648
	.quad	4611686018427387903
	.align 16
.LC24:
	.quad	4611686018427387904
	.quad	-9223372036854775808
	.def	"__popcountdi2";	.scl	2;	.type	32;	.endef
	.def	"__main";	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 16.2.0"
	.def	"puts";	.scl	2;	.type	32;	.endef
	.def	"clock_gettime64";	.scl	2;	.type	32;	.endef
	.def	"qsort";	.scl	2;	.type	32;	.endef
