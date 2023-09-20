#include <stdio.h>

// return an array with all the elements plus 1
void increase(int vector[], int l, int r) {
    // l is the first index of the v-interval (inclusive)
    // r is the last index of the v-interval (inclusive)
    if (l > r) {
        return;
    }
    increase(vector, l, r - 1);
    vector[r]++;
}

int main(void) {
    int n;
    printf("Enter n: ");
    scanf("%d", &n);
    int v[n];
    
    for (int i = 0; i < n; i++) {
        printf("Enter v[%d]: ", i);
        scanf("%d", &v[i]);
    }
    
    increase(v, 0, n-1);
    
    for (int i = 0; i < n; i++) {
        printf("v[%d] = %d ", i, v[i]);
    }
    printf("\n");

    return 0;

}