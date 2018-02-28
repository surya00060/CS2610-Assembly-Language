global _start

section .text
        _start:

	mov eax , S1						; Pushing the string S1
	push eax

	mov eax , [GS:N1]
	push eax

	mov eax , S2 						; Pushing the string S2
	push eax

	mov eax , [GS:N2]
	push eax

	mov eax , R
	push eax

	call ANAGRAM 
	add esp,20

	int     0x80


ANAGRAM:

	mov ebp , esp
	pushad

	;mov esi, [GS:ebp + 8 ]		; N2
	;mov esi, [GS:ebp + 12 ]	; S2
	;mov esi, [GS:ebp + 16 ]	; N1
 	;mov esi, [GS:ebp + 20 ]	; S1
	
 	mov eax , [GS:ebp + 16 ]
 	mov ebx , [GS:ebp + 8 ]
 	cmp eax , ebx
 	jne END1

 	mov eax ,[GS:ebp + 20 ]		;S1
 	push eax

 	mov eax ,[GS:ebp + 16 ]		;N1 
 	push eax

 	call SORT

 	mov eax , [GS:ebp + 12 ]	;S2
 	push eax
 	mov eax , [GS:ebp + 16 ]	;N1 
 	push eax

 	call SORT


	mov ebx , [GS:ebp + 20]  	; S1
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

SORT:
	pushad
	mov ebx , [GS:esp+ 40]   ; String Address
	mov ecx , [GS:esp+ 36]   ; N 
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
	mov ebp , edi 
	inc ebp
	mov ah , [GS:ebx+ebp]
	cmp al , ah 
	jl T5
	mov [GS:ebx+edi] , ah
	mov [GS:ebx+ebp] , al
	inc edi
	jmp T3
T5:
	inc edi
	jmp T3

END: 
	popad
	ret 8

section .data
	S1:	db "Silent"
	N1: dd 6
	S2:	db "liSten"
	N2: dd 6 
	
section .bss
	R:	resd 1