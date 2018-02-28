global _start

section .text
        _start:

	mov eax , S1				; Pushing the string S1
	push eax

	mov eax , S2				; Pushing the string S2
	push eax

	mov eax , S3				; Pushing the string S3
	push eax

	CALL CON 					; Calling Concatenation function
	add esp,16

	int     0x80

CON:
	mov ebp , esp
	pushad

	mov esi, [GS:ebp + 12 ]		; Base Address S1
	mov edx, [GS:ebp + 8 ]  	; Base Address S2
	mov ebx, [GS:ebp + 4 ]		; Base Address S3
	mov edi , 0 
C1: 
	lodsb     					; loads into al 
	or al, al 					; Checks if there is zero
	je CO2 						; If so goto C2
		
	mov [GS:ebx+edi] , al  		; Write into S3
	inc edi						; Increase the pointer
	jmp C1

CO2:
	mov esi , edx 				; Load S2

C2:
	lodsb
	or al,al 
	je END

	mov [GS:ebx+edi] , al 		; Write into S3
	inc edi 					; Increase the pointer
	jmp C2 

END: 
	popad 
	ret


section .data
	S1:	db "Assembly",0
	S2:	db "Language",0 
	
section .bss
	S3:	resb 16