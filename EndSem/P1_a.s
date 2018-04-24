global _start

section .text
        _start:
	
	mov eax, [GS:P]
	mov	ebx, [GS:Q]
	idiv  bx	
	mov edi , 0 		
	add di , ax 

	mov	eax, [GS:R]
	mov	ebx, [GS:S]
	imul bx
	add di , ax 

	mov	eax, [GS:T]
	mov	ebx, [GS:U]
	idiv  bx
	sub di , ax 

	mov	eax, [GS:V]
	add di , ax 

	mov	[GS:Z], di

    int     0x80

section .data
	P: 	dw 	2
	Q:	dw	3
	R: 	dw 	5
	S:	dw	4
	T: 	dw	7
	U:	dw	5
	V: 	dw	25
section .bss
	Z:	resw 1
