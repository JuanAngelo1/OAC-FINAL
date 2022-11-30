global my_ASM_SIMD
    section .text

my_ASM_SIMD:
    ;rdi -> *v1
    ;rsi -> *v2
    ;rdx -> N

    cmp rsi,0
    je fin

    xorpd xmm0,xmm0
    xorpd xmm2,xmm2
    xorpd xmm3,xmm3
    xorpd xmm4,xmm4
    xorpd xmm5,xmm5

    xor rax,rax
    
    xor r8,r8
    xor r9,r9
    xor r11,r11
    xor r12,r12
    xor r13,r13

    mov rax,rsi; rax tendra el valor de v2[]
    xorpd xmm1,xmm1 ; xmm1 ->  0 0 0 0
 
    mov r11,4
    cvtsi2ss xmm2,rdx; float(N)
    cvtsi2ss xmm0,r11; 4.0

    divss xmm2, xmm0; 8.0/4.0/=2.0

    cvtss2si r12,xmm2 ;r12=> N(4)

    mov r13,r12; r13 => N
    xor r10,r10; r10 Contador 1
    xor r14,r14; r14 Contador 2

    dec r12 ; r12=> N-1

    xorpd xmm0,xmm0
    xorpd xmm2,xmm2

condicional:

    cmp r10,r12
    je cambio

    movaps xmm0,[rdi] ; xmm0 -> A B C D
    movss xmm2,[rdi+16] ; xmm2-> E

    movaps xmm3,xmm0
    shufps xmm3,xmm2,10001110b;  10 00 11 10   xmm2 -> E 0 0 0  xmm3 -> A B C D  => xmm3 -> C D E 0 
    shufps xmm3,xmm0,11010010b;  11 01 00 10   xmm3 -> C D E 0  xmm0 -> A B C D  => xmm3 -> E C B D

    shufps xmm3,xmm3,00110110b;  10 01 11 00  xmm3-> E C B D --> xmm3-> B C D E

    subps xmm3,xmm0

    movaps [rsi],xmm3

bucle:

    add rdi,16
    add rsi,16

    add r10,1
    cmp r10,r13
    je formatear
    jmp condicional

cambio:
    movaps xmm0,[rdi] ; xmm0 -> E F G H    
    movaps xmm3,xmm0

    shufps xmm3,xmm3,11111001b;  11 11 10 01  xmm2 -> E F G H  xmm3 -> E F G H => xmm3 -> F G H H

    subps xmm3,xmm0
    movaps [rsi],xmm3
    jmp bucle

formatear:
    
    mov rsi,rax
    xor r10,r10
    jmp condicional_2

condicional_2:

    cmp r10,r12
    je cambio_2

    movaps xmm0,[rsi] ; xmm0 -> A B C D
    movss xmm2,[rsi+16] ; xmm2-> E

    movaps xmm3,xmm0
    shufps xmm3,xmm2,10001110b;  10 00 11 10   xmm2 -> E 0 0 0  xmm3 -> A B C D  => xmm3 -> C D E 0 
    shufps xmm3,xmm0,11010010b;  11 01 00 10   xmm3 -> C D E 0  xmm0 -> A B C D  => xmm3 -> E C B D

    shufps xmm3,xmm3,00110110b;  10 01 11 00  xmm3-> E C B D --> xmm3-> B C D E

    subps xmm3,xmm0

    movaps [rsi],xmm3

bucle_2:

    add rsi,16

    add r10,1
    cmp r10,r13
    je fin
    jmp condicional_2


cambio_2:
    movaps xmm0,[rsi] ; xmm0 -> E F G H    
    movaps xmm3,xmm0

    shufps xmm3,xmm3,11101001b;  11 //10 10 01  xmm2 -> E F G H  xmm3 -> E F G H => xmm3 -> F G H H

    subps xmm3,xmm0
    movaps [rsi],xmm3

    jmp bucle_2

fin:
    ret