; ----------------------------------------------------------------------------------------
; Dado un entero N, la computadora lo muestra descompuesto en sus factores primos.
; Ej: 132 = 2 × 2 × 3 × 11
;
; 		nasm -f elf ejercicio1.asm
;		ld -m elf_i386 -s -o ejercicio1 ejercicio1.o -lc -I /lib/ld-linux.so.2
;		./ejercicio1
; ----------------------------------------------------------------------------------------

		global	main
		global	_start
		extern	scanf
		extern	printf
		extern	gets
		extern	exit

		section	.bss
numero:
		resd	1
divisor:
		resd	1
auxiliar:
		resd	1
cadena:
		resb	0x0100


		section	.data
fmtInt:
		db		"%d", 0
fmtString:
		db		"%s", 0                      
fmtLF:
		db		0xA, 0 
tabulado:
		db		0x09, 0
strInicio:
		db		"Ingresar numero: ", 0

		section	.text
leerCadena:
		push	cadena
		call	gets
		add		esp, 4
		ret

mostrarCadena:
		push	cadena
		push	fmtString
		call	printf
		add		esp, 8
		ret
	
leerNumero:
		push	numero
		push	fmtInt
		call	scanf
		add		esp, 8
		ret

mostrarNumero:
		push	dword [numero]
		push	fmtInt
		call	printf
		add		esp, 8
		ret

mostrarDivisor:
		push	dword [divisor]
		push	fmtInt
		call	printf
		add		esp, 8
		ret

mostrarSaltoDeLinea:
		push	fmtLF
		call	printf
		add		esp, 4
		ret

_start:
main:
		mov 	edi, 0

cargarCadena:
		mov 	eax, [edi + strInicio]
		mov 	[edi + cadena], eax
		inc 	edi
		cmp 	eax, 0
		jne		cargarCadena

		call	mostrarCadena
		call	mostrarSaltoDeLinea
		call	leerNumero
		mov 	eax, 2
		mov 	[divisor], eax

bucleUno:
		mov 	eax, [numero]
		mov 	ebx, [divisor]
		cmp 	eax, ebx
		jl 		salir
	
bucleDos:
		mov 	eax, [numero]
		mov 	edx, 0
		mov 	ecx, [divisor]
		idiv 	ecx
		mov 	[auxiliar], eax
		cmp 	edx, 0
		jne 	incrementar	
		call 	mostrarDivisor
		call 	mostrarTabulado
		mov 	eax, [auxiliar]
		mov 	[numero], eax
		mov 	ebx, [divisor]
		inc 	ebx
		mov 	[divisor], ebx
		jmp 	bucleUno

incrementar:
		mov 	eax, [divisor]
		inc 	eax
		mov 	[divisor], eax
		jmp 	bucleUno

salir:
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		push	0
		call	exit
