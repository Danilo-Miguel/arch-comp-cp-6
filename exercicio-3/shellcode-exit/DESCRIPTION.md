<h2 align="center">Primeiro shellcode: encerramento seguro</h2>

> Exercício local de análise de bytes. O objetivo é encerrar um processo de
> teste; não há shell, rede ou persistência.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Extrair os **bytes de máquina** (opcodes) de um shellcode mínimo que apenas
chama a syscall `exit(0)` e registrar esses bytes em hexadecimal.

### O que já vem pronto
O fonte **`/challenge/shellcode-exit.asm` já está no ambiente**. Você só monta,
inspeciona e copia os bytes da seção `.text`. **Não execute** o binário bruto;
o exercício é só de leitura dos bytes.

### Passo a passo
1. Monte o objeto:
   ```bash
   nasm -f elf64 -o /tmp/exit.o /challenge/shellcode-exit.asm
   ```
2. Confira a desmontagem (para entender cada instrução):
   ```bash
   objdump -d /tmp/exit.o
   ```
3. Extraia **somente** a seção `.text` e liste os bytes:
   ```bash
   objcopy -O binary -j .text /tmp/exit.o /tmp/exit.bin
   od -An -tx1 /tmp/exit.bin
   ```
4. Junte os bytes exibidos, em ordem, **sem espaços** (ex.: `90 cc` vira `90cc`).

### Resposta
Grave a sequência de bytes em hexadecimal, minúsculo e **sem espaços**, em uma
linha, em `/home/hacker/resposta-3.txt`:

```bash
printf '%s\n' 'cole_os_bytes_aqui' > /home/hacker/resposta-3.txt
```

### Verificar
```bash
/challenge/check
```

Versão segura da primeira prática do PDF de Shellcode: a única ação permitida
é a saída normal do processo.
