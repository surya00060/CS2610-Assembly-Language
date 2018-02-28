global _start

section .text
        _start:

	mov eax , S1				; Pushing the string S1
	push eax

	mov eax , S2 				; Pushing the string S2
	push eax

	mov eax , R   				; R = 0 if False R = 1 if True
	push eax

	CALL EQUALITY    			; CALL Function
	add esp,12

	int     0x80

EQUALITY:

	mov ebp , esp
	pushad
	
	mov esi , [GS:ebp+12]  		; Load S1
	mov ecx , 0 				; To store length of S1

COUNT1:  						; Finding Length of S1
	lodsb
	or al , al
	je CO2
	inc ecx
	jmp COUNT1

CO2: 
	mov esi , [GS:ebp + 8 ]
	mov edx , 0

COUNT2: 						; Finding Length of S2
	lodsb
	or al , al
	je CHECK
	inc edx
	jmp COUNT2	

CHECK: 							; Comparing Lengths 
	cmp ecx , edx 
	jne END1
	mov edi , [GS:ebp +12] ; S1
	mov esi , [GS:ebp + 8] ; S2
	mov edx , 0
	jmp LO 

LO: 							; Comparing each character if lengths are equal
	mov al , [GS:edi + edx ]
	mov bl , [GS:esi + edx ]
	cmp al , bl
	jne END1
	inc edx
	cmp edx , ecx 
	je END2
	jmp LO


END1:  						; Fail
	mov ecx , 0 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

END2:						; Pass
	mov ecx , 1 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

section .data
	S1:	db "Hello",0
	S2:	db "Hello",0
	
section .bss
	R:	resd 1  ; 1 if Equal