; ----------------------------------------------------------------------------------------
; Dado un entero N, la computadora lo muestra descompuesto en sus factores primos.
; Ej: 132 = 2 × 2 × 3 × 11
;
; 		nasm -f elf ejercicio1.asm
;		ld -m elf_i386 -s -o ejercicio1 ejercicio1.o -lc -I /lib/ld-linux.so.2
;		./ejercicio1
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'  

		global	main
		global	_start

		extern	scanf
		extern	printf
		extern	gets

		section	.bss
numero:
		resd	1
factor:
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
cadenaInicio:
		db		"Ingresar numero: ", 0

		section	.text
leerNumero:
		push	numero
		push	fmtInt
		call	scanf
		add		esp, 8
		ret

mostrarFactorPrimo:
		push	dword [factor]
		push	fmtInt
		call	printf
		add		esp, 8
		ret

mostrarNumero:
		push	dword [numero]
		push	fmtInt
		call	printf
		add		esp, 8
		ret

_start:
main:
		mov 	edi, 0

iniciar:
		call	cargarCadena
		call	mostrarCadena
		call	mostrarSaltoDeLinea
		call	leerNumero
		mov 	eax, 2
		mov 	[factor], eax

bucleUno:
		mov 	eax, [numero]
		mov 	ebx, [factor]
		cmp 	eax, ebx
		jl 		salir
	
bucleDos:
		mov 	eax, [numero]
		mov 	edx, 0
		mov 	ecx, [factor]
		idiv 	ecx
		mov 	[auxiliar], eax
		cmp 	edx, 0
		jne 	incrementar	
		call 	mostrarFactorPrimo
		call 	mostrarSaltoDeLinea
		mov 	eax, [auxiliar]
		mov 	[numero], eax
		mov 	ebx, [factor]
		inc 	ebx
		mov 	[factor], ebx
		jmp 	bucleUno

incrementar:
		mov 	eax, [factor]
		inc 	eax
		mov 	[factor], eax
		jmp 	bucleUno

salir:
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
