#include <stdio.h>

// return b^e
int my_pow(int b, int e) {
    // e is always positive
    if (e == 0) {
        return 1;
    }
    return my_pow(b, e - 1) * b; // returns b^(e-1)
}

int main(void) {
    int b, e;
    printf("Enter base: ");
    scanf("%d", &b);
    printf("Enter exponent: ");
    scanf("%d", &e);
    int result = my_pow(b, e);
    printf("%d^%d = %d\n", b, e, result); 
    return 0;
}