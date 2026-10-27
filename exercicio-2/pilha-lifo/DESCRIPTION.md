<h2 align="center">Observe a ordem LIFO</h2>

> Prática local de assembly x86-64.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Entender que a pilha é **LIFO** (o último a entrar é o primeiro a sair) e
identificar (a) a ordem em que os valores saem nos `pop` e (b) o código de
saída do programa.

### O que já vem pronto
O programa **`/challenge/pilha-lifo.asm` já está no ambiente**. Ele empilha
`10`, `20` e `30`, depois desempilha em três registradores e encerra usando o
**último valor desempilhado** como código de saída. Você só monta e observa.

### Passo a passo
1. Monte e linke:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-lifo.asm -o /tmp/pilha-lifo.o
   ld /tmp/pilha-lifo.o -o /tmp/pilha-lifo
   ```
2. (Opcional, recomendado) acompanhe no GDB a ordem dos `pop`:
   ```bash
   gdb /tmp/pilha-lifo
   # (gdb) starti        -> para na primeira instrução
   # (gdb) info registers rax rbx rcx
   # avance com 'stepi' observando cada pop
   ```
3. Anote **os três valores na ordem em que saem** (do primeiro `pop` ao
   último) e o **código de saída** (o valor que vai para `rdi`). Confira o
   código de saída com:
   ```bash
   /tmp/pilha-lifo; echo "codigo de saida = $?"
   ```

### Resposta
Em `/home/hacker/resposta-2.txt`, uma única linha no formato
`valores-na-ordem-dos-pop;codigo-de-saida` (decimais, valores separados por
vírgula; sem espaços). Exemplo de **formato** (não é a resposta): `1,2,3;9`.

```bash
printf '%s\n' 'v1,v2,v3;codigo' > /home/hacker/resposta-2.txt   # troque pelos valores observados
```

### Verificar
```bash
/challenge/check
```

Não é preciso ler entradas nem acessar recursos externos.
