<h2 align="center">Meça dois pushes</h2>

> Prática local de x86-64.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Medir quantos bytes o topo da pilha (o registrador RSP) anda depois de dois
`push`. Em x86-64, cada valor colocado na pilha ocupa um espaço de 8 bytes.

### O que já vem pronto
O programa `/challenge/pilha-rsp.asm` já está no ambiente. Ele anota o topo da
pilha antes e depois de dois `push`, calcula a diferença e termina usando essa
diferença como código de saída. Você só monta e observa.

### Passo a passo
1. Monte e gere o executável:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-rsp.asm -o /tmp/pilha-rsp.o
   ld /tmp/pilha-rsp.o -o /tmp/pilha-rsp
   ```
2. Observe o topo da pilha antes e depois dos dois `push` no GDB:
   ```bash
   gdb /tmp/pilha-rsp
   # (gdb) starti           inicia e para na primeira instrucao
   # (gdb) print $rsp       valor do topo antes dos push
   # (gdb) stepi            avance ate passar pelos dois push
   # (gdb) print $rsp       valor do topo depois; compare os dois
   ```
3. Atalho: o programa já devolve a diferença como código de saída:
   ```bash
   /tmp/pilha-rsp; echo "deslocamento = $?"
   ```

### Resposta
Somente o deslocamento total em bytes, em decimal. Grave em
`/home/hacker/resposta-6.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-6.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'SEU_NUMERO' > /home/hacker/resposta-6.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
