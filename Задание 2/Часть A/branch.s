	.file	"branch.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	"is_pow2_branchy"
	.def	"is_pow2_branchy";	.scl	2;	.type	32;	.endef
"is_pow2_branchy":
	test	rcx, rcx
	jne	.L9
	jmp	.L5
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L4:
	test	cl, 1
	jne	.L5
	shr	rcx
.L9:
	cmp	rcx, 1
	jne	.L4
	mov	eax, 1
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	xor	eax, eax
	ret
	.p2align 4
	.globl	"sat_add32_branchy"
	.def	"sat_add32_branchy";	.scl	2;	.type	32;	.endef
"sat_add32_branchy":
	movsxd	rcx, ecx
	movsxd	rdx, edx
	mov	eax, 2147483647
	add	rcx, rdx
	cmp	rcx, 2147483647
	jg	.L11
	cmp	rcx, -2147483648
	mov	eax, -2147483648
	cmovge	eax, ecx
.L11:
	ret
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 16.2.0"
