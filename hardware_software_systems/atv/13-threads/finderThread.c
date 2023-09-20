// gcc finderThread.c -o finderThread -pthread

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

typedef struct {
    int step;
    int wanted;
    int retval;
    int *vector;
} package_t;

typedef struct {
    int index;
    int thread_id;
} answer_t;

void *find(void *arg) {
    // encontre índice da primeira ocorrência de um determinado número `x` em um vetor `A` de inteiros com `n` posições.
    sleep(5);
    package_t *ifswv = (package_t *) arg;
    int step = ifswv->step;
    int wanted = ifswv->wanted;
    int *vector = ifswv->vector;
    for (int i = 0; i < step; i++) {
        if (vector[i] == wanted) {
            ifswv->retval = i;
        }
    }
}

int main(void) {
    // recebe x, n, A, k
    int x; 
    printf("Digite o elemento a ser buscado: ");
    scanf("%d", &x);
    int n;
    printf("Digite o tamanho do array: ");
    scanf("%d", &n);
    printf("Digite os %d elementos do array: \n", n);
    int *A = malloc(n * sizeof(int)); // vetor de inteiros
    for (int i = 0; i < n; i++) {
        scanf("%d", &A[i]);
    }
    int k;
    printf("Digite a quantidade de threads: ");
    scanf("%d", &k);
    // cria vetor tids que aloca com malloc para k phtread_t
    pthread_t *tids = malloc(k * sizeof(pthread_t));
    printf("Criou vetor de threads com %d posicoes\n", k);
    package_t *ifswv = malloc(k * sizeof(package_t));
    int initial_interval = 0;
    int step = n/k;
    int final_interval = step-1;
    for (int i = 0; i < k; i++) {
        ifswv[i].step = step;
        ifswv[i].wanted = x;
        ifswv[i].retval = -1;
        ifswv[i].vector = malloc(step * sizeof(int));
        int e = 0;
        for (int j = initial_interval; j <= final_interval; j++) {
            ifswv[i].vector[e] = A[j];
            e++;
        }
        printf("Criou thread %d, r=[%d,%d]\n", i, initial_interval, final_interval);
        pthread_create(&tids[i], NULL, find, &ifswv[i]);
        initial_interval += step;
        final_interval += step;
    }
    // printf("Funcao main() espera as threads finalizarem...\n");
    answer_t *it = malloc(sizeof(answer_t));
    char found = 0;
    for (int j = 0; j < k; j++) {
        pthread_join(tids[j], NULL); // espera tid acabar.
        printf("Thread %d finalizou retornando %d\n", j, ifswv[j].retval);
        if (ifswv[j].retval != -1 && !found) {
            it->index = ifswv[j].retval;
            it->thread_id = j;
            found = 1;
        }
        free(ifswv[j].vector);
    }
    printf("Elemento %d encontrado pela thread %d no indice %d!\n", x, it->thread_id, it->index);
    free(it);
    free(tids);
    free(ifswv);
    free(A);
    // valgrind --leak-check=yes ./finderThread < ./in/in50.txt
    return 0;
}
