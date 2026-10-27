<h2 align="center">Identifique a função de destino benigna</h2>

> Exercício conceitual, restrito ao binário local do laboratório.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Descobrir o nome de uma função que existe no programa mas que nunca é chamada no
funcionamento normal. Em um ataque do tipo ret2win, é para ela que a execução
seria desviada.

### O que já vem pronto
O programa `/challenge/eip-ret2win.c` já está no ambiente. Dentro dele há uma
função que só imprime uma mensagem de sucesso e que a `main` nunca chama. Você
compila e consulta a lista de funções do programa. Não é preciso montar nenhuma
entrada nem executar nada fora do normal.

### Passo a passo
1. Compile com informações de nomes:
   ```bash
   gcc -g -O0 -fno-pie -no-pie /challenge/eip-ret2win.c -o /tmp/eip-ret2win
   ```
2. Liste as funções do programa com o comando `nm` e procure a que não faz parte
   do fluxo normal:
   ```bash
   nm /tmp/eip-ret2win
   # dica: para ver só as funções de código, use
   nm /tmp/eip-ret2win | grep ' [tT] '
   ```

### Resposta
Somente o nome dessa função (sem endereço). Grave em
`/home/hacker/resposta-8.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-8.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'nome_da_funcao' > /home/hacker/resposta-8.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
