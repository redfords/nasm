; ----------------------------------------------------------------------------------------
; Se ingresa una matriz de NxM componentes. La computadora la muestra girada 90° en sentido
; horario.
;
; 		nasm -f elf ejercicio7.asm
;		ld -m elf_i386 -s -o ejercicio7 ejercicio7.o -lc -I /lib/ld-linux.so.2
;		./ejercicio7
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'

		global	main
		global	_start
		extern	scanf
		extern	printf
		extern	gets

		section .bss
numero:
		resd	1
filas:
		resd	1
columnas:
		resd	1
largo:
		resd	1
i:
		resd	1
j:
		resd	1
matriz:
		resd	100
cadena:
		resb	0x0100

		section .data
	
fmtInt:
		db		"%d", 0
fmtString:
		db		"%s", 0
fmtChar:
		db		"%c", 0
fmtLF:
		db		0xA, 0
caracter:
		dd		0x0
strInicio:
		db		"Ingresar el numero de filas y luego el de columnas: ", 0
tabulado:
		db  		0x09, 0

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

mostrarTabulado:
		push 	tabulado
		call 	printf
		add 	esp, 4
		ret

;matriz[i][j] = matriz[i * columnas + j] = indice matriz 1D
	
_start:
main:
		mov 	edi, 0

iniciar:
		call	cargarCadena
		call 	mostrarCadena
		call 	mostrarSaltoDeLinea
		call 	leerNumero
		mov 	eax, [numero]
		mov 	[filas], eax
		call 	leerNumero
		mov 	eax, [numero]
		mov 	[columnas], eax

maximoNumMatriz:
		mov 	eax, [filas]
		mov 	ebx, [columnas]
		mul 	ebx
		mov 	[numero], eax
	
		mov 	eax, 1
		mov 	esi, 0
		mov 	ebx, [numero]

cargarMatriz:
		mov 	[esi*4 + matriz], eax
		inc 	eax
		inc 	esi
		cmp 	esi, ebx
		jne 	cargarMatriz

inicializar:
		mov 	esi, 0
		mov 	edi, 1	
		call 	mostrarSaltoDeLinea		
		jmp 	mostrarMatriz

inicializar2:
		call 	mostrarSaltoDeLinea
		call 	mostrarSaltoDeLinea
		mov 	edi, 1
		cmp 	esi, ebx
		je 		rotarMatriz

mostrarMatriz:
		mov 	eax, [esi*4 + matriz]
		mov 	[numero], eax
		call 	mostrarNumero
		call 	mostrarTabulado
		inc 	esi
		mov 	ecx, [columnas]
		cmp 	edi, ecx
		je 		inicializar2
		inc 	edi
		cmp 	esi, ebx
		jne 	mostrarMatriz

rotarMatriz:
		call 	mostrarSaltoDeLinea
		largoBucle:
				mov 	eax, [filas]
				mov 	ebx, [columnas]
				mul 	ebx
				mov 	[largo], eax

		mov 	eax, 0
		mov 	[i], eax
		mov 	eax, [filas]
		dec 	eax
		mov 	[j], eax

		bucle:
				mov 	eax, [largo]
				cmp 	eax, 0
				je 		salir
				mov 	eax, [j]
				mov 	ebx, [columnas]
				mul 	ebx
				mov 	ecx, [i]
				add 	eax, ecx
				inc 	eax
				mov 	[numero], eax
				call 	mostrarNumero
				call 	mostrarTabulado
				mov 	eax, [j]
				dec 	eax
				mov 	[j], eax
				mov 	ebx, [j]
				cmp 	ebx, 0
				jl 		if
				mov 	eax, [largo]
				dec 	eax
				mov 	[largo], eax
				jge 	bucle

		if:
				mov 	eax, [i]
				inc 	eax
				mov 	[i], eax
				mov 	eax, [filas]
				dec 	eax
				mov 	[j], eax
				call	mostrarSaltoDeLinea
				call 	mostrarSaltoDeLinea
				mov 	eax, [largo]
				dec 	eax
				mov 	[largo], eax
				jmp 	bucle

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
