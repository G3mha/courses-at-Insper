#include <stdio.h>

int sum_from(int v[], int l, int r) {
    if (l > r) {
        return 0;
    }
    if (l == r) {
        return v[r];
    }
    int m = (l + r) / 2;
    return sum_from(v, l, m) + sum_from(v, m + 1, r);
}

int sum(int v[], int n) {
    return sum_from(v, 0, n-1);
}

int main() {
    int v[5] = {1, 2, 3, 4, 5};
    printf("%d \n", sum(v, 5));

    return 0;
}