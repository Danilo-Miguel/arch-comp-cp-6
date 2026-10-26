; Prática de observação da pilha: complete o exercício no ambiente do dojo.
; Objetivo: empilhar 10, 20 e 30, depois desempilhar na ordem LIFO.
; Finalize com o primeiro valor desempilhado como código de saída.

section .text
global _start

_start:
    ; TODO: use push/pop e encerre com a syscall exit.
    mov eax, 60
    xor edi, edi
    syscall
