#include <stdio.h>

int times_called = 0;

int funcao2(int a) {
    times_called++;
    return times_called + a;
}

int funcao1(int a, int *b) {
    int b1 = *b;
    int c = a;
    int c2 = b1 + c;
    return c2;
}

int main(int argc, char *argv[]) {
    int b = 20;
    printf("Resultado: %d\n", funcao1(10, &b));
    printf("funcao2: %d\n", funcao2(10));
    printf("funcao2: %d\n", funcao2(10));
    int x = 7;
    printf("Teste: %d\n", funcao1(5, &x));
    printf("times_called: %d\n", times_called);
}
