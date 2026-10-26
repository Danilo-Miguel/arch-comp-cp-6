<h2 align="center">Entenda o destino ret2win</h2>

> Exercício conceitual baseado no alvo benigno do PDF de Buffer Overflow.
> Não use esta técnica fora do binário local de laboratório.

O programa de demonstração possui uma função `vitoria` que imprime uma
mensagem e retorna. Compare o fluxo normal com a função que seria o destino
de uma redireção controlada. A tarefa é identificar o nome dessa função,
sem construir ou executar uma entrada de sobrescrita.

Compile o alvo intencionalmente vulnerável dentro do container local do dojo
e confira os símbolos:

```bash
gcc -g -O0 -fno-stack-protector -fno-pie -no-pie \
    /challenge/bof-ret2win.c -o /tmp/bof-ret2win
nm /tmp/bof-ret2win
```

Registre somente o símbolo em `/home/hacker/resposta-9.txt`.

```bash
/challenge/check
```
