global _start

section .text
        _start:

	mov	ebx, AR1		;Loading the address
	sub ebx, 4
	push ebx

	mov ebx, [GS:N1]	;Loadinhg the value of the variable
	push ebx

	mov ebx, SUM1		;Loading the address of the variable
	push ebx

	CALL SQUARE			;Passing Paramaeters through Stack 
	add esp,12			;Incrementing the Stack pointer by 12 bytes as we pushed data through stack. 

	mov	ebx, AR2
	sub ebx, 4
	push ebx

	mov ebx, [GS:N2]
	push ebx

	mov ebx, SUM2
	push ebx

	CALL SQUARE
	add esp,12

	int     0x80

SQUARE:						; Function Defenition
	push eax				; Pushing all the registers needed in the function to stack. 
	push ebx
	push ecx
	push edi
	push esi

	mov ebx,[GS:esp + 32]	; Storing the base address
	mov ecx,[GS:esp + 28]	; Storing the value of N 
	mov edi, 0

CA:	
	mov eax,[GS: ebx + ecx*4 ]
	imul eax
	add edi, eax
	loop CA 				; Looping with ecx as loop registers

	mov esi,[GS:esp + 24]	; Storing the address of the variable where sum needs to be stored in a temporary register.
	mov [GS:esi] , edi		; Storing the SUM in the address passed through stack.
	
	pop esi					; Popping all the registers that are pushed.
	pop edi
	pop ecx
	pop ebx
	pop eax
	
	ret


section .data
	AR1:	dd 1,2,3,4,5,6
	N1:		dd 6
	AR2:	dd 1,2,3,4
	N2:		dd 4
	
section .bss
	SUM1:	resd 1
	SUM2:	resd 1