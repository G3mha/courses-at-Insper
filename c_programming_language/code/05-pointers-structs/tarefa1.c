#include <stdio.h>

void sum_sub(int a, int b, int *sum, int *sub) {
    *sum = a + b;
    *sub = a - b;
}

int main() {
    int n1, n2;

    printf("Digite dois números inteiros: ");
    scanf("%d", &n1);
    scanf("%d", &n2);

    sum_sub(n1, n2, &n1, &n2);

    printf("Soma: %d \t Subtração: %d \n", n1, n2);
    
    return 0;
}