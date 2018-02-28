global _start

section .text
        _start:

	mov eax , S1					; Pushing the string S1
	push eax

	mov eax , [GS:N1]				; Pushing the length N1
	push eax

	mov eax , S2  					; Pushing the string S2
	push eax

	mov eax , [GS:N2] 				; Pushing the length N2
	push eax

	mov eax , R 					; R = 0 if False R = 1 if True
	push eax

	CALL SUBSTRING  				; CALL Function
	add esp,20

	int     0x80

SUBSTRING:

	mov ebp , esp
	pushad

	;mov esi, [GS:ebp + 8 ]		; N2
	;mov esi, [GS:ebp + 12 ]	; S2
	;mov esi, [GS:ebp + 16 ]	; N1
	;mov esi, [GS:ebp + 20 ]	; S1
 

	mov eax , [GS:ebp + 8 ]     ; N2
	mov ebx , [GS:ebp + 16]     ; N1

	cmp eax, ebx 				; Checking N2 <= N1
	jle CHECKSUB
	jmp END1  

CHECKSUB:
	mov ecx, [GS:ebp + 20 ] 	; S1
	mov edx, [GS:ebp + 12 ] 	; S2
	mov edi , 0   				; Loop Variable i  
	mov esi , 0   				; Loop Variable j

L1: 
	mov esi , 0 
	cmp edi , [GS:ebp+16]
	jge END1

	mov al , [GS:ecx+edi]
	mov ah , [GS:edx+esi]
	cmp al , ah 
	je L2
	inc edi
	jmp L1

L2:
	inc esi
	mov ebx , 1
	cmp ebx , [GS:ebp+8]
	je END2

L3:
	cmp esi , [GS:ebp+8]
	jl L4
	inc edi 
	jmp L1

L4:
	mov esp , edi 
	add esp , esi
	mov al , [GS:ecx+esp]
	mov ah , [Gs:edx+esi]
	cmp al , ah
	je L5
	inc edi
	jmp L1

L5:
	add ebx , 1
	cmp ebx , [GS:ebp+8]
	je END2
	inc esi
	jmp L3 


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
	S1:	db "Assembly"
	N1: dd 8
	S2:	db "emb"
	N2: dd 3 
	
section .bss
	R:	resd 1