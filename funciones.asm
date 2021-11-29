;------------------------------------------
; string

cargarCadena:
		mov 	al, [edi + cadenaInicio]
		mov 	[edi + cadena], al
		inc 	edi
		cmp 	al, 0
		jne		cargarCadena
		ret

mostrarCadena:
		push	cadena
		push	fmtString
		call	printf
		add		esp, 8
		ret

;------------------------------------------
; formato

mostrarSaltoDeLinea:
		push	fmtLF
		call	printf
		add		esp, 4
		ret

;------------------------------------------
; salir

salirDelPrograma:
		mov 	ebx, 0
		mov 	eax, 1
		int 	80h
		ret
