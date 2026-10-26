<h2 align="center">Calcule o offset até o retorno</h2>

> Exercício de análise de um frame local. Não use entradas contra programas
> de terceiros. Você só pode errar uma vez; o segundo erro invalida o desafio.

No exemplo x86-64 da aula, o frame contém um buffer local de 64 bytes e o
RBP salvo ocupa mais 8 bytes antes do endereço de retorno. Some os campos
para obter o deslocamento entre o início do buffer e o endereço de retorno.

Registre somente o deslocamento decimal em `/home/hacker/resposta-5.txt`.

```bash
/challenge/check
```

O foco é reconhecer o layout do frame apresentado no PDF de Buffer Overflow;
não é necessário construir uma entrada para executar código.
