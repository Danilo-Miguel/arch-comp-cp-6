# Respostas dos desafios PWN

Use uma resposta por arquivo, conforme o desafio. Os valores abaixo são as
respostas aceitas pelo verificador:

| Exercício | Arquivo | Resposta |
|---|---|---|
| 1 — `bof-vizinho` | `resposta-1.txt` | `0x41414141` |
| 2 — `pilha-lifo` | `resposta-2.txt` | `30,20,10;10` |
| 3 — `shellcode-exit` | `resposta-3.txt` | `31ff6a3c580f05` |
| 4 — `eip-sobrescrita` | `resposta-4.txt` | `0x42424242` |
| 5 — `bof-offset` | `resposta-5.txt` | `72` |
| 6 — `pilha-rsp` | `resposta-6.txt` | `16` |
| 7 — `shellcode-exit42` | `resposta-7.txt` | `6a2a5f6a3c580f05` |
| 8 — `eip-ret2win` | `resposta-8.txt` | `vitoria` |
| 9 — `bof-ret2win` | `resposta-9.txt` | `vitoria` |
| 10 — `pilha-call-ret` | `resposta-10.txt` | `topo-da-pilha` |

## Testar uma resposta errada

No ambiente do dojo, este exemplo registra uma resposta incorreta no desafio
1 e deve informar que resta uma tentativa:

```bash
printf '%s\n' '0x41414140' > /home/hacker/resposta-1.txt
/challenge/check
```

Para testar a resposta correta depois:

```bash
printf '%s\n' '0x41414141' > /home/hacker/resposta-1.txt
/challenge/check
```

Não envie uma segunda resposta incorreta ao mesmo desafio: isso o invalida.
