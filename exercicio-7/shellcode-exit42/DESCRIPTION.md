<h2 align="center">Saia com código 42</h2>

> Exercício local de assembly x86-64: a única ação do código é finalizar o
> processo com status 42.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Extrair os **bytes de máquina** de um shellcode que usa a pilha para preparar e
chamar `exit(42)`, e registrar esses bytes em hexadecimal.

### O que já vem pronto
O fonte **`/challenge/shellcode-exit42.asm` já está no ambiente**. Ele usa
`push`/`pop` para carregar a constante `42` e o número da syscall, e então
dispara `syscall`. Você só monta, inspeciona e copia os bytes. **Não execute**
os bytes brutos.

### Passo a passo
1. Monte o objeto:
   ```bash
   nasm -f elf64 -o /tmp/exit42.o /challenge/shellcode-exit42.asm
   ```
2. Confira a desmontagem:
   ```bash
   objdump -d /tmp/exit42.o
   ```
3. Extraia a seção `.text` e liste os bytes:
   ```bash
   objcopy -O binary -j .text /tmp/exit42.o /tmp/exit42.bin
   od -An -tx1 /tmp/exit42.bin
   ```
4. Junte os bytes em ordem, **sem espaços**.

### Resposta
Grave os bytes em hexadecimal, minúsculo e **sem espaços**, em uma linha, em
`/home/hacker/resposta-7.txt`:

```bash
printf '%s\n' 'cole_os_bytes_aqui' > /home/hacker/resposta-7.txt
```

### Verificar
```bash
/challenge/check
```
