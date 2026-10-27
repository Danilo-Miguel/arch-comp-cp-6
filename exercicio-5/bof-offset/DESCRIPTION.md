<h2 align="center">Calcule o offset até o retorno</h2>

> Exercício de análise de um frame local. Não use entradas contra programas
> de terceiros. Você só pode errar uma vez; o segundo erro invalida o desafio.

### Objetivo
Calcular quantos bytes existem entre o início do buffer (a variável local) e o
endereço de retorno (o endereço para onde a função volta quando termina).

### O que já vem pronto
Este desafio é só de cálculo. Não há arquivo para compilar nem GDB para rodar.
Use os tamanhos do exemplo da aula (o mesmo do PDF de Buffer Overflow),
mostrados abaixo.

### Passo a passo
Na pilha, do início do buffer até o endereço de retorno, existem dois campos
antes dele:

| Campo | Tamanho |
|---|---|
| Buffer (variável local) | 64 bytes |
| RBP salvo (o registrador base guardado na pilha) | 8 bytes |

1. Some os dois campos que ficam antes do endereço de retorno:
   `64 + 8`.
2. O resultado é quantos bytes você precisa avançar para chegar ao endereço de
   retorno.

### Resposta
Somente o número em decimal. Grave em `/home/hacker/resposta-5.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-5.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'SEU_NUMERO' > /home/hacker/resposta-5.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```

O foco é reconhecer a organização desses campos na pilha. Não é preciso montar
uma entrada para executar código.
