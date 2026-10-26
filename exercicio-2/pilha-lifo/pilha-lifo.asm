; Empilha 10, 20 e 30, desempilha na ordem LIFO e sai com status 10.

section .text
global _start

_start:
    push 10
    push 20
    push 30
    pop rax
    pop rbx
    pop rcx
    mov rdi, rcx
    mov eax, 60
    syscall
