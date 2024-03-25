// implemente aqui sua solução!
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    volatile char flag_sucesso = 0;
    int x, n, k;
    printf("Qual o elemento a ser buscado? ");
    scanf("%d", &x);
    printf("Qual o tamanho do array? ");
    scanf("%d", &n);
    int A[n];
    printf("Digite os %d elementos do array:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &A[i]);
    }
    printf("Qual a quantidade de processos? ");
    scanf("%d", &k);
    int r = n / k;
    int status;
    pid_t pid;
    for (int i = 0; i < k; i++) {
        pid = fork();
        if (pid > 0) {
            printf("Criou filho %d com PID=%d, r=[%d,%d)\n", i, pid, i * r, i * r + r);
        }
        if (pid == 0) {
            int start = i * r;
            int end = start + r;
            int index = -1;
            for (int j = start; j < end; j++) {
                if (A[j] == x) {
                    index = j;
                    break;
                }
            }
            exit(index);
        }
    }
    printf("Processo pai esperando os filhos finalizarem...\n");
    for (int i = 0; i < k; i++) {
        pid = wait(&status);
        if (WIFEXITED(status)) {
            int index = WEXITSTATUS(status);
            if (index != -1 && !flag_sucesso) {
                printf("Elemento %d encontrado pelo processo %d no indice %d!\n", x, i, index);
                flag_sucesso = 1;
            }
            printf("Processo %d com PID=%d finalizou retornando %d\n", i, pid, index);
        }
    }
    if (!flag_sucesso) {
        printf("Elemento nao encontrado!\n");
    }
    return 0;
}
