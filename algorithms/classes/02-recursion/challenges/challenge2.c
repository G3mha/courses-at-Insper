#include <stdio.h>

void hanoi(int n, char orig, char aux, char dest) {
    if (n == 1) {
        printf("Move disk %d from %c to %c \n", n, orig, dest);
        return;
    }
    hanoi(n - 1, orig, dest, aux);
    printf("Move disk %d from %c to %c \n", n, orig, dest);
    hanoi(n - 1, aux, orig, dest);
}

int main() {
    int n;
    printf("Type the number of disks: ");
    scanf("%d", &n);

    hanoi(n, 'A', 'B', 'C');

    return 0;
}