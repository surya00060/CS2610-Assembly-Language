global _start

section .text
        _start:
	
	mov eax, [GS:U]
	mov	ebx, [GS:V]
	
	cmp	eax,ebx
	jg 	C2

	mov eax, [GS:W]
	mov ebx, [GS:X]

	cmp eax,ebx
	jne C2

	mov ecx, [GS:E]
	mov edx, [GS:F]
	add ecx, edx
	mov [GS:G],ecx
	jmp END

C2:
	mov ecx, [GS:E]
	mov edx, [GS:F]
	sub ecx, edx
	mov [GS:G],ecx

END:

    mov     ebx, 0
    mov     eax, 1
    int     0x80

section .data
	U: 	dd 	5
	V:	dd	30
	W: 	dd 	20
	X:	dd	10
	E: 	dd	10
	F: 	dd 	20

section .bss
	G:	resd 1
