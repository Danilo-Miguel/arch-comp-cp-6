; Usa push/pop para preparar exit(42), sem outras ações.

section .text
global _start

_start:
    push 42
    pop rdi
    push 60
    pop rax
    syscall
