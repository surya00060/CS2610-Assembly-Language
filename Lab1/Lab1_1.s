global _start

section .text
        _start:
	mov eax, [GS:P]
	mov	ebx, [GS:Q]
	mov	ecx, [GS:R]
	mov	edx, [GS:S]
	mov	edi, [GS:T]

	add eax, ebx
	sub ecx, edx
	imul ecx
	idiv edi

	mov	[GS:Z], eax

    mov     ebx, 0
    mov     eax, 1
    int     0x80

section .data
	P: 	dd 	-20
	Q:	dd	5
	R: 	dd 	20
	S:	dd	10
	T: 	dd	2

section .bss
	Z:	resd 1
