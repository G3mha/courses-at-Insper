#include <stdio.h>

void perimetro_area(int a, int l, int *pe, int *ar) {
    *pe = 2*(a + l);
    *ar = a*l;
}

int main() {
    int altura, largura;

    printf("Digite dois números inteiros: ");
    scanf("%d", &altura);
    scanf("%d", &largura);

    perimetro_area(altura, largura, &altura, &largura);

    printf("Perimetro: %d \t Area: %d \n", altura, largura);
    
    return 0;
}