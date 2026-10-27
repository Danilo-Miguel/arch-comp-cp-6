<h2 align="center">Entenda o destino ret2win</h2>

> Exercício conceitual baseado no alvo benigno do PDF de Buffer Overflow.
> Não use esta técnica fora do binário local de laboratório.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Descobrir o nome da função que imprime a mensagem de sucesso e que não faz parte
do funcionamento normal. É essa função que seria o destino de um desvio do tipo
ret2win neste programa vulnerável.

### O que já vem pronto
O programa `/challenge/bof-ret2win.c` já está no ambiente. Ele lê a entrada em um
espaço de tamanho fixo (por isso é vulnerável), mas aqui a tarefa é apenas
descobrir o nome da função de destino. Você não precisa montar nem executar
nenhuma entrada de ataque.

### Passo a passo
1. Compile com informações de nomes:
   ```bash
   gcc -g -O0 -fno-stack-protector -fno-pie -no-pie \
       /challenge/bof-ret2win.c -o /tmp/bof-ret2win
   ```
2. Liste as funções do programa com o comando `nm` e localize a função de
   sucesso:
   ```bash
   nm /tmp/bof-ret2win
   # dica: nm /tmp/bof-ret2win | grep ' [tT] '
   ```

### Resposta
Somente o nome dessa função. Grave em `/home/hacker/resposta-9.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-9.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'nome_da_funcao' > /home/hacker/resposta-9.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
