#include "mintest/macros.h"
#include "vec_int.h"
#include <stdlib.h>

// Precisamos de acesso direto aos campos para fazer os testes
// Isto normalmente não vai no código.
typedef struct _vec_int {
    int *data;
    int size;
    int capacity;
} vec_int;

int test_creation_destroy() {
    vec_int *vec = vec_int_create();
    test_assert(vec != NULL, "create retornou NULL!");

    vec_int_destroy(&vec);
    test_assert(vec == NULL, "vec não foi setado como null apos destroy!");

    return 1;
}

int test_size_capacity() {
    vec_int *vec = vec_int_create();
    test_assert(vec != NULL, "create retornou NULL!");

    test_assert(vec->capacity == 2, "Capacidade começa diferente de 2!");

    test_assert(vec_int_size(vec) == 0, "Tamanho inicial diferente de 0!");
    
    int i;
    test_assert(vec_int_at(vec, 0, &i) == 0, "Retornou 1 em posição inválida!");

    vec_int_destroy(&vec);
    return 1;
}

int test_insert() {
    vec_int *vec = vec_int_create();
    test_assert(vec != NULL, "create retornou NULL!");

    test_assert(vec_int_insert(vec, -1, 5) == 0, "Retornou 1 em posição inválida!");
    test_assert(vec_int_insert(vec, 2, 5) == 0, "Retornou 1 em posição inválida!");

    vec_int_insert(vec, 0, 5);
    vec_int_insert(vec, 0, 4);
    vec_int_insert(vec, 0, 3);
    test_assert(vec_int_size(vec) == 3, "Tamanho diferente de 3!");
    test_assert(vec->capacity == 4, "Capacidade deve dobrar quando vetor ficar cheio!");

    int val;
    test_assert(vec_int_at(vec, 0, &val) != 0, "Retornou 0 em elemento existente!");
    test_assert(val == 3, "Elemento adicionado diferente de 3!");
    test_assert(vec_int_at(vec, 1, &val) != 0, "Retornou 0 em elemento existente!");
    test_assert(val == 4, "Elemento adicionado diferente de 4!");
    test_assert(vec_int_at(vec, 2, &val) != 0, "Retornou 0 em elemento existente!");
    test_assert(val == 5, "Elemento adicionado diferente de 5!");

    test_assert(vec_int_insert(vec, 3, 6) != 0, "Retornou 0 para inserção no fim!");
    test_assert(vec_int_at(vec, 3, &val) != 0, "Retornou 0 em elemento existente!");
    test_assert(val == 6, "Elemento adicionado diferente de 6!");

    test_assert(vec_int_insert(vec, 0, 2) != 0, "Retornou 0 para inserção no começo!");
    test_assert(vec_int_at(vec, 0, &val) != 0, "Retornou 0 em elemento existente!");
    test_assert(val == 2, "Elemento adicionado diferente de 2!");
    
    for (int i = 0; i < vec_int_size(vec); i++) {
        test_assert(vec_int_at(vec, i, &val) != 0, "Retornou 0 em elemento existente!");
        test_assert(val == i+2, "Problema com elemento adicionado!");
    }

    vec_int_destroy(&vec);
    return 1;
}

int test_remove() {
    vec_int *vec = vec_int_create();
    test_assert(vec != NULL, "create retornou NULL!");

    vec_int_insert(vec, 0, 1000);
    vec_int_insert(vec, 1, 10);
    vec_int_insert(vec, 2, 20);
    vec_int_insert(vec, 3, 5000);
    vec_int_insert(vec, 4, 30);
    vec_int_insert(vec, 5, 40);
    vec_int_insert(vec, 6, 50);

    test_assert(vec_int_remove(vec, 0) == 1, "Retornou 0 em remoção válida.");
    test_assert(vec_int_remove(vec, 2) == 1, "Retornou 0 em remoção válida.");

    int val;
    for (int i = 1; i <= 5; i++) {
        test_assert(vec_int_at(vec, (i-1), &val) != 0, "Retornou 0 em elemento existente!");
        test_assert(val == i*10, "Elemento não confere!");
    }

    test_assert(vec_int_remove(vec, 5) == 0, "Retornou 1 em remoção inválida.");

    vec_int_destroy(&vec);
    return 1;
}


int test_shrink_grow() {
    vec_int *vec = vec_int_create();
    test_assert(vec != NULL, "create retornou NULL!");

    for (int i = 0; i < 20; i++) {
        vec_int_insert(vec, 0, 1000);
    }

    test_assert(vec->capacity == 32, "Capacidade diferente de 32!");

    for (int i = 0; i < 15; i++) {
        vec_int_remove(vec, 0);
    }

    test_assert(vec->capacity == 16, "Capacidade diferente de 16!");

    vec_int_destroy(&vec);
    return 1;
}

test_list = {TEST(test_creation_destroy), TEST(test_size_capacity), TEST(test_insert), TEST(test_remove), TEST(test_shrink_grow)};
#include "mintest/runner.h"
