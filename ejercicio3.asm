; ----------------------------------------------------------------------------------------
; Se ingresa un año. La computadora indica si es bisiesto.
;
; 		nasm -f elf ejercicio3.asm
;		ld -m elf_i386 -s -o ejercicio3 ejercicio3.o -lc -I /lib/ld-linux.so.2
;		./ejercicio3
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'  

		global	main
		global	_start
		extern	scanf
		extern	printf
		extern	gets
		extern	exit

		section	.bss
numero:
		resd	1
caracter:
		resb	1
		resb	3
cadena:
		resb	0x0100

		section	.data
fmtInt:
		db 		"%d", 0
fmtChar:
		db		"%c", 0
fmtString:
		db		"%s", 0
fmtLF:
		db 		0xA, 0

strInicio:
		db 		"Ingresar año: ", 0

		section	.text
leerNumero:
		push 	numero
		push 	fmtInt
		call 	scanf
		add 	esp, 8
		ret

mostrarCaracter:
		push 	dword [caracter]
		push 	fmtChar
		call 	printf
		add 	esp, 8
		ret

mostrarResultado:
		mov 	[caracter], cl
		call 	mostrarCaracter
		ret

_start:
main:
		mov 	edi, 0

iniciar:
		call	cargarCadena
		call 	mostrarCadena
		call 	mostrarSaltoDeLinea
		call 	leerNumero
		mov 	eax, [numero]
		mov 	edx, 0
		mov 	ecx, 4

divisible4:
		div 	ecx
		cmp 	edx, 0
		je 		noDivisible100
		jne 	noEsBisiesto


noDivisible100:
		mov 	eax, [numero]
		mov 	ecx, 100
		div 	ecx
		cmp 	edx, 0
		jne 	esBisiesto
		je 		divisible400

divisible400:
		mov 	eax, [numero]
		mov 	ecx, 400
		div 	ecx
		cmp 	edx, 0
		je 		esBisiesto
		jne 	noEsBisiesto

esBisiesto:
		mov 	cl, 83
		call	mostrarResultado
		jmp		salir

noEsBisiesto:
		mov 	cl, 78
		call	mostrarResultado
		jmp		salir

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
