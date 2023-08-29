#define _GNU_SOURCE

#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define assertEquals(str, a, b) {if ((a) == (b)) printf("OK  : %s\n", str); else printf("FAIL: %s\n", str); }

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