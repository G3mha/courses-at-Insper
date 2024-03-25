#include <stdio.h>

int main(int argc, char *argv[]) {
    int a = 10;
    int *ap = &a;

    printf("Endereço de a\t: %p\nPróximo int\t: %p\n", ap, ap+1);
    
    
    long l = 10;
    long *lp = &l;
    
    printf("Endereço de l\t: %p\nPróximo long\t: %p\n", lp, lp+1);
    
    return 0;
}
