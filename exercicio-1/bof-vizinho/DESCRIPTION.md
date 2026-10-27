<h2 align="center">Quando a entrada alcança a variável vizinha</h2>

> Alvo local, intencionalmente vulnerável e sem rede.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Descobrir qual valor hexadecimal a sua entrada acaba gravando na variável
vizinha, que fica na memória logo depois de um buffer de 8 caracteres.

### O que já vem pronto
O programa `/challenge/bof-vizinho.c` já está no ambiente. Você não escreve
nada, só compila e executa. Por dentro, ele tem duas variáveis guardadas uma ao
lado da outra na memória: um buffer de 8 caracteres e, logo depois dele, a
variável `autorizado`, que guarda um número. Ao copiar o texto que você passa
para o buffer, o programa não confere o tamanho. Então, se você digitar mais de
8 caracteres, o que passa do limite continua sendo escrito na memória seguinte e
acaba caindo dentro da variável `autorizado`.

### Passo a passo
1. Compile o programa:
   ```bash
   gcc -O0 -fno-stack-protector /challenge/bof-vizinho.c -o /tmp/bof-vizinho
   ```
2. Execute passando 12 letras `A`. As 8 primeiras preenchem o buffer; as 4
   seguintes invadem a variável vizinha:
   ```bash
   /tmp/bof-vizinho AAAAAAAAAAAA
   ```
3. Leia a linha `autorizado = 0x........` que aparece na tela. Esse é o valor
   formado pelos 4 caracteres que passaram do limite.

### Resposta
A resposta é esse valor hexadecimal, no formato `0x` seguido de 8 dígitos
(exemplo de formato: `0xaabbccdd`). Grave em `/home/hacker/resposta-1.txt`.

Abra o arquivo no nano (como fizemos em aula) e digite o valor:
```bash
nano /home/hacker/resposta-1.txt
```
Digite o valor, salve com `Ctrl+O` e `Enter`, e saia com `Ctrl+X`.

Se preferir, dá para gravar direto pelo terminal:
```bash
printf '%s\n' '0x________' > /home/hacker/resposta-1.txt
```
Grave sempre como usuário `hacker`, nunca com `sudo`, senão o verificador não
consegue ler o arquivo.

### Verificar
```bash
/challenge/check
```

Este é o exemplo de sobrescrita de variável vizinha do PDF de Buffer Overflow.
O verificador olha apenas o valor que você anotou; ele não executa a sua
entrada como root.
