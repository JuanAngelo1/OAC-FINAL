nasm -f elf64 my_ASM.asm -o my_ASM.o -g
nasm -f elf64 my_ASM_SIMD.asm -o my_ASM_SIMD.o -g
gcc -shared my_C.c my_ASM.o my_ASM_SIMD.o -o lib.so 
python3 plantilla.py