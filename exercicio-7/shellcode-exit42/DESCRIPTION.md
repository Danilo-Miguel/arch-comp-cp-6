<h2 align="center">Saia com código 42</h2>

> Exercício local de assembly x86-64. A única ação do código é finalizar o
> processo com status 42.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Obter os bytes (os números em hexadecimal) de um shellcode que usa a pilha para
preparar e pedir ao sistema o encerramento com código 42.

### O que já vem pronto
O arquivo `/challenge/shellcode-exit42.asm` já está no ambiente. Ele usa `push`
e `pop` para carregar o número 42 e o número da operação de saída, e então
dispara a chamada. Você só monta, olha e copia os bytes. Não execute os bytes
soltos.

### Passo a passo
1. Monte o arquivo:
   ```bash
   nasm -f elf64 -o /tmp/exit42.o /challenge/shellcode-exit42.asm
   ```
2. Veja as instruções geradas:
   ```bash
   objdump -d /tmp/exit42.o
   ```
3. Separe só a parte de código e liste os bytes:
   ```bash
   objcopy -O binary -j .text /tmp/exit42.o /tmp/exit42.bin
   od -An -tx1 /tmp/exit42.bin
   ```
4. Junte os bytes na mesma ordem, sem espaços entre eles.

### Resposta
Os bytes em hexadecimal, em letras minúsculas e sem espaços, em uma única linha.
Grave em `/home/hacker/resposta-7.txt`.

Abra no nano (como fizemos em aula) e digite:
```bash
nano /home/hacker/resposta-7.txt
```
Salve com `Ctrl+O` e `Enter`, saia com `Ctrl+X`.

Alternativa pelo terminal:
```bash
printf '%s\n' 'cole_os_bytes_aqui' > /home/hacker/resposta-7.txt
```
Grave como usuário `hacker`, nunca com `sudo`.

### Verificar
```bash
/challenge/check
```
