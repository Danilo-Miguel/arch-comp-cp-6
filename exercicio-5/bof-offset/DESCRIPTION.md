<h2 align="center">Calcule o offset até o retorno</h2>

> Exercício de análise de um frame local. Não use entradas contra programas
> de terceiros. Você só pode errar uma vez; o segundo erro invalida o desafio.

### Objetivo
Calcular o **deslocamento (offset) em bytes** entre o início do buffer local e o
endereço de retorno dentro do frame da função.

### O que já vem pronto
Este desafio é **conceitual**: não há arquivo para compilar nem GDB para rodar.
Use o layout do frame descrito abaixo (o mesmo do PDF de Buffer Overflow).

### Passo a passo
No exemplo x86-64 da aula, a pilha, do início do buffer até o endereço de
retorno, contém:

| Campo | Tamanho |
|---|---|
| Buffer local | 64 bytes |
| RBP salvo | 8 bytes |
| Endereço de retorno | (é o destino) |

1. Some os campos que ficam **antes** do endereço de retorno:
   `64 (buffer) + 8 (RBP salvo)`.
2. O resultado é quantos bytes é preciso avançar para alcançar o endereço de
   retorno.

### Resposta
Grave **somente o número decimal** em `/home/hacker/resposta-5.txt`, em uma
linha:

```bash
printf '%s\n' 'SEU_NUMERO' > /home/hacker/resposta-5.txt   # troque pelo resultado da soma
```

### Verificar
```bash
/challenge/check
```

O foco é reconhecer o layout do frame; não é preciso construir uma entrada para
executar código.
