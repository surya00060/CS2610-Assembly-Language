global _start

section .text
        _start:

	mov	eax, M1						; Pushing the Base Address of MATRIX
	push eax

	mov eax, [GS:R1]				; Pushing the Number of Rows
	push eax

	mov eax, [GS:C1]				; Pushing the Number of Columns
	push eax

	mov	eax, M2						; Pushing the Base Address of MATRIX
	push eax

	mov eax, [GS:R2]				; Pushing the Number of Rows
	push eax

	mov eax, [GS:C2]				; Pushing the Number of Columns
	push eax

	mov eax, M3
	push eax

	CALL MATMUL					; Calling the Function
	add esp,28					; To pop the data passed by stack

	int     0x80

MATMUL:
	pushad
	;mov ebx, [GS:esp + 36] ; M3
	;mov ecx, [GS:esp + 40]   ; C2
	;mov edx, [GS:esp + 44]	 ; R2
	;mov edi, [GS:esp + 48]	 ; M2
	;mov eax, [GS:esp + 52]	 ; C1
	;mov ecx, [GS:esp + 56]   ; R1
	;mov edx, [GS:esp + 60]	 ; M1
	
	
	mov edi, 0 				 ; Loop Variable i for loop ROW
	mov esi, 0 				 ; Loop Variable j for loop COLUMN
	mov ebp, 0 				; K
	
	L1:
		cmp edi	,[GS:esp + 56]				;checks if i < R
		jge END							; if not goes to end
		mov esi, 0						; else sets j =0 
		jmp L2						; Starts loop COLUMN

	L2:
		cmp esi, [GS:esp + 40]					; checks if j < C
		jl L3							; If So starts the TRANSPOSE
		inc edi							; else i++
		jmp L1 						; and Jumps to loop ROW

	
										; Position (i,j) in 2D Matrix is in position ( C*i + j ) in a 1D Array.
	L3:
		mov ebp, 0
		mov eax, [GS:esp + 36]
		mov ebx, [GS:esp + 40]
		imul ebx, edi					;eax = C*i
		add ebx, esi   					;eax = C*i + j
		imul ebx, 2
		add eax, ebx
		mov [GS:eax] , 0 

	LO3:
		cmp ebp, [GS:esp + 52]
		jl MUL
		inc esi
		jmp L2 

	MUL:
		mov ecx, [GS:esp + 60]
		mov ebx, [GS:esp + 52]
		imul ebx, edi
		add ebx, ebp						;j++

		mov edx,[GS:ecx+ ebx*2 ]

		mov ecx, [GS:esp + 48]
		mov ebx, [GS:esp + 40]
		imul ebx, ebp
		add ebx, esi

		add edx,[GS:ecx + ebx*2 ]
		mov [GS:eax] , edx 

		inc ebp						;Goto COLUMN
		jmp LO3

	END:
		popad
		ret



section .data
	M1:		dw 1,2,3,4,5,6
	R1:		dd 2
	C1:		dd 3
	M2:		dw 1,1,1,1,1,1
	R2:		dd 3
	C2:		dd 2
section .bss
	M3 resw 4
