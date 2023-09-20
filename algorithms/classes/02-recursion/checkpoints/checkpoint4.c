#include <stdio.h>

int intlog2(int n) {
    // devolve e tal que n = 2^e
    if (n == 1) {
        return 0;
    }
    return intlog2(n / 2) + 1;
}

int main() {
    int n;
    printf("Digite um numero: ");
    scanf("%d", &n);

    printf("O logaritmo na base 2 de %d é %d\n", n, intlog2(n));

    return 0;
}


