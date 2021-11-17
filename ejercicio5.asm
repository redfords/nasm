; ----------------------------------------------------------------------------------------
; Se ingresan 100 caracteres. La computadora los muestra ordenados sin repeticiones.
;
; 		nasm -f elf ejercicio5.asm
;		ld -m elf_i386 -s -o ejercicio5 ejercicio5.o -lc -I /lib/ld-linux.so.2
;		./ejercicio5
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'

		global	main
		global	_start
		extern	scanf
		extern	printf
		extern	gets

		section .bss
cadena:
		resb	0x0100
string:
		resb	0x0100

		section .data
	
fmtString:
		db		"%s", 0
fmtChar:
		db		"%c", 0
fmtLF:
		db		0xA, 0
caracter:
		dd  		0x0
strInicio:
		db		"Ingresar 100 caracteres: ", 0

		section .text
cargarCadenaAux:
		mov 	al, [edi + strInicio]
		mov 	[edi + cadena], eax
		inc 	edi
		cmp 	al, 0
		jne		cargarCadenaAux
		ret

leerString:
		push 	string
		call 	gets
		add 	esp, 4
		ret

mostrarCaracter:
		push 	dword [caracter]
		push 	fmtChar
		call 	printf
		add 	esp, 8
		ret

_start:
main:
		mov 	edi, 0

iniciar:
		call	cargarCadenaAux
		call 	mostrarCadena
		call 	mostrarSaltoDeLinea
		call 	leerString
		mov 	esi, 0
		mov 	bl, 99
		mov 	cl, 99

bucle:
		sub 	bl, 1
		mov 	ah, [esi + string]
		cmp 	ah, [esi + 1 + string]
		jl 		menorQue
		jg 		mayorQue

mayorQue:
		xchg 	ah, [esi + 1 + string]
		mov 	[esi + string], ah
		add 	esi, 1
		cmp 	bl, 0
		je 		inicializar
		jne 	bucle
		
menorQue:
		add 	esi, 1
		cmp 	bl, 0
		je 		inicializar
		jne 	bucle

saltarRepetidos:
		mov 	al, [edi + string]
		mov 	ah, [edi + 1 + string]
		mov 	[caracter], al
		inc 	edi
		cmp 	al, ah
		jl 		imprimir
		je 		saltarRepetidos

imprimir:
		call 	mostrarCaracter
		mov 	al, [edi + string]
		cmp 	al, 0
		je 		salir
		jne 	saltarRepetidos

inicializar:
		mov 	bl, 99
		mov 	esi, 0
		sub 	cl, 1
		mov 	edi, 0
		cmp 	cl, 0
		je 		saltarRepetidos
		jne 	bucle

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
