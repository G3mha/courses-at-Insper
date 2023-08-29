// Leia o PDF ou MD antes de iniciar este exercício!

#include <signal.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int fd;

// Crie AQUI os handlers necessários
void sigint_handler() {
    time_t now = time(NULL);
    struct tm *tm_struct = localtime(&now);

    int hour = tm_struct->tm_hour;
    int min = tm_struct->tm_min;
    int sec = tm_struct->tm_sec;

    char buffer[42];
    sprintf(buffer, "%d:%d:%d ./q3 finished with signal sigint\n", hour, min, sec);
    write(fd, buffer, 42);

    kill(getpid(), SIGKILL);
}

void sigterm_handler() {
    time_t now = time(NULL);
    struct tm *tm_struct = localtime(&now);

    int hour = tm_struct->tm_hour;
    int min = tm_struct->tm_min;
    int sec = tm_struct->tm_sec;

    char buffer[42];
    sprintf(buffer, "%d:%d:%d ./q3 finished with signal sigterm\n", hour, min, sec);
    write(fd, buffer, 42);

    kill(getpid(), SIGKILL);
}

int main(char argc, char *argv[]) {

    // Exiba o PID deste processo
    printf("PID do Processo - %d\n", getpid());

    char *arquivo;
    arquivo = argv[1];

    fd = open(arquivo, O_WRONLY | O_CREAT | O_APPEND, 0700);

    time_t now = time(NULL);
    struct tm *tm_struct = localtime(&now);

    int hour = tm_struct->tm_hour;
    int min = tm_struct->tm_min;
    int sec = tm_struct->tm_sec;

    char buffer[22];
    sprintf(buffer, "%d:%d:%d ./q3 started\n", hour, min, sec);
    write(fd, buffer, 22);

    // Registre AQUI seu handler para os sinais!
    struct sigaction s_int;
    s_int.sa_handler = sigint_handler;
    sigemptyset(&s_int.sa_mask);
    sigaddset(&s_int.sa_mask, SIGTERM);
    s_int.sa_flags = 0;
    sigaction(SIGINT, &s_int, NULL);

    /* TODO: registar SIGTERM aqui. */
    struct sigaction s_term;
    s_term.sa_handler = sigterm_handler;
    sigemptyset(&s_term.sa_mask);
    sigaddset(&s_term.sa_mask, SIGINT);
    s_term.sa_flags = 0;
    sigaction(SIGTERM, &s_term, NULL);


    while(1); // roda infinitamente

    return 0;
}