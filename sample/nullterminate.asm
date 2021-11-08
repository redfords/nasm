; Hello World Program (NULL terminating bytes)
; Compile with: nasm -f elf nullterminate.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 nullterminate.o -o nullterminate
; Run with: ./nullterminate
 
%include        'functions.asm'
 
SECTION .data
msg1    db      'Hello, brave new world!', 0Ah, 0h          ; NOTE the null terminating byte
msg2    db      'This is how we recycle in NASM.', 0Ah, 0h  ; NOTE the null terminating byte
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, msg1
    call    sprint
 
    mov     eax, msg2
    call    sprint
 
    call    quit
