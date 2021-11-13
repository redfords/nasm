;------------------------------------------
; string

leerCadena:
        push    cadena
        call    gets
        add     esp, 4
        ret

mostrarCadena:
        push    cadena
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

;------------------------------------------
; espacio

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