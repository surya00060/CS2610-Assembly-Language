global _start

section .text
        _start:

	mov	eax, MATRIX				; Pushing the Base Address of MATRIX
	push eax

	mov eax, [GS:R]				; Pushing the Number of Rows
	push eax

	mov eax, [GS:C]				; Pushing the Number of Columns
	push eax

	mov eax, TRANSPOSE 			; Pushing the Base Address of Matrix to be transposed
	push eax

	CALL TRAN 					; Calling the Function
	add esp,16					; To pop the data passed by stack

	int     0x80

TRAN:
	pushad

	mov ecx, [GS:esp + 48]   ; ARRAY
	mov edx, [GS:esp + 36]	 ; TRANSPOSE
	mov edi, [GS:esp + 44]	 ; R
	mov eax, [GS:esp + 40]	 ; C
	
	mov ebp, 0 				 ; Loop Variable i for loop ROW
	mov esi, 0 				 ; Loop Variable j for loop COLUMN
	
	ROW:
		cmp ebp, edi					;checks if i < R
		jge END							; if not goes to end
		mov esi, 0						; else sets j =0 
		jmp COLUMN 						; Starts loop COLUMN

	COLUMN:
		cmp esi, eax 					; checks if j < C
		jl SWAP							; If So starts the TRANSPOSE
		inc ebp							; else i++
		jmp ROW 						; and Jumps to loop ROW

	
										; Position (i,j) in 2D Matrix is in position ( C*i + j ) in a 1D Array.
	SWAP:
		imul eax, ebp					;eax = C*i
		add eax, esi   					;eax = C*i + j

		mov bx,[GS: ecx + eax*2 ]		;accesing element (i,j) of MATRIX

		imul edi , esi 					;edi = R*j
		add edi , ebp 					;edi = R*j + i

		mov [GS: edx + edi*2] , bx 		;accesing corresponding position in TRANSPOSE and storing the value 

		mov eax, [GS:esp + 40]			;eax = R Since we are short of registers we use same registers to multiple opearations
		mov edi, [GS:esp + 44]			;edi = C

		inc esi 						;j++
		jmp COLUMN 						;Goto COLUMN

	END:
		popad
		ret



section .data
	MATRIX:	dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	R:		dd 3
	C:		dd 5
section .bss
	TRANSPOSE resw 15