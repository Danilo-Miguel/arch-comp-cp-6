#include <stdio.h>
#include <string.h>

struct estado {
    char buffer[8];
    unsigned int autorizado;
};

int main(int argc, char **argv)
{
    struct estado alvo = { .buffer = {0}, .autorizado = 0 };

    if (argc != 2) {
        fprintf(stderr, "uso: %s <entrada>\n", argv[0]);
        return 2;
    }

    strcpy(alvo.buffer, argv[1]);
    printf("autorizado = 0x%08x\n", alvo.autorizado);
    puts(alvo.autorizado ? "acesso liberado" : "acesso negado");
    return 0;
}
