#include <stdio.h>

typedef struct {
    int x;
    int y;
} ponto;

int manhattan(ponto p1, ponto p2) {
    int dx = p1.x - p2.x;
    int dy = p1.y - p2.y;
    if (dx < 0) {
        dx = -dx;
    }
    if (dy < 0) {
        dy = -dy;
    }
    return dx + dy;
}

int main() {
    ponto p1, p2;
    int distancia;
    // usa scanf para ler quatro inteiros dados pelo usuário
    printf("Digite quatro inteiros: ");
    scanf("%d %d %d %d", &p1.x, &p1.y, &p2.x, &p2.y);
    // chama a função manhattan com os quatro inteiros lidos
    distancia = manhattan(p1, p2);
    // imprime o resultado da função manhattan
    printf("distancia manhattan: %d\n" , distancia);
    return 0;
}