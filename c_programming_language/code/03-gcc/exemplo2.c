#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    int n1, n2;
    
    scanf("%d %d", &n1, &n2);
    
    if (n2 == 0) {
        printf("Divisão por zero! \n");
    } else {
        if (n1 % n2 == 0) {
            printf(" %d é múltiplo de %d \n", n1, n2);
        } else {
            printf(" %d não é múltiplo de %d \n", n1, n2);
        }
    }

    return 0;
}
