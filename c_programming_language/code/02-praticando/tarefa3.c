// Configurações do mutirão. Não mexer.
#include "../macros_correcoes.h"
#define LABNUM "lab2-"
#define SOLUTIONFILE "tarefa3.c"

#include <stdio.h>
#include <math.h>    /* <---- precisa incluir!!! */

#define PI 3.141592

void print_trigo(int a) {
    double b = a * PI / 180.0;
    printf("seno: %lf, cosseno: %lf\n", sin(b), cos(b));
}

int main() {
    int angle;

    printf("Digite um ângulo em graus: ");
    scanf("%d", &angle);

    print_trigo(angle);

    return 0;
}
