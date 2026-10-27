<h2 align="center">Quando a entrada alcança a variável vizinha</h2>

> Alvo local, intencionalmente vulnerável e sem rede.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Descobrir qual valor hexadecimal a sua entrada grava na variável `autorizado`,
que fica na memória logo depois de um buffer de 8 bytes.

### O que já vem pronto
O código-fonte **`/challenge/bof-vizinho.c` já está no ambiente**. Você não
escreve nada em C — apenas compila e executa. A `struct` tem um `buffer[8]`
seguido de um `unsigned int autorizado`, e o programa faz `strcpy` da sua
entrada para o buffer (sem checar tamanho).

### Passo a passo
1. Compile o alvo:
   ```bash
   gcc -O0 -fno-stack-protector /challenge/bof-vizinho.c -o /tmp/bof-vizinho
   ```
2. Execute passando **12 letras `A`** (8 enchem o buffer; as 4 seguintes
   transbordam para `autorizado`):
   ```bash
   /tmp/bof-vizinho AAAAAAAAAAAA
   ```
3. Leia a linha `autorizado = 0x........` que o programa imprime. Esse é o
   valor formado pelos 4 bytes que ultrapassaram o buffer.

### Resposta
Grave **somente esse valor** em `/home/hacker/resposta-1.txt`, em uma única
linha, no formato `0x` + 8 dígitos hexadecimais (ex.: `0xaabbccdd`):

```bash
printf '%s\n' '0x________' > /home/hacker/resposta-1.txt   # troque pelo valor observado
```

> Grave como usuário `hacker` (sem `sudo`); o arquivo precisa ser seu.

### Verificar
```bash
/challenge/check
```

Reproduz a sobrescrita de variável adjacente do PDF de Buffer Overflow. O
verificador avalia apenas a observação registrada; ele não executa a sua
entrada como root.
