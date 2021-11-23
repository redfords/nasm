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
cadenaInicio:
		db		"Ingresar 100 caracteres: ", 0

		section .text
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
		call	cargarCadena
		call 	mostrarCadena
		call 	mostrarSaltoDeLinea
		call 	leerString
		mov 	esi, 0
		mov 	ebx, 99
		mov 	ecx, 99

bucle:
		sub 	ebx, 1
		mov 	ah, [esi + string]
		cmp 	ah, [esi + 1 + string]
		jl 		esMenor
		jg 		esMayor

esMayor:
		xchg 	ah, [esi + 1 + string]
		mov 	[esi + string], ah
		add 	esi, 1
		cmp 	ebx, 0
		je 		inicializar
		jne 	bucle
		
esMenor:
		add 	esi, 1
		cmp 	ebx, 0
		je 		inicializar
		jne 	bucle

inicializar:
		mov 	ebx, 99
		mov 	esi, 0
		sub 	ecx, 1
		mov 	edi, 0
		cmp 	ecx, 0
		je 		saltearRepetido
		jne 	bucle

saltearRepetido:
		mov 	al, [edi + string]
		mov 	ah, [edi + 1 + string]
		mov 	[caracter], al
		inc 	edi
		cmp 	al, ah
		jl 		imprimir
		je 		saltearRepetido

imprimir:
		call 	mostrarCaracter
		mov 	al, [edi + string]
		cmp 	al, 0
		je 		salir
		jne 	saltearRepetido

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
