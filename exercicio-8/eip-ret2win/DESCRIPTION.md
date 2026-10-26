<h2 align="center">Identifique a função de destino benigna</h2>

> O exercício é conceitual e restrito ao binário local do laboratório.
> Você só pode errar uma vez; o segundo erro invalida o desafio.

O PDF apresenta uma função chamada `vitoria`, que não é chamada pelo fluxo
normal do programa e apenas imprime uma mensagem de sucesso. Em um cenário
controlado, a técnica ret2win redireciona a execução para essa função.

Use o código local como referência e liste os símbolos:

```bash
gcc -g -O0 -fno-pie -no-pie /challenge/eip-ret2win.c -o /tmp/eip-ret2win
nm /tmp/eip-ret2win
```

Registre o nome do símbolo de destino (sem endereço) em
`/home/hacker/resposta-8.txt`. Este exercício não pede um payload nem a
execução de bytes arbitrários.

```bash
/challenge/check
```
