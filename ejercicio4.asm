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
numeroPar:
		dd		0x0
auxiliar:
		dd		0x0
contNumeros:
		dd		0x0
contPares:
		dd		0x0
suma:
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
		mov 	[contNumeros], eax
		mov 	eax, 0
		mov 	[contPares], eax

bucle:
		mov 	esi, [contNumeros]
		dec 	esi
		mov 	[contNumeros], esi
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
		mov 	esi, [contPares]
		inc 	esi
		mov 	[contPares], esi
		add 	eax, eax
		add 	eax, [numeroPar]
		mov 	[numeroPar], eax
		mov 	edi, [contNumeros]
		cmp 	edi, 0
		jne 	bucle
		jmp 	calcularPromedio

sumarImpares:
		mov 	ecx, [auxiliar]
		add 	ecx, [suma]
		mov 	[suma], ecx
		mov 	esi, [contNumeros]
		cmp 	esi, 0
		jne 	bucle

calcularPromedio:
		mov 	ecx, [contPares]
		cmp 	ecx, 0
		je 		noHayPares
		mov 	eax, [numeroPar]
		mov 	edx, 0
		idiv 	ecx
		mov 	[numero], eax
		jmp 	mostrarResultado

noHayPares:
		mov 	eax, 0
		mov 	[numero], eax

mostrarResultado:				
		call 	mostrarSaltoDeLinea
		call 	mostrarNumero
		call 	mostrarSaltoDeLinea
		mov 	eax, [suma]
		mov 	[numero], eax
		call 	mostrarNumero
		
salir:
		call 	mostrarSaltoDeLinea
		call 	salirDelPrograma
