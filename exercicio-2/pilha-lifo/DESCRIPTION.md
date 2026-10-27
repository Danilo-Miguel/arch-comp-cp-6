<h2 align="center">Observe a ordem LIFO</h2>

> Prática local de assembly x86-64.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Ver na prática que a pilha funciona como LIFO (o último que entra é o primeiro
que sai) e anotar duas coisas: a ordem em que os valores saem e o código com que
o programa termina.

### O que já vem pronto
O programa `/challenge/pilha-lifo.asm` já está no ambiente. Ele coloca na pilha
os valores 10, 20 e 30, depois retira esses valores um a um, e no final encerra
usando o último valor retirado como código de saída. Você só monta e observa.

### Passo a passo
1. Monte e gere o executável:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-lifo.asm -o /tmp/pilha-lifo.o
   ld /tmp/pilha-lifo.o -o /tmp/pilha-lifo
   ```
2. (Opcional, mas recomendado) acompanhe no GDB a ordem em que os valores saem:
   ```bash
   gdb /tmp/pilha-lifo
   # (gdb) starti           inicia e para na primeira instrucao
   # (gdb) stepi            avanca uma instrucao por vez
   # (gdb) info registers rax rbx rcx   mostra os valores retirados
   ```
3. Descubra o código de saída rodando o programa e lendo o resultado:
   ```bash
   /tmp/pilha-lifo; echo "codigo de saida = $?"
   ```
4. Anote os três valores na ordem em que saíram e o código de saída.

### Resposta
Uma única linha no formato `valores;codigo`, com os valores separados por
vírgula e sem espaços (exemplo de formato, não é a resposta: `1,2,3;9`). Grave
em `/home/hacker/resposta-2.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-2.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'v1,v2,v3;codigo' > /home/hacker/resposta-2.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
