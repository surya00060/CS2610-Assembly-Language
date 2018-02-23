global _start

section .text
        _start:

	mov	eax, AR						; Pushing the Base Address
	push eax

	mov eax, [GS:N]					; Pushing the size of Array
	push eax

	CALL REVERSE					; Calling the Function
	pop eax							; Poping from stack
	pop eax

	int     0x80

REVERSE:							; Function Defenition
	push eax						; Pushing all required registers in Function
	push ebx
	push ecx
	push edx
	push edi

	mov ecx,[GS:esp + 28]			; Storing the Base Address in ecx
	mov edx,[GS:esp + 24]			; Storing the N in edx
	
	dec edx							; Decrementing N to N-1 to access the eleemnts of Array
	mov edi, 0						; edi is set to be 0

SWAP:
	mov ax,[GS: ecx + edi*2 ]		; Storing 16bit A[i] in ax 
	mov bx,[GS: ecx + edx*2 ]		; Storing 16bit A[n-1-i] in bx

	mov [GS: ecx + edx*2] , ax 		;	Swapping A[i] and A[n-1-i]
	mov [GS: ecx + edi*2] , bx

	dec edx							; Decrementing edx
	inc edi							; Incrementing edi

	cmp edx,edi						; Comparing edx and edi
	jg SWAP 						; If edx > edi then do Swapping
	
	pop edi							; Poping from stack
	pop edx
	pop ecx
	pop ebx
	pop eax

	ret 							; Return

section .data
	AR:		dw 1,2,3,4,5
	N:		dd 5
section .bss
	