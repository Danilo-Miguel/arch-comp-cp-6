<h2 align="center">Reconheça o valor que chegou ao EIP</h2>

> Alvo didático local de 32 bits. Não o exponha como serviço de rede.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Ler e registrar o valor que chegou ao registrador de instrução (EIP) em uma
execução de demonstração.

### O que já vem pronto
Este desafio é só de interpretação. Não há arquivo para compilar nem GDB para
rodar. O próprio enunciado já mostra o que o debugger exibiu:

```text
eip  0x42424242
```

### Passo a passo
1. Olhe o valor de `eip` mostrado acima.
2. Registre exatamente esse valor hexadecimal.

### Resposta
O valor de `eip`, no formato `0x` seguido de 8 dígitos. Grave em
`/home/hacker/resposta-4.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-4.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' '0x42424242' > /home/hacker/resposta-4.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```

O desafio é sobre reconhecer o dado observado, não sobre executar código em um
endereço qualquer.
