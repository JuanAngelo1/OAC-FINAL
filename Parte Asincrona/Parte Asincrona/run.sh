#!/bin/bash
# Para ejecutar archivos .sh -> bash compilar.sh

nasm -f elf64 my_ASM.asm -o my_ASM.o
nasm -f elf64 my_ASM_SIMD.asm -o my_ASM_SIMD.o 
gcc my_ASM.o my_ASM_SIMD.o lib.c -o lib.o -lm
./lib.o