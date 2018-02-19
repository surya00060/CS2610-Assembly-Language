global _start

section .text
        _start:

	mov	ebx, AR1
	mov ecx, [GS:N1]
	CALL SQUARE
	mov [GS:SUM1],esi

	mov	ebx, AR2
	mov ecx, [GS:N2]
	CALL SQUARE
	mov [GS:SUM2],esi

SQUARE:
	mov edi, 0
	mov esi, 0
CALL:
	mov edx, [GS: ebx + edi*4]
	mov eax, edx
	imul edx
	add esi,eax
	
	inc edi
	dec ecx
	
	jg CALL
	
	ret

    mov     ebx, 0
    mov     eax, 1
    int     0x80

section .data
	AR1:	dd 0,2,3,5,7
	N1:		dd 5
	AR2:	dd 1,2,3,4
	N2:		dd 4
section .bss
	SUM1:	resd 1
	SUM2:	resd 1