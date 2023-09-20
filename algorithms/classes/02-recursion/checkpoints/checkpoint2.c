#include <stdio.h>

// return sum of n elements on a v array
int my_sum(int v[], int n) {
    // n represents the size of v
    if (n == 0) {
        return 0;
    }
    return my_sum(v, n-1) + v[n-1];
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
    
    int result = my_sum(v, n);
    printf("Sum of %d elements is %d\n", n, result);

    return 0;
}