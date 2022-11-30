global my_ASM
    section .text

my_ASM:
    ;rdi -> *v1
    ;rsi -> *v2
    ;rdx -> N

    cmp rsi,0
    je fin
    xor rax,rax

    xorpd xmm0,xmm0
    xorpd xmm1,xmm1
    xorpd xmm2,xmm2
    xorpd xmm3,xmm3

    xor r10,r10; Contador 1
    xor r11,r11
    xor r12,r12
    xor r14,r14; Contador 2
    
    mov r11,rdx 
    mov r12,rdx

    dec r11   ; r11 -> N-1 Tope 1
    sub r12,2 ; r12 -> N-2 Tope 2

    mov rax,rsi; rax tendra el valor de v2[]

    

bucle_1:

    movss xmm0,[rdi+4] 
    movss xmm1,[rdi]
    subss xmm0,xmm1

    movss [rsi],xmm0

    add rdi,4
    add rsi,4

    add r10,1
    cmp r10,r11
    je formatear
    jmp bucle_1

formatear:
    
    mov rsi,rax
    jmp condicional_2

condicional_2:

    cmp r14,r12
    je cambio

    movss xmm0,[rsi+4] 
    movss xmm1,[rsi]
    subss xmm0,xmm1

    movss [rsi],xmm0
    

bucle_2:

    add rsi,4

    add r14,1
    cmp r14,r11
    je fin
    jmp condicional_2

cambio:
    movss [rsi],xmm3 ;arr[N-2]=0
    jmp bucle_2

fin:
    ret