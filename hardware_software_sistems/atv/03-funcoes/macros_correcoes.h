#define _GNU_SOURCE

#include <stdio.h>

#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int tests_passed = 0;
int tests_failed = 0;

int __attribute__ ((noinline)) faz_nada() {
    asm("");
    return -10;
}

#define assertEquals(str, a, b) {if ((a) == (faz_nada(),(b))) { tests_passed++; } else { printf("FAIL: %s\n", str); tests_failed++; }  }

#define printSummary { printf("%d de %d testes passaram\n", tests_passed, (tests_passed + tests_failed)); }

#define rodaComEntradaEmOutroProcesso(entrada, expr, res, tipo_retorno) \
{ \
pid_t p = fork();                                \
if (p == 0) {                                    \
    int old = dup(STDIN_FILENO);                     \
    int fd = open("temp", O_RDWR | O_CREAT, 0700);   \
    write(fd, entrada, sizeof(entrada));             \
    lseek(fd, 0, SEEK_SET);                          \
    dup2(fd, STDIN_FILENO);                          \
                                                     \
    res = expr ; \
                                                     \
    dup2(old, STDIN_FILENO);                         \
    close(fd);                                       \
    unlink("temp");                                  \
    return 0;                                        \
} else {                                         \
    wait(p);                                     \
} \
}

#define asssertEqualsEntrada(entrada, a, b, tipo_expr, tam_tipo)      \
{                                                \
tipo_expr *ptr = mmap(NULL, tam_tipo * 2, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0 ); \
rodaComEntradaEmOutroProcesso(entrada, a, ptr[0], tipo_expr); \
rodaComEntradaEmOutroProcesso(entrada, b, ptr[1], tipo_expr); \
assertEquals("Testando com entrada ->" entrada, ptr[0], ptr[1]); \
\
}
