#include <stdio.h>
#include <pthread.h>


// Funções rodadas em thread sempre tem essa assinatura
void *minha_thread(void *arg) {
    printf("Hello thread!\n");
    return NULL;
}

int main() {
    pthread_t tid;
    int error = pthread_create(&tid, NULL, minha_thread, NULL);
    // pthread_join(tid, NULL); // espera tid acabar.
    return 0;
}
