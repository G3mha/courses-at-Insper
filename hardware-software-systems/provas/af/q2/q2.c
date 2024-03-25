// Leia o PDF ou MD antes de iniciar este exercício!

// inclua libs aqui!
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>


int main(int argc, char *argv[]){
    char *filename = argv[1];
    double price = atof(argv[2]);
    pid_t filho;
    int i = 0;
    char *agr_size;


    while (1) {
        filho = fork();
        printf("i: %d", i);
        if (filho == 0) {
            agr_size = 
            char *args[] = {"./ocr", filename, i};
            execvp(args[0], args);
        } else {
            int status;
            sleep(2);
            if (waitpid(filho, &status, WNOHANG) > 0) {
                int retorno = (char) WEXITSTATUS(status);
                printf("OCR TERMINOU NORMALMENTE!\n");
                return retorno;
            } else {
                printf("PANE NO SISTEMA VERIFY...\n");
                kill(filho, SIGKILL);
            }
        }
        i++;
    }

    return 0;
}