#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main (int argc, char *argv[]) { 
    if (argc != 3) {
        printf("Uso: ./tirar_comentarios <arquivo_entrada> <arquivo_saida>\n");
        return 1;
    }
    // abre os arquivos de entrada/saida
    int fd_entrada = open(argv[1], O_RDONLY);
    int fd_saida = open(argv[2], O_WRONLY | O_CREAT, 0700);

    // verifica se os arquivos foram abertos corretamente
    if (fd_entrada == -1 || fd_saida == -1) {
        printf("Erro ao abrir os arquivos\n");
        return 1;
    }

    char c;
    char c2;
    int bytes;
    estado1:
        bytes = read(fd_entrada, &c, 1);
        if (bytes == 0) goto fim;
        if (c == '/') goto estado2;
        write(fd_saida, &c, 1);
        goto estado1;
    estado2:
        bytes = read(fd_entrada, &c, 1);
        if (bytes == 0) goto fim;
        if (c == '/') goto estado3;
        if (c == '*') goto estado4;
        c2 = '/';
        write(fd_saida, &c2, 1);
        write(fd_saida, &c, 1);
        goto estado1;
    estado3:
        bytes = read(fd_entrada, &c, 1);
        if (bytes == 0) goto fim;
        if (c == '\n') {
            write(fd_saida, &c, 1);
            goto estado1;
        }
        goto estado3;
    estado4:
        bytes = read(fd_entrada, &c, 1);
        if (bytes == 0) goto fim;
        if (c == '*') goto estado5;
        goto estado4;
    estado5:
        bytes = read(fd_entrada, &c, 1);
        if (bytes == 0) goto fim;
        if (c == '/') goto estado1;
        goto estado4;
    fim:
        close(fd_entrada);
        close(fd_saida);
    return 0;
}
