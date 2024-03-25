#ifndef __VECINT_H__
#define __VECINT_H__

struct _vec_int;

typedef struct _vec_int vec_int;

vec_int *vec_int_create();
void vec_int_destroy(vec_int **v); 

int vec_int_size(vec_int *v);

/* As seguinte operações devolvem 
 * 1 se pos é uma posição válida e a operação foi bem sucedida
 * 0 caso contrário
 * 
 * No caso de at, o valor é retornado na variável apontada por vi.
 */
int vec_int_at(vec_int *v, int pos, int *vi);
int vec_int_insert(vec_int *v, int pos, int val);
int vec_int_remove(vec_int *v, int pos);

#endif