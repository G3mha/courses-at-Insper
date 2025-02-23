// Configurações do mutirão. Não mexer.
#include "../macros_correcoes.h"
#define LABNUM "lab2-"
#define SOLUTIONFILE "tarefa7.c"

#include <stdio.h>

// TODO implemente sua função aqui
void arvore(int n) {
    double i = 1.0;
    double k = 1.0;
    while (i <= n)
    {
        if (k == 1.0) {
            while (k <= n/2.0)
            {
                printf(" ");
                k += 1;
            }
        }
        int j = 1;
        while (j <= i/2.0)
        {
            printf("/");
            j += 1;
        }
        printf("|");
        j = 1;
        while (j <= i/2.0)
        {
            printf("\\");
            j += 1;
        }
        printf("\n");
        i += 1;
    }
}

// TODO implemente aqui um programa que chama
// a função que você faz, passando como
// parâmetro um inteiro que foi dado pelo usuário
int main() {
    int n;
    printf("Digite o número: ");
    scanf("%d", &n);
    arvore(n);
    return 0;
}
