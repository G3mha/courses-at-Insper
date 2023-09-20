#include <stdio.h>

int amount_of_digits(int n) {
    if (n < 10) {
        return 1;
    }
    return 1 + amount_of_digits(n / 10);
}

int main() {
    int n;
    printf("Type a number: ");
    scanf("%d", &n);

    printf("The number %d has %d digits \n", n, amount_of_digits(n));

    return 0;
}