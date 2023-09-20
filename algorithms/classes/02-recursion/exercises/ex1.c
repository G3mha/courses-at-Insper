#include <stdio.h>

double my_pow(double b, int e) {
    if (e == 0) {
        return 1.0;
    }
    return b * my_pow(b, e - 1);
}

int main() {
    double b;
    int e;
    printf("Type the base: ");
    scanf("%lf", &b);
    printf("Type the exp: ");
    scanf("%d", &e);

    printf("%lf ^ %d = %lf \n", b, e, my_pow(b, e));

    return 0;
}