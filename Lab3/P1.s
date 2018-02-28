global _start

section .text
        _start:

	mov eax , S	 			; Pushing the string
	push eax

	mov eax , [GS:C] 		; Pushing the charcter to be counted
	push eax

	mov eax , COUNT      	; To store the value of count
	push eax

	CALL CC              	; Calling Count function 
	add esp,10

	int     0x80

CC:
	pushad

	mov bl,  [GS:esp + 40 ]  ; Character C
	mov esi, [GS:esp + 44 ]	 ; Base Address
	mov edx, [GS:esp + 36 ]  ; Address of COUNT
	mov edi , 0 

LO: 
	lodsb                    ; Load a bit from ESI into al 
	or al, al                ; Checking for 0 which is a string terminating character
	je END                   ; If Found END
	cmp al, bl               ; Checking a charcter from string  s and given charcter
	jne LO                   ; if not equal continue the loop else increase the counter 
	inc edi 
	jmp LO   

END:                    
	mov [GS:edx] , edi       ; Writing the count into given address 
	popad 
	ret


section .data
	S:	db "Assembly",0
	C:	db 's' 
	
section .bss
	COUNT:	resd 1