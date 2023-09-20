#include <stdio.h>

void acumulate(int v[], int n) {
    if (n == 0) {
        return;
    }
    acumulate(v, n - 1);
    v[n] += v[n - 1];
}

int main() {
    int v[5] = {1, 2, 3, 4, 5};
    acumulate(v, 5);
    for (int i = 0; i < 5; i++) {
        printf("%d ", v[i]);
    }
    printf(" \n");

    return 0;
}