global _start

section .text
        _start:
	
	;Given Expression Z= (P/Q)+(R*S)-(T/U)+V ;
	;PostFix Expression Z = PQ/RS*+TU/-V+

	finit				; To reset FPU Stacks to defaults. FPU stack has 8 registers st0,st1....st7


	fld dword [GS:P]	;st0 = P
	fld dword [GS:Q]	;st0 = Q st1 = P 
	
	fdiv				;st0 = st1 + st0 and st1 = 0

	fld dword [GS:R]	;st1 = R
	fld dword [GS:S]	;st1 = R st2 = S

	fmul				;st1 = st2 - st1 and st2 = 0

	fadd				;st0 = st0*st1 and st1 = 0

	fld dword [GS:T]	;st1 = T
	fld dword [GS:U]	;st1 = T
	fdiv				;st0 = st0/st1 and st1 = T

	fsub

	fld dword [GS:V]	;st1 = T
	fadd

	fstp dword [GS:Z]	;Poping out st0 and storing in Z

    int     0x80

section .data
	P: dd 2.5
	Q: dd 0.5
	R: dd 3.4
	S: dd 1.2
	T: dd 12.0
	U: dd 4.0
	V: dd 99.0

section .bss
	Z:	resd 1
