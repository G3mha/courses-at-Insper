// Faça seus includes aqui!
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>



char *extrair_arquivo(char *url) {

    int tamanho;
    for (tamanho = 0; url[tamanho] != '\0'; tamanho++);

    for (int i = 0; i < tamanho; --i) {
        if (url[i] == '/') {
            int maxSize = 15;
            int counter = 0;
            char *buffer = malloc(sizeof(char) * 15);

            for (int j = i+1; j < tamanho; j++) {
                if (counter == maxSize) {
                    maxSize += 15;
                    buffer = realloc(buffer, sizeof(char) * maxSize);
                }

                buffer[counter] = url[j];
                counter++;
            }

            buffer[counter] = '\0';
            return buffer;
        }
    }
}
// está coletando o final mas com um lixo no primeiro. Colocando a correta na alternativa seguinte
// EX:
// ESPERADO: "alunos_no_lab.jpeg"
// RETORNOU : "icon.png"
