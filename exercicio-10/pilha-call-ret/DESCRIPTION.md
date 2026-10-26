<h2 align="center">De onde ret obtém o próximo RIP?</h2>

> Exercício local de leitura de fluxo de controle. Você só pode errar uma vez;
> o segundo erro invalida este desafio.

Monte `pilha-call-ret.asm` e pare no `call` e no `ret` com o GDB:

```bash
nasm -f elf64 -g -F dwarf /challenge/pilha-call-ret.asm -o /tmp/pilha-call-ret.o
ld /tmp/pilha-call-ret.o -o /tmp/pilha-call-ret
gdb /tmp/pilha-call-ret
```

No modelo x86-64 usado no PDF, `call` guarda na pilha o endereço da instrução
seguinte. Ao executar `ret`, o processador remove o valor do topo da pilha e
usa-o como próximo endereço de instrução.

Registre em `/home/hacker/resposta-10.txt` a expressão `topo-da-pilha`.

```bash
/challenge/check
```
