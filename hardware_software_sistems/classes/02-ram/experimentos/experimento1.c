#include <stdio.h>

void show_bytes(unsigned char *ptr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%02x ", ptr[i]);  
    }
    printf("\n");
}

int main() {
   
    /* 
     * a macro sizeof retorna o tamanho, em bytes, de um tipo
     *
     * sizeof(int) == 4
     *
     * mandamos mostrar os bytes **guardados na memória**.
     */

    int num1 = 42;
    printf("Valor guardado na memória para num1 = %d:\n", num1);
    show_bytes((unsigned char *) &num1, sizeof(num1));
    
    
    int num2 = 0xFEDCBA98;
    printf("\nValor guardado na memória para num2 = %x:\n", num2);
    show_bytes((unsigned char *) &num2, sizeof(num2));

    int num3 = -42;
    printf("\nValor guardado na memória para num3 = %d:\n", num3);
    show_bytes((unsigned char *) &num3, sizeof(num3));
    
    return 0;
}
