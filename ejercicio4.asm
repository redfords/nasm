; ----------------------------------------------------------------------------------------
; Se ingresan un entero N y, a continuación, N números enteros. La computadora
; muestra el promedio de los números pares ingresados y la suma de los impares.
;
; 		nasm -f elf ejercicio4.asm
;		ld -m elf_i386 -s -o ejercicio4 ejercicio4.o -lc -I /lib/ld-linux.so.2
;		./ejercicio4
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'

		global	main
		global	_start

		extern	scanf
		extern	printf

		section .bss
cadena:
		resb	0x0100

		section .data
fmtInt:
		db		"%d", 0
fmtString:
		db		"%s", 0    
fmtLF:
		db		0xA, 0
cadenaInicio:
		db		"Ingresar N y luego N numeros: ", 0
numero:
		dd		0x0
auxiliar:
		dd		0x0
contadorUno:
		dd		0x0
contadorDos:
		dd		0x0
numeroPar:
		dd		0x0
numeroImpar:
		dd		0x0

		section .text
leerNumero:
		push 	numero
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
		call 	cargarCadena
		call	mostrarCadena
		call	mostrarSaltoDeLinea
		call 	leerNumero
		mov 	eax, [numero]
		inc 	eax
		mov 	[contadorUno], eax
		mov 	eax, 0
		mov 	[contadorDos], eax
		call 	mostrarSaltoDeLinea

bucle:
		mov 	esi, [contadorUno]
		dec 	esi
		mov 	[contadorUno], esi
		cmp 	esi, 0
		je 		calcularPromedio
		call 	leerNumero
		mov 	eax, [numero]
		mov 	[auxiliar], eax
		mov 	bh, 2
		div 	bh
		cmp 	ah, 0
		je 		sumarPares
		jne 	sumarImpares

sumarPares:
		mov 	esi, [contadorDos]
		inc 	esi
		mov 	[contadorDos], esi
		add 	eax, eax
		add 	eax, [numeroPar]
		mov 	[numeroPar], eax
		mov 	edi, [contadorUno]
		cmp 	edi, 0
		jne 	bucle
		jmp 	calcularPromedio

sumarImpares:
		mov 	eax, [auxiliar]
		add 	eax, [numeroImpar]
		mov 	[numeroImpar], eax
		mov 	esi, [contadorUno]
		cmp 	esi, 0
		jne 	bucle

calcularPromedio:
		mov 	eax, [numeroPar]
		mov 	edx, 0
		mov 	ecx, [contadorDos]
		idiv 	ecx
		mov 	[numero], eax

salir:				
		call 	mostrarSaltoDeLinea
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		mov 	eax, [numeroImpar]
		mov 	[numero], eax
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		call 	salirDelPrograma
