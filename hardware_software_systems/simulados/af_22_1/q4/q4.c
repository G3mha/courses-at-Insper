#include "macros_correcoes.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int *extrai_primeiro_int(char *msg) {
    int tamanho;
    for (tamanho = 0; msg[tamanho] != '\0'; tamanho++);

    for (int i = 0; i < tamanho; i++) {
        if (isdigit(msg[i]) > 0) {
            int *buffer = malloc(sizeof(int));
            int maxSize = 5;
            char *num = malloc(sizeof(char) * maxSize);
            int counter = 0;

            for (int j = i; j < tamanho; j++) {
                if (msg[j] == ' ' || msg[j] == ',' || msg[j] == '.') {
                    break;
                }

                if (counter == 5) {
                    maxSize += 5;
                    num = realloc(num, sizeof(char) * maxSize);
                }

                num[counter] = msg[j];
                counter++;
            }

            buffer[0] = atoi(num);
            return buffer;
        }
    }

    return NULL; // Você pode alterar o retorno, se necessário!
}


// Não edite a main, caso contrário zerará a questão
int main() {

    {
        char *msg = "comprei 10 crypto siscoin hoje";
        int correto = 10;
        int *primeiro_int_user = NULL;
        primeiro_int_user = extrai_primeiro_int(msg);

        printf("Testes: %s\n", msg);
        assertExpr(primeiro_int_user != NULL, "ERRO: Primeiro é NULL!");
        if (primeiro_int_user != NULL) {
            assertExpr(*primeiro_int_user == correto, "Primeiro Int tem valor incorreto!");
            free(primeiro_int_user);
        } else {
            assertExpr(primeiro_int_user != NULL, "ERRO: Devido a ser nulo um dos testes não pode ser executado!");
        }
    }

    {
        char *msg = "(-_-)___/ R$ 71,99";
        int correto = 71;
        int *primeiro_int_user = NULL;
        primeiro_int_user = extrai_primeiro_int(msg);

        printf("Testes: %s\n", msg);
        assertExpr(primeiro_int_user != NULL, "ERRO: Primeiro é NULL!");
        if (primeiro_int_user != NULL) {
            assertExpr(*primeiro_int_user == correto, "Primeiro Int tem valor incorreto!");
            free(primeiro_int_user);
        } else {
            assertExpr(primeiro_int_user != NULL, "ERRO: Devido a ser nulo um dos testes não pode ser executado!");
        }
    }

    {
        char *msg = "Nascido em 1987, junqueira sempre soube o que fazer da vida!";
        int correto = 1987;
        int *primeiro_int_user = NULL;
        primeiro_int_user = extrai_primeiro_int(msg);

        printf("Testes: %s\n", msg);
        assertExpr(primeiro_int_user != NULL, "ERRO: Primeiro é NULL!");
        if (primeiro_int_user != NULL) {
            assertExpr(*primeiro_int_user == correto, "Primeiro Int tem valor incorreto!");
            free(primeiro_int_user);
        } else {
            assertExpr(primeiro_int_user != NULL, "ERRO: Devido a ser nulo um dos testes não pode ser executado!");
        }
    }

    {
        char *msg = "Na verdade foi em 1983, não 1987!";
        int correto = 1983;
        int *primeiro_int_user = NULL;
        primeiro_int_user = extrai_primeiro_int(msg);

        printf("Testes: %s\n", msg);
        assertExpr(primeiro_int_user != NULL, "ERRO: Primeiro é NULL!");
        if (primeiro_int_user != NULL) {
            assertExpr(*primeiro_int_user == correto, "Primeiro Int tem valor incorreto!");
            free(primeiro_int_user);
        } else {
            assertExpr(primeiro_int_user != NULL, "ERRO: Devido a ser nulo um dos testes não pode ser executado!");
        }
    }

    {
        char *msg = "É, o final do semestre está chegando!";
        int *primeiro_int_user = extrai_primeiro_int(msg);

        printf("Testes: %s\n", msg);
        assertExpr(primeiro_int_user == NULL, "ERRO: nenhum número deveria ter sido retornado!");
    }

    printSummary;
}
