; ----------------------------------------------------------------------------------------
; Se ingresa N. La computadora muestra los primeros N términos de la Secuencia de
; Connell.
;
; 1
; 2 4
; 5 7 9
; 10 12 14 16
; 17 19 21 23 25
; 26 28 30 32 34 36
; 37 39 41 43 45 47 49
; 50 52 54 56 58 60 62 64
; 65 67 69 71 73 75 77 79 81
; 82 84 86 88 90 92 94 96 98 100
; 101 103 105 107 109 111 113 115 117 119 121
; 122
; 
; 		nasm -f elf ejercicio6.asm
;		ld -m elf_i386 -s -o ejercicio6 ejercicio6.o -lc -I /lib/ld-linux.so.2
;		./ejercicio6
;----------------------------------------------------------------------------------------

%include        'funciones.asm'

		global	main
		global	_start
		
		extern	scanf
		extern	printf
		extern	gets

		section .bss
numero:
		resd 	1
auxBucle:
		resd 	1
cadena:
		resb	0x0100
		
		section .data
fmtInt:
		db		"%d", 0
fmtLF:
		db		0xA, 0
auxiliar:
		dd 		0x0
auxEcuacion:
		dd 		0x0
fmtString:
		db		"%s", 0
cadenaInicio:
		db		"Ingresar n: ", 0

		section .text
leerNumero:
		push 	auxBucle
		push 	fmtInt
		call 	scanf
		add 	esp, 8
		ret

mostrarNumero:
		push 	dword [numero]
		push 	fmtInt
		call 	printf
		add 	esp, 8
		ret

_start:
main:
		mov 	edi, 0

iniciar:
		call	cargarCadena
		call 	mostrarCadena
		call 	mostrarSaltoDeLinea
		call 	leerNumero
		mov 	eax, 1
		mov 	[numero], eax
		call 	mostrarNumero
		mov 	ebx, 1
		mov 	[auxEcuacion], ebx

bucle:
		call 	mostrarSaltoDeLinea
		mov 	eax, [auxEcuacion]
		add 	eax, 1
		mov 	[auxEcuacion], eax
		mov 	ebx, 8
		imul 	ebx
		mov 	ebx, 7
		sub 	eax, ebx
		mov 	[auxiliar], eax
		mov 	ebx, 1
		call 	raizCuadrada
		mov 	eax, [numero]
		add 	eax, 1
		mov 	ebx, 2
		mov 	edx, 0
		idiv 	ebx
		mov 	[numero], eax
		mov 	eax, 2
		mov 	ebx, [auxEcuacion]
		imul 	ebx
		mov 	ecx, [numero]
		sub 	eax, ecx
		mov 	[numero], eax
		call 	mostrarNumero
		mov 	eax, [auxBucle]
		mov 	ebx, [auxEcuacion]
		cmp 	ebx, eax
		jl 		bucle
		je 		salir

raizCuadrada:
		inc 	ebx
		mov 	[numero], ebx
		mov 	eax, ebx
		imul 	eax
		mov 	edx, [auxiliar]
		cmp 	eax, edx
		jl 		raizCuadrada
		jg 		esMayor
		ret

esMayor:
		mov 	eax, [numero]
		sub 	eax, 1
		mov 	[numero], eax
		ret

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
