#include <stdio.h>

short global_array[] = {-1, 10, 3, 4, 5};

char *global_str = "Schiaparelli crater!";

long global_var = 2L << (33 + 3);

long global_unused_array[100];

int main (int argc, char *argv[]) {
    printf("Hello!\n");
    return 0;
}
