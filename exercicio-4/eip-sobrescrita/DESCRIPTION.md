<h2 align="center">Reconheça o valor que chegou ao EIP</h2>

> Alvo didático local de 32 bits. Não o exponha como serviço de rede.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

### Objetivo
Reconhecer (ler e registrar) o valor que chegou ao registrador de instrução
(**EIP**) numa execução de demonstração.

### O que já vem pronto
Este desafio é **conceitual**: não há arquivo para compilar nem GDB para rodar.
O enunciado já mostra a saída observada no debugger de demonstração:

```text
eip  0x42424242
```

### Passo a passo
1. Olhe o valor de `eip` na saída acima.
2. Registre **exatamente** esse valor hexadecimal.

### Resposta
Grave o valor em `/home/hacker/resposta-4.txt`, em uma linha, no formato `0x` +
8 dígitos hexadecimais:

```bash
printf '%s\n' '0x42424242' > /home/hacker/resposta-4.txt
```

### Verificar
```bash
/challenge/check
```

O desafio é sobre **reconhecer o dado observado**, não sobre executar código em
um endereço arbitrário.
