<h2 align="center">Identifique a função de destino benigna</h2>

> Exercício conceitual, restrito ao binário local do laboratório.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Identificar o **nome da função** que seria o destino de uma técnica *ret2win*:
uma função que existe no binário mas **não** é chamada pelo fluxo normal.

### O que já vem pronto
O código-fonte **`/challenge/eip-ret2win.c` já está no ambiente**. Ele tem uma
função que só imprime uma mensagem de sucesso e nunca é chamada por `main`.
Você compila e lê a tabela de símbolos — **não** precisa construir payload nem
executar nada arbitrário.

### Passo a passo
1. Compile com símbolos:
   ```bash
   gcc -g -O0 -fno-pie -no-pie /challenge/eip-ret2win.c -o /tmp/eip-ret2win
   ```
2. Liste os símbolos e procure a função que não faz parte do fluxo normal:
   ```bash
   nm /tmp/eip-ret2win
   # dica: filtre funções do texto -> nm /tmp/eip-ret2win | grep ' [tT] '
   ```

### Resposta
Grave **somente o nome da função** (sem endereço) em
`/home/hacker/resposta-8.txt`, em uma linha:

```bash
printf '%s\n' 'nome_da_funcao' > /home/hacker/resposta-8.txt
```

### Verificar
```bash
/challenge/check
```
