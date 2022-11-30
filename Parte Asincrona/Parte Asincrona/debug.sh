#!/bin/bash
# Para ejecutar archivos .sh -> bash compilar.sh

nasm -f elf64 -g my_ASM_SIMD.asm -o my_ASM_SIMD.o -g
gcc my_ASM.o my_ASM_SIMD.o lib.c -o lib -lm -g
gdb lib
#shell clear
#break my_ASM_SIMD
#set disassembly-flavor intel
#run
#break condicional