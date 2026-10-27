<h2 align="center">Primeiro shellcode: encerramento seguro</h2>

> Exercício local de análise de bytes. O objetivo é encerrar um processo de
> teste. Não há shell, rede ou persistência.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Obter os bytes (os números em hexadecimal) que representam as instruções de um
shellcode bem simples, cuja única ação é pedir ao sistema para encerrar o
processo com código 0.

### O que já vem pronto
O arquivo `/challenge/shellcode-exit.asm` já está no ambiente. Você só monta,
olha as instruções e copia os bytes. Não execute esses bytes soltos: aqui o
objetivo é apenas lê-los.

### Passo a passo
1. Monte o arquivo:
   ```bash
   nasm -f elf64 -o /tmp/exit.o /challenge/shellcode-exit.asm
   ```
2. Veja as instruções geradas, para entender o que o código faz:
   ```bash
   objdump -d /tmp/exit.o
   ```
3. Separe só a parte de código e liste os bytes em hexadecimal:
   ```bash
   objcopy -O binary -j .text /tmp/exit.o /tmp/exit.bin
   od -An -tx1 /tmp/exit.bin
   ```
4. Junte os bytes que apareceram, na mesma ordem, sem espaços entre eles
   (por exemplo, `90 cc` vira `90cc`).

### Resposta
Os bytes em hexadecimal, em letras minúsculas e sem espaços, em uma única linha.
Grave em `/home/hacker/resposta-3.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-3.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'cole_os_bytes_aqui' > /home/hacker/resposta-3.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```

Esta é uma versão segura da primeira prática do PDF de Shellcode: a única ação
permitida é a saída normal do processo.
