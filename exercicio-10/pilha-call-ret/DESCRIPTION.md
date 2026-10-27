<h2 align="center">De onde ret obtém o próximo RIP?</h2>

> Exercício local de leitura de fluxo de controle.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Entender de onde a instrução `ret` tira o endereço da próxima instrução a
executar. A resposta é o topo da pilha, que foi onde o `call` guardou o endereço
de retorno.

### O que já vem pronto
O programa `/challenge/pilha-call-ret.asm` já está no ambiente. Ele faz um `call`
para uma função que só executa `ret`. Você monta e observa no GDB o que acontece
com a pilha no `call` e no `ret`.

### Passo a passo
1. Monte e gere o executável:
   ```bash
   nasm -f elf64 -g -F dwarf /challenge/pilha-call-ret.asm -o /tmp/pilha-call-ret.o
   ld /tmp/pilha-call-ret.o -o /tmp/pilha-call-ret
   ```
2. Pare no `call` e no `ret` e olhe a pilha:
   ```bash
   gdb /tmp/pilha-call-ret
   # (gdb) starti           inicia e para na primeira instrucao
   # (gdb) stepi            avance ate logo depois do call
   # (gdb) x/gx $rsp        mostra o valor que esta no topo da pilha
   # (gdb) info registers rip rsp
   ```
   No `call`, o processador guarda na pilha o endereço da instrução seguinte. No
   `ret`, ele pega o valor do topo da pilha e usa como próximo endereço.

### Resposta
Este desafio é conceitual. A resposta é a expressão exata que descreve de onde
vem o próximo endereço. Grave `topo-da-pilha` em `/home/hacker/resposta-10.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-10.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'topo-da-pilha' > /home/hacker/resposta-10.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
