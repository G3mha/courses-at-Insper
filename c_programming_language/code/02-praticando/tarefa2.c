// Configurações do mutirão. Não mexer.
#include "../macros_correcoes.h"
#define LABNUM "lab2-"
#define SOLUTIONFILE "tarefa2.c"

#include <stdio.h>

int main() {
    double s = 0;
    int i = 1;

    while (i <= 10) {
        s += i;
        i++;
    }
    s = s / 2.0;
    printf("Soma: %f", s);
    return 0;
}
