; Compare o RSP antes e depois de dois push no GDB.

section .text
global _start

_start:
    mov rax, rsp
    push 111
    push 222
    mov rbx, rsp
    sub rax, rbx
    mov rdi, rax
    mov eax, 60
    syscall
