; Encerra normalmente com status 0.

section .text
global _start

_start:
    xor edi, edi
    push 60
    pop rax
    syscall
