<h2 align="center">Primeiro shellcode: encerramento seguro</h2>

> Exercício local de análise de bytes. O objetivo é encerrar um processo de
> teste; não há shell, rede ou persistência.

Monte o arquivo `/challenge/shellcode-exit.asm`, que usa a syscall `exit`
com código zero. Extraia os bytes de instrução do objeto e inspecione-os
antes de qualquer execução. Não use um loader de memória executável para
bytes não verificados.

```bash
nasm -f elf64 -o /tmp/exit.o shellcode-exit.asm
objdump -d /tmp/exit.o
objcopy -O binary -j .text /tmp/exit.o /tmp/exit.bin
od -An -tx1 /tmp/exit.bin
```

Registre a sequência de bytes em hexadecimal, sem espaços, em
`/home/hacker/resposta-3.txt`.

```bash
/challenge/check
```

Esta é uma versão segura da primeira prática do PDF: a ação permitida é
somente a saída normal do processo.
