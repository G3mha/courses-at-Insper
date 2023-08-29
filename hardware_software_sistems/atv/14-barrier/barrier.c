#include <stdio.h>

void *thread_barreira(void *arg) {
    // NÃO altere este print, ele simula uma tarefa
    printf("Antes da barreira\n");

    // TODO: implemente a barreira aqui

    // NÃO altere este print, ele simula uma tarefa
    printf("Depois da barreira\n");

    return NULL;
}

int main() {
    // TODO: crie 4 threads rodando o código acima
    
    // TODO: espere por elas

    return 0;
}
