#include "sort-merge.h"
// ... aqui começa sua solucao.
// para compilar use
// gcc -g -Og -Wall sort.o solucao.c -o sort -pthread

void * sort(void * args) {
    struct sort_args *arg = (struct sort_args *) args;
    int idxThread = arg->idxThread;
    int lineFiles = arg->lineFiles / arg->nThreads;
    // lock no file
    pthread_mutex_lock(arg->mutex_file);
    FILE *fp = arg->fp;
    rewind(fp);
    char *str = malloc(30 * sizeof(char));
    // limpa lixo do file
    for (int i = 0; i < idxThread; i++) {
        for (int j = 0; j < lineFiles; j++) {
            fscanf(fp, "%s", str);
        }
    }
    char** vet = malloc(lineFiles * sizeof(char*));
    for (int i = 0; i < lineFiles; i++) {
        vet[i] = (char*) malloc(30 * sizeof(char));
        fscanf(fp, "%s", vet[i]);
    }

    // sort algorithm
    for (int i = 0; i < lineFiles; i++) {
        for (int j = i + 1; j < lineFiles; j++) {
            if (strcmp(vet[i], vet[j]) > 0) {
                char aux[30];
                strcpy(aux, vet[i]);
                strcpy(vet[i], vet[j]);
                strcpy(vet[j], aux);
            }
        }
    }

    // escreve no txt com o nome <idxThread>.txt
    char *name = malloc(20 * sizeof(char));
    sprintf(name, "%d.txt", idxThread);
    FILE *fpOut = fopen(name, "w");
    for (int i = 0; i < lineFiles; i++) {
        fprintf(fpOut, "%s\n", vet[i]);
        free(vet[i]);
    }
    // unlock no file
    pthread_mutex_unlock(arg->mutex_file);
    free(str);
    free(name);
    free(vet);
    return fpOut;
}