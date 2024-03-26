[bits 64]

section .data

   imun db "Enter username: "
   limun equ $ - imun

   impw db "Enter password: "
   limpw equ $ - impw

   bun db "aspect", 10, 0
   bpw db "passwd123", 10, 0

   nl db 0x0a
   
   iun times 32 db 0
   ipw times 32 db 0

   liun equ $ - iun
   lipw equ $ - ipw

   newline db 0x0a

section .text
    global _start

_start:
    mov rax,    1
    mov rdi,    1
    mov rsi,    imun
    mov rdx,    limun
    syscall

    mov rax,    0
    mov rdi,    0
    mov rsi,    iun
    mov rdx,    50
    syscall

    mov rax,    1
    mov rdi,    1
    mov rsi,    impw
    mov rdx,    limpw
    syscall

    mov rax,    0
    mov rdi,    0
    mov rsi,    ipw
    mov rdx,    50
    syscall

    mov rsi,    iun
    mov rdi,    bun

    jmp compare_user

compare_user:
    mov al,     [rsi]
    mov bl,     [rdi]

    cmp al, bl
    jne fail

    cmp al, 0
    je start_compare_password

    inc rsi
    inc rdi
    jmp compare_user


start_compare_password:
    mov esi,    ipw
    mov edi,    bpw

    jmp compare_password


compare_password:
    mov al,     [esi]
    mov bl,     [edi]

    cmp al, bl
    jne fail

    cmp al, 0
    je success

    inc     rsi
    inc     rdi
    jmp     compare_password

success:
   section .data
    sm db "Successfully logged in"
    smlen equ $ - sm

   section .text
      global _success

   _success:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, sm
        mov     rdx, smlen
        syscall   

        mov     rax, 1
        mov     rdi, 1
        mov     rsi, nl
        mov     rdx, 1
        syscall   

        jmp end

        

fail:
   section .data
    fl db "Invalid username or password"
    fllen equ $ - sm

   section .text

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, fl
    mov     rdx, fllen
    syscall   

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, nl
    mov     rdx, 1
    syscall   

    jmp end


end:
    mov rax, 60
    xor rdi, rdi

    syscall
