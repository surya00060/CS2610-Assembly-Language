global _start

section .text
        _start:

	mov eax , [GS:N1]
	mov ebx , [GS:N2]

	cmp eax , ebx
	jne EN 
	mov eax , S1	
	push eax

	mov eax , [GS:N1]
	push eax

	call SORT
	add esp , 8


	mov eax , S2
	push eax

	mov eax , [GS:N2]
	push eax

	call SORT
	add esp , 8

	mov eax , S1	
	push eax

	mov eax , S2
	push eax

	mov eax , [GS:N2]
	push eax

	mov eax , R
	push eax

	call ANAGRAM 
	add esp,16

	int     0x80

EN:
	mov eax , 0 
	mov [GS:R], eax
	int 0x80 
		

SORT:
	mov ebp , esp 
	pushad
	mov ebx , [GS:ebp+ 8]   ; String Address
	mov ecx , [GS:ebp+ 4]   ; N 
	dec ecx					; N-1
	mov edx , 0  			; i = 0
	mov edi , 0 			; j = 0 

T1:
	cmp edx , ecx
	je END
	jmp T2

T2:
	mov edi , 0
	mov esi , ecx
	sub esi , edx

T3:
	cmp edi , esi
	jl T4
	inc edx
	jmp T1

T4:	
	mov al , [GS:ebx+edi]
	push ecx
	mov ecx , edi 
	inc ecx
	mov ah , [GS:ebx+ecx]
	cmp al , ah 
	jg T5
	pop ecx
	inc edi
	jmp T3
T5:
	mov [GS:ebx+edi] , ah
	mov [GS:ebx+ecx] , al
	pop ecx
	inc edi
	jmp T3

END: 
	popad
	ret

ANAGRAM:

	mov ebp , esp
	pushad

	;mov esi, [GS:ebp + 8 ]		; N
	;mov esi, [GS:ebp + 12 ]	; S2
	;mov esi, [GS:ebp + 16 ]	; S1
 
	
	mov ebx , [GS:ebp + 16]  	; S1
	mov ecx , [GS:ebp + 12] 	; S2
	mov edi , 0 				; i
	mov esi , [GS:ebp + 8]		; N

L1:
	cmp edi , esi
	je END2
	mov ah , [GS:ebx+edi]
	mov al , [GS:ecx+edi]
	cmp ah , al
	jne END1
	inc edi
	jmp L1

END1:                       ; Fail
	mov ecx , 0 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

END2:                        ; Pass
	mov ecx , 1 
	mov ebx, [GS:ebp + 4 ]	; Address of Result 
	mov [GS:ebx] , ecx
	popad 
	ret

section .data
	S1:	db "listen"
	N1: dd 6
	S2:	db "silent"
	N2: dd 6 
	
section .bss
	R:	resd 1