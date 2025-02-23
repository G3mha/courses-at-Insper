// Configurações do mutirão. Não mexer.
#include "../macros_correcoes.h"
#define LABNUM "lab2-"
#define SOLUTIONFILE "tarefa6.c"

#include <stdio.h>

// TODO implemente sua função aqui
void fizzbuzz(int n) {
    int i = 1;
    while (i <= n)
    {
        if (i % 3 != 0 && i % 5 != 0) {
            printf("%d: %s", i, "nenhum\n");
        }
        if (i % 3 == 0 && i % 5 != 0) {
            printf("%d: %s", i, "apenas por três\n");
        }
        if (i % 3 != 0 && i % 5 == 0) {
            printf("%d: %s", i, "apenas por cinco\n");
        }
        if (i % 3 == 0 && i % 5 == 0) {
            printf("%d: %s", i, "por três e por cinco\n");
        }
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
    fizzbuzz(n);
    return 0;
}
