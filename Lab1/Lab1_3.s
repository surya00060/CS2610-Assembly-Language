global _start

section .text
        _start:

	mov	ebx, AR
	sub ebx, 4
	mov ecx, [GS:N]
	mov edi, 0

SQUARE:
	mov edx, [GS: ebx + ecx*4]
	mov eax, edx
	imul edx
	add edi,eax
	loop SQUARE

	mov	[GS:SUM], edi

    mov     ebx, 0
    mov     eax, 1
    int     0x80

section .data
	AR:	dd 2,3,5,7
	N:	dd 4

section .bss
	SUM:	resd 1
