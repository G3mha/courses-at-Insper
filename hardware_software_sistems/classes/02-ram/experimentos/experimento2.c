#include <stdio.h>

void show_bytes(unsigned char *ptr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%02x ", ptr[i]);  
    }
    printf("\n");
}

int main() {
    short arr[] = {0x1122, 0x3344, 0x5566};
    
    printf("Valor guardado o array:\n");
    show_bytes((unsigned char *) &arr, sizeof(short) * 3);
    
    return 0;
}