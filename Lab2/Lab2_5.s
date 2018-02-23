global _start

section .text
        _start:
	
	mov	eax, [GS:N]	  	; Pushing N into Stack
	push eax

	mov eax, 1
	mov [GS:F], eax		; Intialising F with 1
	mov eax, F 			; Pushing address of F into Stack
	push F

	call FUN    		; Calling Factorial
	add esp,8

	int     0x80

FUN:					; Function Defenition
	mov ebx,[GS:esp + 8]; Storing value of N in ebx
	mov ecx,[GS:esp + 4]; Storing Address of F in ecx
	
	cmp ebx, 1			; If N =  1 do base case
	je BASE

	mov eax, [GS:ecx]	; Updating the value of F as F = F*N
	imul eax, ebx
	mov [GS:ecx], eax	

	dec ebx				; Decreasing value of N
	push ebx			; Push N-1
	push ecx			; Push Address of F
	
	call FUN 			; Recursive Call
	
	jmp END				; Jump to End

BASE:
	jmp END

END:					; Return back to Function
	ret

section .data
	N:	dd 10

section .bss
	F:	resd 1