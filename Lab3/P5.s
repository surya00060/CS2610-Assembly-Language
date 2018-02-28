global _start

section .text
        _start:

	mov eax , S1				; Pushing the string S1
	push eax

	mov eax , R  				; R = 0 if False R = 1 if True
	push eax

	CALL PAL     				; CALL Function
	add esp,8

	int     0x80

PAL:

	mov ebp , esp
	pushad

	mov esi , [GS:ebp+8]     	;S1
	mov ecx , 0               	;N1

COUNT1:
	lodsb
	or al , al
	je CHECK
	inc ecx
	jmp COUNT1
	
CHECK:
	mov esi, [GS:ebp + 8 ] ; S1
	mov edi ,ecx
	dec ecx
	mov edx , 0

C: 
	mov al ,[GS:esi+edx]
	mov bl ,[GS:esi+ecx]
	cmp al, bl
	jne END1
	inc edx
	dec ecx
	cmp edx , ecx
	jl C
	jmp END2 


END1:                       ; Fail
	mov ecx , 0 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

END2:                       ; Pass
	mov ecx , 1 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

section .data
	S1:	db "Hi",0
	
section .bss
	R:	resd 1