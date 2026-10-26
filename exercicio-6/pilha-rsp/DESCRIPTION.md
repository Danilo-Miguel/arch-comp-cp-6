<h2 align="center">Meça dois pushes</h2>

> Prática local de x86-64. Você só pode errar uma vez; o segundo erro
> invalida este desafio.

Monte `pilha-rsp.asm` e use o GDB para observar o RSP antes e depois de dois
`push`. Em x86-64, cada valor empilhado ocupa um slot de 8 bytes.

```bash
nasm -f elf64 -g -F dwarf /challenge/pilha-rsp.asm -o /tmp/pilha-rsp.o
ld /tmp/pilha-rsp.o -o /tmp/pilha-rsp
gdb /tmp/pilha-rsp
```

Registre em `/home/hacker/resposta-6.txt` o deslocamento total em bytes,
como número decimal.

```bash
/challenge/check
```
