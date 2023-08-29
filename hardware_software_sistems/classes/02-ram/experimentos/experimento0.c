#include <stdio.h>

typedef union {
    char letra;
    int num;
} char_ou_int;

int main() {
    char_ou_int variavel;
    variavel.num = 65;
    
    
    printf("%d\n", variavel.num);
    printf("%c\n", variavel.letra);

    /* 
     * %x mostra um número em hexa
     */
    printf("%#08x\n", variavel.num);
    printf("%#08x\n", variavel.letra);
    
    return 0;
}
