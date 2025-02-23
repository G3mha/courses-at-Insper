#include <stdio.h>

void count_matrix_5x4(long matrix[5][4]) {
    int iterator_column = 0;
    int last_column_sum = 0;
    int biggest_column_index = 0;
    while (iterator_column < 4) {
        int counter = 0;
        int iterator_line = 0;
        while (iterator_line < 5) {
            counter += matrix[iterator_line][iterator_column];
            iterator_line++;
        }
        printf("Soma da coluna %d: %d\n", iterator_column, counter);
        if (counter > last_column_sum) {
            last_column_sum = counter;
            biggest_column_index = iterator_column;
        }
        iterator_column++;
    }
    printf("Coluna com maior soma: %d\n", biggest_column_index);
}

int main() {
    long mat[5][4] = {
        {1, 2, 3, 4},
        {1, 2, 3, 4},
        {1, 2, 3, 4},
        {1, 2, 3, 4},
        {1, 2, 3, 4}
    };
    count_matrix_5x4(mat);
    return 0;
}
