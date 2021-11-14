;------------------------------------------
; string

leerCadena:
        push    cadena
        call    gets
        add     esp, 4
        ret

leerCadenaTexto:
        push    cadenaTexto
        call    gets
        add     esp, 4
        ret 

mostrarCadena:
        push    cadena
        push    fmtString
        call    printf
        add     esp, 8
        ret

mostrarCadenaTexto:
        push    cadenaTexto
        push    fmtString
        call    printf
        add     esp, 8
        ret

;------------------------------------------
; int

leerNumero:
        push    numero
        push    fmtInt
        call    scanf
        add     esp, 8
        ret

leerNumero6:
        push    auxBucle
        push    fmtInt
        call    scanf
        add     esp, 8
        ret

mostrarNumero:
        push    dword [numero]
        push    fmtInt
        call    printf
        add     esp, 8
        ret

mostrarDivisor:
        push    dword [divisor]
        push    fmtInt
        call    printf
        add     esp, 8
        ret

mostrarPromedio:
        push    dword [promedio]
        push    fmtInt
        call    printf
        add     esp, 8
        ret

mostrarNumeroPar:
        push    dword [numeroPar]
        push    fmtInt
        call    printf
        add     esp, 8
        ret

mostrarColumnas:
        push    dword [columnas]
        push    fmtInt
        call    printf
        add     esp, 8
        ret

;------------------------------------------
; char

mostrarCaracter:                
        push    dword [caracter]
        push    fmtChar
        call    printf
        add     esp, 8
        ret

mostrarAuxiliarPrueba:
        push    dword [auxiliarPrueba]
        push    fmtChar
        call    printf
        add     esp, 8
        ret

;------------------------------------------
; espacio

mostrarEspacio:
        push    espacio
        call    printf
        add     esp, 4
        ret

mostrarTabulado:
        push    tabulado
        call    printf
        add     esp, 4
        ret

mostrarSaltoDeLinea:
        push    fmtLF
        call    printf
        add     esp, 4
        ret

;------------------------------------------
; salir

salirDelPrograma:
        push    0
        call    exit
