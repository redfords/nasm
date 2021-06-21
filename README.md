# nasm
NASM

Linux instructions:

sudo apt-get install libc6-dev-i386

nasm -f elf ej1.asm

ld -m elf_i386 -s -o ej1 ej1.o -lc -I /lib/ld-linux.so.2

./ej1
