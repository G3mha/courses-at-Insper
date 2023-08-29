#include <stdio.h>
#include <string.h>

void show_bytes(unsigned char *ptr, int n) {
    for (int i = 0; i < n; i++) {
        printf("'%c' (%02x) | ", ptr[i], ptr[i]);  
    }
    printf("\n");
}

int main() {
    char *string = "Oi C :-)";

    printf("String:\n%s\n\n", string);
    
    printf("Valor guardado no array:\n");
    show_bytes((unsigned char *) string, strlen(string) + 1);
    
    return 0;
}
