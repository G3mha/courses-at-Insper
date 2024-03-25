#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

void *tarefa_print_i(void *arg) {
    int *i = (int *) arg;
    printf("Thread %d!\n", *i);
    return NULL;
}

int main() {
    // cria vetor vi que aloca com malloc 4 inteiros
    int *vi = malloc(4 * sizeof(int));
    // cria vetor tids que aloca com malloc 4 phtread_t
    pthread_t *tids = malloc(4 * sizeof(pthread_t));
    for (int i = 0; i < 4; i++) {
        vi[i] = i;
        pthread_create(&tids[i], NULL, tarefa_print_i, &vi[i]);
        pthread_join(tids[i], NULL); // espera tid acabar.
    }
    return 0;
}
