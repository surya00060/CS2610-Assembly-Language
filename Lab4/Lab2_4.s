global _start

section .text
        _start:

	mov	eax, M1						; Pushing the Base Address of M1
	push eax

	mov eax, [GS:R1]				; Pushing the Number of R1
	push eax

	mov eax, [GS:C1]				; Pushing the Number of C1
	push eax

	mov	eax, M2						; Pushing the Base Address of M2
	push eax

	mov eax, [GS:R2]				; Pushing the Number of R2
	push eax

	mov eax, [GS:C2]				; Pushing the Number of C2
	push eax

	mov eax, P1						; Pushing the Base Address of P1
	push eax

	CALL MATMUL						; Calling the Function
	add esp,28						; To pop the data passed by stack

	mov	eax, M3						; Pushing the Base Address of M1
	push eax

	mov eax, [GS:R3]				; Pushing the Number of R1
	push eax

	mov eax, [GS:C3]				; Pushing the Number of C1
	push eax

	mov	eax, M4						; Pushing the Base Address of M2
	push eax

	mov eax, [GS:R4]				; Pushing the Number of R2
	push eax

	mov eax, [GS:C4]				; Pushing the Number of C2
	push eax

	mov eax, P2						; Pushing the Base Address of P1
	push eax

	CALL MATMUL						; Calling the Function
	add esp,28						; To pop the data passed by stack

	int     0x80

MATMUL:
	;mov ebx, [GS:esp + 36] ; M3
	;mov ecx, [GS:esp + 40]  ; C2
	;mov edx, [GS:esp + 44]	 ; R2
	;mov edi, [GS:esp + 48]	 ; M2
	;mov eax, [GS:esp + 52]	 ; C1
	;mov ecx, [GS:esp + 56]   ; R1
	;mov edx, [GS:esp + 60]	 ; M1
	
	pushad 					 ; Pushing all Registers 
	
	mov edi, 0 				 ; Loop Variable i for loop L1
	mov esi, 0 				 ; Loop Variable j for loop L2
	mov ebp, 0 				 ; Loop Variable k for loop L3
	
	L1:
		cmp edi	,[GS:esp + 56]			;checks if i < R1
		jge END							; if not goes to end
		mov esi, 0						; else sets j =0 
		jmp L2							; Starts loop L2

	L2:
		cmp esi, [GS:esp + 40]			; checks if j < C2
		jl L3							; If So starts the L3
		inc edi							; else i++
		jmp L1 							; and Jumps to loop L1; Position (i,j) in 2D Matrix is in position ( C*i + j ) in a 1D Array.
										
	L3:
		mov ebp, 0						; k = 0 
		mov eax, [GS:esp + 36]			; eax = Base Address of M3
		mov ebx, [GS:esp + 40] 			; ebx = C2
		imul ebx, edi					; ebx = C2*i
		add ebx, esi   					; ebx = C2*i + j
		imul ebx, 2 					; ebx = 2*ebx
		add eax, ebx					; eax = Base Address of M3 + ebx 
		
		mov ecx, 0						; ecx = 0
		mov [GS:eax] , ecx 				; eax = 0
		jmp LO3							

	LO3:
		cmp ebp, [GS:esp + 52]			; checks if k < C1
		jl MULT 						; if so start MULT
		inc esi 						; else j++
		jmp L2  						; Jump to L2 

	MULT:
		mov ecx, [GS:esp + 60]			; ecx = M1
		mov ebx, [GS:esp + 52] 			; ebx = C1
		imul ebx, edi 					; ebx = C1*i
		add ebx, ebp					; ebx = C1*i + k

		mov edx,[GS:ecx + ebx*2 ] 		; edx = Base Addres of M1 + 2*ebx

		mov ecx, [GS:esp + 48] 			; ecx = M2
		mov ebx, [GS:esp + 40]   		; ebx = C2
		imul ebx, ebp 					; ebx = C2*k
		add ebx, esi					; ebx = C2*k + j

		imul edx,[GS:ecx + ebx*2 ] 		; edx = Base Address of M3 + ebx  * Base Addres of M2 + 2*ebx
		
		add [GS:eax] , edx              ; M3[i][j] += edx

		inc ebp							; k++
		jmp LO3

	END:
		popad   						; Popping all Registers
		ret


section .data
	M1:		dw 1,2,3,4,5,6,7,8,9
	R1:		dd 3
	C1:		dd 3
	M2:		dw 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	R2:		dd 3
	C2:		dd 5
	M3:		dw 1,2,3,4,5,6,7,8,9 
	R3:		dd 3
	C3:		dd 3
	M4:		dw 1,0,0,0,1,0,0,0,1
	R4:		dd 3
	C4:		dd 3
section .bss
	P1 resw 15
	P2 resw 9