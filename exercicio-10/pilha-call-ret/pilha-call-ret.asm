; Observe onde call guarda o endereco de retorno e como ret o reutiliza.

section .text
global _start

_start:
    call funcao
    mov eax, 60
    xor edi, edi
    syscall

funcao:
    ret
