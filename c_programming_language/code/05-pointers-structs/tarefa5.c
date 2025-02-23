#include <stdio.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} ponto;

int euclidiana(ponto p1, ponto p2) {
    int distancia = sqrt(((p2.x - p1.x) * (p2.x - p1.x)) + ((p2.y - p1.y) * (p2.y - p1.y)));
    return distancia;
}

int main() {
    ponto p1, p2;
    int distancia;
    // usa scanf para ler quatro inteiros dados pelo usuário
    printf("Digite quatro inteiros: ");
    scanf("%d %d %d %d", &p1.x, &p1.y, &p2.x, &p2.y);
    // chama a função euclidiana com os quatro inteiros lidos
    distancia = euclidiana(p1, p2);
    // imprime o resultado da função euclidiana
    printf("distancia euclidiana: %d\n" , distancia);
    return 0;
}