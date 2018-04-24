global _start

section .text
        _start:

	mov eax , S	 			; Pushing the string
	push eax

	mov eax , COUNTV      	; To store the value of count
	push eax

	mov eax , COUNTC      	; To store the value of count
	push eax

	mov eax , COUNTN      	; To store the value of count
	push eax

	mov eax , COUNTO      	; To store the value of count
	push eax

	CALL CC              	; Calling Count function 
	add esp,20

	int     0x80

CC:

	mov esi, [GS:esp + 20 ]	 ; Base Address
	; Count V 16 C 12 N 8 O 4
	mov ebx , 0    	; Vowels 
	mov ecx , 0 	; Consonants
	mov edx , 0 	; Numerals
	mov edi , 0 	; Others 

LO: 
	lodsb                    ; Load a bit from ESI into al 
	or al, al                ; Checking for 0 which is a string terminating character
	je END                   ; If Found END
	cmp al , 0x30
	jl OTHER
	cmp al , 0x39                 
	jle NUMERAL
	cmp al , 0x41
	jl OTHER
	cmp al , 0x5A
	jle UPPER
	cmp al , 0x61
	jl OTHER
	cmp al , 0x7A
	jle LOWER
	jmp OTHER

OTHER:
	inc edi 
	jmp LO

NUMERAL:
	inc edx
	jmp LO 

LOWER:
	sub al , 0x20
	jmp UPPER

UPPER:
	cmp al , 0x41
	je VOWEL 
	cmp al , 0x45
	je VOWEL
	cmp al , 0x49
	je VOWEL 
	cmp al , 0x4f
	je VOWEL
	cmp al , 0x55
	je VOWEL

	jmp CONS

VOWEL:
	inc ebx 
	jmp LO 

CONS:
	inc ecx 
	jmp LO 

END:                    
	mov eax , [GS:esp + 16 ]       ; Writing the count into given address 
	mov [GS:eax] , ebx 

	mov eax , [GS:esp + 12 ]       ; Writing the count into given address 
	mov [GS:eax] , ecx 

	mov eax , [GS:esp + 8 ]       ; Writing the count into given address 
	mov [GS:eax] , edx 

	mov eax , [GS:esp + 4 ]       ; Writing the count into given address 
	mov [GS:eax] , edi 
	ret


section .data
	S:	db "MACBOOKPRO#2020!!!",0		; Input can be given with 0 to terminate or can be given with number of letters.
	
section .bss
	COUNTV:	resd 1
	COUNTC:	resd 1
	COUNTN:	resd 1
	COUNTO:	resd 1