#include <stdio.h>
#include <unistd.h>

__attribute__((noinline))
void vitoria(void)
{
    static const char message[] = "mensagem benigna de sucesso\n";
    (void)write(STDOUT_FILENO, message, sizeof(message) - 1);
}

__attribute__((noinline))
static void recebe_entrada(void)
{
    char buffer[64];

    puts("alvo local de estudo; entrada lida em buffer fixo");
    (void)read(STDIN_FILENO, buffer, 256);
    puts("fluxo normal concluido");
}

int main(void)
{
    recebe_entrada();
    return 0;
}
