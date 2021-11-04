# NASM

The Netwide Assembler (NASM) is an assembler and disassembler for the Intel x86 architecture. It can be used to write 16-bit, 32-bit (IA-32) and 64-bit (x86-64) programs.

## Structure of a NASM program

ASM is line-based. Most programs consist of directives followed by one or more sections. Lines can have an optional label. Most lines have an instruction followed by zero or more operands.



Generally, you put code in a section called .text and your constant data in a section called .data.

## How to run on Linux

Install the libc6-dev-i386 package:
```
	sudo apt-get install libc6-dev-i386
```

Run the .asm file:
```
	nasm -f elf ejercicio1.asm
	ld -m elf_i386 -s -o ejercicio1 ejercicio1.o -lc -I /lib/ld-linux.so.2
	./ejercicio1
```
## Resources

[Learn Assembly Language](https://asmtutor.com/)

[Ray Toal - Loyola Marymount University](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

[Assembly Language Tutorial](http://www.pravaraengg.org.in/Download/MA/assembly_tutorial.pdf)

[X64 Linux Assembly Environment Setup](https://epi052.gitlab.io/notes-to-self/blog/2018-07-22-x64-linux-assembly-environment-setup/)
