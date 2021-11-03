#!/bin/bash
rm -rf temp
mkdir temp

nasm -f elf32 oskernel.asm -o ./temp/oskernel.o
nasm -f elf32 liba.asm -o ./temp/liba.o 

gcc -c -m16 -march=i386 -masm=intel -nostdlib -ffreestanding -mpreferred-stack-boundary=2 -lgcc -shared libc.c -o ./temp/libc.o

ld -m elf_i386 -N -Ttext 0x8000 --oformat binary ./temp/oskernel.o ./temp/liba.o ./temp/libc.o -o ./temp/kernel.bin
echo "Done!"
