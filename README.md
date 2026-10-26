# PWN Dojo: Fundamentos de memória e fluxo de execução

Dojo para pwn.college com 10 desafios baseados nas primeiras práticas dos
quatro PDFs da disciplina e em exercícios introdutórios adicionais.
O formato de dojo/módulos e a política de tentativas tomam como referência
o repositório [arch-comp-cp-3](https://github.com/Danilo-Miguel/arch-comp-cp-3).

## Seleção dos desafios

Os quatro primeiros desafios correspondem à primeira prática de cada PDF.
Os outros seis foram escolhidos entre as práticas mais introdutórias, mantendo
a distribuição solicitada: 3 de buffer overflow, 3 de pilha, 2 de shellcode e
2 de controle do IP.

| # | Desafio | Categoria | Referência |
|---|---|---|---|
| 1 | `bof-vizinho` | Buffer overflow | BOF: sobrescrita de variável adjacente |
| 2 | `pilha-lifo` | Pilha | RSP/RIP/RBP: `push`, `pop` e LIFO |
| 3 | `shellcode-exit` | Shellcode | Shellcode: primeiro código e saída segura |
| 4 | `eip-sobrescrita` | Controle do IP | EIP: sobrescrever o ponteiro com `0x42424242` |
| 5 | `bof-offset` | Buffer overflow | BOF: calcular o offset de controle |
| 6 | `pilha-rsp` | Pilha | RSP/RIP/RBP: medir o deslocamento de RSP |
| 7 | `shellcode-exit42` | Shellcode | Shellcode: carregar uma constante e sair |
| 8 | `eip-ret2win` | Controle do IP | EIP: redirecionar para uma função benigna |
| 9 | `bof-ret2win` | Buffer overflow | BOF: redirecionar para uma função benigna |
| 10 | `pilha-call-ret` | Pilha | RSP/RIP/RBP: relação entre `call`, `ret` e RIP |

## Tentativas

Cada desafio permite uma resposta errada. A segunda resposta errada invalida
somente aquele desafio para o aluno. Arquivo ausente ou resposta fora do
formato solicitado não consome uma tentativa.

O contador é mantido em `/home/hacker/.tentativas`, em diretório pertencente
ao root. O dojo desativa o modo privilegiado (`allow_privileged: false`) para
que o aluno não possa remover esse registro com `sudo`. Cada verificador
executa as operações sobre arquivos do aluno como `hacker`, não como root.

## Uso

Importe este repositório como dojo no pwn.college. Os arquivos `.c` e `.asm`
são alvos locais de estudo; compile-os dentro do ambiente do dojo conforme
as instruções de cada desafio. Não use os exemplos contra sistemas ou
programas de terceiros.

Os exemplos de x86 de 32 bits podem exigir suporte de compilação multilib no
container. Os desafios de assembly x86-64 usam NASM e GNU binutils.
