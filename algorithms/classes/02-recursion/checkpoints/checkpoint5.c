#include <stdio.h>

int simetrico(int v[], int l, int r) {
    if (l >= r) {
        return 1;
    }
    return v[l] == v[r] && simetrico(v, l + 1, r - 1);
}

int main() {
    return 0;
}