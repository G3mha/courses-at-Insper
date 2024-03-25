#include <stdlib.h>

#include "vec_int.h"

typedef struct _vec_int {
    int *data;
    int size;
    int capacity;
} vec_int;


vec_int *vec_int_create() {
    return NULL;
}

void vec_int_destroy(vec_int **_v) {

}

int vec_int_size(vec_int *v) {
    return 0;
}

int vec_int_at(vec_int *v, int pos, int *val) {
    return 0;
}

int vec_int_insert(vec_int *v, int pos, int val) {
    return 0;
}

int vec_int_remove(vec_int *v, int pos) {
    return 0;    
}
