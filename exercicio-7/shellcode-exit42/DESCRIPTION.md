<h2 align="center">Saia com código 42</h2>

> Exercício local de assembly x86-64: a única ação do código é finalizar o
> processo com status 42.

Use a pilha para carregar a constante e prepare a syscall `exit`. Monte o
arquivo, confira a desmontagem e extraia somente a seção `.text`:

```bash
nasm -f elf64 -o /tmp/exit42.o shellcode-exit42.asm
objdump -d /tmp/exit42.o
objcopy -O binary -j .text /tmp/exit42.o /tmp/exit42.bin
od -An -tx1 /tmp/exit42.bin
```

Registre os bytes em hexadecimal, sem espaços, em
`/home/hacker/resposta-7.txt`. Não execute bytes que não tenha inspecionado.

```bash
/challenge/check
```
