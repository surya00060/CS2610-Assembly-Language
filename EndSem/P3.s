global _start

section .text
        _start:
	
	mov	eax, [GS:A]	  	; Pushing A into Stack Assumption A > B 
	push eax

	mov	eax, [GS:B]	  	; Pushing B into Stack
	push eax

	mov eax, G 			; Pushing address of G into Stack
	push eax

	call GCD    		; Calling GCD
	add esp,12

	int     0x80

GCD:						; Function Defenition
	mov ebx,[GS:esp + 12]	; A 
	mov ecx,[GS:esp + 8]	; B
	mov edi,[GS:esp + 4] 	; GCD
	
	cmp esi , 0				; If B =  0  do base case
	je BASE
	
	mov eax , ebx 
	idiv ecx					; eax = ebx/ecx // Quotient 
	
	imul eax , ecx 				; Quotient*Dividend
	sub ebx , eax				; Number - Quotient*Dividend = Remainder

	push ecx			; Push Value of B
	push ebx 			; Push Value of A%B
	push edi						
	
	call GCD			; Recursive Call
	jmp END				; Jump to End

BASE:
	mov [GS:edi] , ebx 
	jmp END

END:					; Return back to Function
	ret

section .data
	A:	dw 8
	B:  dw 5
section .bss
	G:	resd 1