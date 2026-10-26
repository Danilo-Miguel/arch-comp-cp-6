<h2 align="center">Observe a ordem LIFO</h2>

> Prática local de assembly x86-64. Você só pode errar uma vez; o segundo
> erro invalida este desafio.

Use o roteiro abaixo para acompanhar a pilha em um debugger. Em NASM, monte
um programa que empilhe os valores 10, 20 e 30, desempilhe-os em registradores
e encerre com o primeiro valor removido como código de saída.

```bash
nasm -f elf64 -g -F dwarf pilha-lifo.asm -o /tmp/pilha-lifo.o
ld /tmp/pilha-lifo.o -o /tmp/pilha-lifo
gdb /tmp/pilha-lifo
```

Com o debugger, observe os valores no topo após os três `push` e a ordem dos
`pop`. Registre em `/home/hacker/resposta-2.txt`, em uma linha:
`valores-no-topo;codigo-de-saida` (decimal, separados por vírgulas).

```bash
/challenge/check
```

Não é necessário escrever código que leia entradas ou acesse recursos externos.
