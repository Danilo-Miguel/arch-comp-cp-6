<h2 align="center">Meça dois pushes</h2>

> Prática local de x86-64.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Medir **quantos bytes o RSP se move** depois de dois `push`. Em x86-64 cada
valor empilhado ocupa um slot de 8 bytes.

### O que já vem pronto
O programa **`/challenge/pilha-rsp.asm` já está no ambiente**. Ele salva o RSP
antes e depois de dois `push`, calcula a diferença e encerra usando essa
diferença como código de saída. Você só monta e observa.

### Passo a passo
1. Monte e linke:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-rsp.asm -o /tmp/pilha-rsp.o
   ld /tmp/pilha-rsp.o -o /tmp/pilha-rsp
   ```
2. Observe o RSP antes e depois dos dois `push` no GDB:
   ```bash
   gdb /tmp/pilha-rsp
   # (gdb) starti
   # (gdb) print $rsp        -> valor inicial
   # avance com 'stepi' pelos dois push
   # (gdb) print $rsp        -> valor final; compare os dois
   ```
3. Alternativa rápida: o programa já retorna a diferença como código de saída:
   ```bash
   /tmp/pilha-rsp; echo "deslocamento = $?"
   ```

### Resposta
Grave **somente o deslocamento total em bytes** (número decimal) em
`/home/hacker/resposta-6.txt`, em uma linha:

```bash
printf '%s\n' 'SEU_NUMERO' > /home/hacker/resposta-6.txt
```

### Verificar
```bash
/challenge/check
```
