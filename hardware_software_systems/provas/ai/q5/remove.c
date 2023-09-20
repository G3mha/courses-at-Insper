#include <stdio.h>
#include <stdlib.h>

// Seu código neste arquivo!
char *remove_comentarios(char *funcao) {
    int number_of_lines = 1; // a ultima linha nao possui \n
    // conta a quantidade de linhas
    int funcao_size = 0;
    while (funcao[funcao_size] != '\0') {
        if (funcao[funcao_size] == '\n') number_of_lines++;
        funcao_size++;
    }
    // printf("Number of lines: %d\n", number_of_lines);
    // aloca o tamanho correto da input string
    char *retval = malloc(funcao_size * sizeof(char));
    int retval_index = 0;
    
    // retira os comentarios da input string
    int funcao_index = 0;
    int ignore_until_end;
    for (int i = 0; i < number_of_lines; i++) {
        ignore_until_end = 0;
        while ((funcao[funcao_index] != '\n') && (funcao[funcao_index] != '\0')) {
            if (funcao[funcao_index] == '/' && funcao[funcao_index++] == '/') ignore_until_end = 1;
            if (!ignore_until_end) {
                retval[retval_index] = funcao[funcao_index];
                retval_index++;
            }
            funcao_index++;
        }
        if (i != number_of_lines-1) {
            funcao_index++;
            retval[retval_index] = '\n';
            retval_index++;
        }
    }
    retval[retval_index--] = '\0';
    return retval;
}
