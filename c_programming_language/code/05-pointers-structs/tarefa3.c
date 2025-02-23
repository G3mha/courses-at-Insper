// Configurações do mutirão. Não mexer.
#include "../macros_correcoes.h"
#define LABNUM "lab5-"
#define SOLUTIONFILE "tarefa3.c"


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
    
    // assertEquals é uma função do mutirão que confere
    // se o segundo argumento é igual ao terceiro.
    // Neste caso, se ele checa a chamada de manhattan retorna o valor esperado. 
    ponto p1, p2;

    p1 = (ponto) {.x=0, .y=1};
    p2 = (ponto) {.x=2, .y=3};
    assertEquals("manhattan({0, 1}, {2, 3}) != 4", manhattan(p1, p2), 4);

    p1 = (ponto) {.x=0, .y=1};
    p2 = (ponto) {.x=0, .y=2};
    assertEquals("manhattan({0, 1}, {0, 2}) != 1", manhattan(p1, p2), 1);

    p1 = (ponto) {.x=1, .y=0};
    p2 = (ponto) {.x=2, .y=0};
    assertEquals("manhattan({1, 0}, {2, 0}) != 1", manhattan(p1, p2), 1);

    p1 = (ponto) {.x=1, .y=2};
    p2 = (ponto) {.x=1, .y=2};
    assertEquals("manhattan({1, 2}, {1, 2}) != 0", manhattan(p1, p2), 0);
    
    p1 = (ponto) {.x=0, .y=-1};
    p2 = (ponto) {.x=0, .y=2};
    assertEquals("manhattan({0, -1}, {0, 2}) != 3", manhattan(p1, p2), 3);

    p1 = (ponto) {.x=-1, .y=0};
    p2 = (ponto) {.x=2, .y=0};
    assertEquals("manhattan({-1, 0}, {2, 0}) != 3", manhattan(p1, p2), 3);
    
    printSummary

    return 0;
}
