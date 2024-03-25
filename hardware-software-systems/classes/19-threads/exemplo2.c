#include <stdio.h>
#include <pthread.h>

void *thread1(void *arg) {
    printf("Thread 1!\n");
    return NULL;
}

void *thread2(void *arg) {
    printf("Thread 2!\n");
    return NULL;
}

void *thread3(void *arg) {
    printf("Thread 3!\n");
    return NULL;
}

void *thread4(void *arg) {
    printf("Thread 4!\n");
    return NULL;
}

int main() {
    pthread_t tid1;
    pthread_t tid2;
    pthread_t tid3;
    pthread_t tid4;
    int error1 = pthread_create(&tid1, NULL, thread1, NULL);
    int error2 = pthread_create(&tid2, NULL, thread2, NULL);
    int error3 = pthread_create(&tid3, NULL, thread3, NULL);
    int error4 = pthread_create(&tid4, NULL, thread4, NULL);
    pthread_join(tid1, NULL); // espera tid acabar.
    pthread_join(tid2, NULL); // espera tid acabar.
    pthread_join(tid3, NULL); // espera tid acabar.
    pthread_join(tid4, NULL); // espera tid acabar.
    return 0;
}
