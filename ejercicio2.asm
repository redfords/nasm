; ----------------------------------------------------------------------------------------
; Se ingresa una cadena. La computadora muestra las subcadenas formadas por las
; posiciones pares e impares de la cadena.
; Ej: FAISANSACRO : ASNAR FIASCO
;
; 		nasm -f elf ejercicio2.asm
;		ld -m elf_i386 -s -o ejercicio2 ejercicio2.o -lc -I /lib/ld-linux.so.2
;		./ejercicio2
; ----------------------------------------------------------------------------------------

%include        'funciones.asm'  

		global	main
		global	_start
		extern	scanf
		extern	printf
		extern	gets
		extern	exit

		section	.bss                     
string:
		resb	0x0100
cadena:
		resb	0x0100
caracter:
		resb    1
		resb    3

		section	.data                    
fmtString:
		db		"%s", 0            
fmtChar:
		db		"%c", 0            
fmtLF:
		db		0xA, 0
strInicio:
		db		"Ingresar cadena: ", 0          

		section	.text
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
		mov 	edi, 1               
		mov 	eax, 0              
seguir:
		mov 	al, [string + edi]
		cmp 	al, 0
		je 		seguirImpares
		cmp 	al, 97              
		jb 		imprimir
		cmp 	al, 122
		ja 		imprimir   

imprimir:                
		mov 	[caracter], al      
		call 	mostrarCaracter   
		add 	edi,2               
		jmp 	seguir              

seguirImpares:
		test 	edi,1            
		jp 		salir          
		mov 	al,0x20             
		mov 	[caracter],al      
		call 	mostrarCaracter    
		mov 	edi,0              
		jmp 	seguir             

salir:
		call 	mostrarSaltoDeLinea
		call	salirDelPrograma
