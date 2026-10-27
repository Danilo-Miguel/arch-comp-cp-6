<h2 align="center">De onde ret obtém o próximo RIP?</h2>

> Exercício local de leitura de fluxo de controle.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Entender de onde a instrução `ret` tira o próximo endereço de execução (RIP):
do **topo da pilha**, onde o `call` guardou o endereço de retorno.

### O que já vem pronto
O programa **`/challenge/pilha-call-ret.asm` já está no ambiente**. Ele faz um
`call` para uma função que só executa `ret`. Você monta e observa no GDB o que
acontece com a pilha no `call` e no `ret`.

### Passo a passo
1. Monte e linke:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-call-ret.asm -o /tmp/pilha-call-ret.o
   ld /tmp/pilha-call-ret.o -o /tmp/pilha-call-ret
   ```
2. Pare no `call` e no `ret` e observe a pilha:
   ```bash
   gdb /tmp/pilha-call-ret
   # (gdb) starti
   # (gdb) stepi            -> até imediatamente antes do 'call'
   # (gdb) x/gx $rsp        -> veja o topo da pilha depois do call
   # (gdb) info registers rip rsp
   ```
   No `call`, o processador empilha o endereço da instrução seguinte. No `ret`,
   ele **retira o valor do topo da pilha** e o usa como próximo RIP.

### Resposta
Este desafio é conceitual: a resposta é a **expressão exata** que descreve a
origem do próximo RIP. Grave em `/home/hacker/resposta-10.txt`, em uma linha:

```bash
printf '%s\n' 'topo-da-pilha' > /home/hacker/resposta-10.txt
```

### Verificar
```bash
/challenge/check
```
