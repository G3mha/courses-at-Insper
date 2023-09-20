// Leia o PDF ou MD antes de iniciar este exercício!

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>

// Variável Global para o handler saber até qual linha processou
int linha_proc = 0;

// Função que gera um numero aleatorio uniformemente entre 0.0 e 1.0
// Você não deve alterar esta função
double random_zero_one()
{
    return (double)random() / (double)RAND_MAX;
}

void brilha_brilha_estrelinha()
{
    if (random_zero_one() < 0.5)
    {
        sleep(1);
    }
}

int processa_linhas(int qt_linhas)
{
    for (linha_proc = 0; linha_proc < qt_linhas; linha_proc++)
    {
        brilha_brilha_estrelinha();
        printf("PROCESSOU A LINHA %d\n", linha_proc);
        fflush(stdout);
        if
    }
}

void exporter() 
{
    int fd = open("q3_status.txt", O_TRUNC); // Abre o arquivo
}

// Crie AQUI a função que exporta o valor de `linha_proc` para um arquivo chamado q3_status.txt
// O arquivo deve ter apenas uma linha contendo, LINHA_PROC seguido de um sinal de igual e
// seguido da última linha processada, seguido de \n:
// LINHA_PROC=15
//
// Esta função deve ser chamada pelo handler quando este for acionado

// Crie AQUI a função que será o handler do sinal

int main(int argc, char *argv[])
{

    if (argc < 2)
    {
        printf("USAGE:\n./q4 n_lines\n");
        return EXIT_FAILURE;
    }

    printf("Meu pid: %d\n", getpid());

    // Registre AQUI seu handler para os sinais SIGINT e SIGTERM!

    processa_linhas(atol(argv[1]));

    return 0;
}