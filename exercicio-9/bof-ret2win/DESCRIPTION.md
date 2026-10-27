<h2 align="center">Entenda o destino ret2win</h2>

> Exercício conceitual baseado no alvo benigno do PDF de Buffer Overflow.
> Não use esta técnica fora do binário local de laboratório.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Identificar o **nome da função** que seria o destino de uma redireção *ret2win*
neste alvo vulnerável — a função que imprime a mensagem de sucesso e não faz
parte do fluxo normal.

### O que já vem pronto
O código-fonte **`/challenge/bof-ret2win.c` já está no ambiente**. Ele lê a
entrada em um buffer fixo (vulnerável), mas aqui a tarefa é só **identificar o
símbolo de destino** — sem construir ou executar uma entrada de sobrescrita.

### Passo a passo
1. Compile com símbolos:
   ```bash
   gcc -g -O0 -fno-stack-protector -fno-pie -no-pie \
       /challenge/bof-ret2win.c -o /tmp/bof-ret2win
   ```
2. Liste os símbolos e localize a função de sucesso:
   ```bash
   nm /tmp/bof-ret2win
   # dica: nm /tmp/bof-ret2win | grep ' [tT] '
   ```

### Resposta
Grave **somente o nome da função** em `/home/hacker/resposta-9.txt`, em uma
linha:

```bash
printf '%s\n' 'nome_da_funcao' > /home/hacker/resposta-9.txt
```

### Verificar
```bash
/challenge/check
```
