<h2 align="center">Quando a entrada alcança a variável vizinha</h2>

> Este é um alvo local, intencionalmente vulnerável e sem comunicação de rede.
> Você só pode errar uma vez; o segundo erro invalida este desafio.

O programa `bof-vizinho.c` contém uma flag inteira ao lado de um buffer de
8 bytes. Compile e execute-o somente dentro do ambiente do dojo:

```bash
gcc -O0 -fno-stack-protector /challenge/bof-vizinho.c -o /tmp/bof-vizinho
/tmp/bof-vizinho AAAAAAAAAAAA
```

Observe o valor hexadecimal da flag após a cópia. Explique qual valor foi
formado pelos quatro caracteres que ultrapassaram o buffer e registre esse
valor, em hexadecimal, em `/home/hacker/resposta-1.txt`.

```bash
/challenge/check
```

O exercício reproduz a prática introdutória de sobrescrita adjacente do PDF
de Buffer Overflow. O verificador avalia a observação registrada; ele não
executa a entrada fornecida pelo aluno como root.
