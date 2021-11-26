; ----------------------------------------------------------------------------------------
; Se ingresa N. La computadora muestra los primeros N términos de la Secuencia de
; Connell.
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
max:
		resd 	1
contNumero:
		resd 	1
contLinea:
		resd 	1
linea:
		resd 	1
cadena:
		resb	0x0100
		
		section .data
fmtInt:
		db		"%d", 0
fmtLF:
		db		0xA, 0
fmtString:
		db		"%s", 0
cadenaInicio:
		db		"Ingresar n: ", 0

		section .text
leerNumero:
		push 	max
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
		call 	mostrarSaltoDeLinea
		mov 	ebx, [max]
		cmp 	eax, ebx
		je 		salir
		mov 	eax, 1
		mov 	[contNumero], eax
		mov 	eax, 0
		mov 	[contLinea], eax
		mov 	eax, 1
		mov 	[linea], eax

bucleUno:
		mov 	eax, [contNumero]
		mov 	ebx, [max]
		cmp 	eax, ebx
		jge		salir
		mov 	eax, [numero]
		inc 	eax
		mov 	[numero], eax
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		mov 	eax, [contNumero]
		inc 	eax
		mov 	[contNumero], eax
		mov 	ebx, [max]
		cmp 	eax, ebx
		jge		salir
		jmp 	bucleDos

bucleDos:
		mov 	eax, [contLinea]
		mov 	ebx, [linea]
		cmp 	eax, ebx
		jge 	incrementar
		mov 	eax, [numero]
		mov 	ebx, 2
		add 	eax, ebx
		mov 	[numero], eax
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		mov 	eax, [contNumero]
		inc 	eax
		mov 	[contNumero], eax
		mov 	ebx, [max]
		cmp 	eax, ebx
		jge		salir
		mov 	ecx, [contLinea]
		inc 	ecx
		mov 	[contLinea], ecx
		jmp 	bucleDos

incrementar:
		mov 	eax, 0
		mov 	[contLinea], eax
		mov 	eax, [linea]
		inc 	eax
		mov 	[linea], eax
		jmp 	bucleUno

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
