#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

struct sort_args {
    int idxThread; 
    int nThreads; 
    int lineFiles; 
    FILE *fp; 
    pthread_mutex_t *mutex_file;
};
struct merge_args {
    int idxThread; 
    int nThreads; 
    FILE *fp1,*fp2; 
};

void * sort(void *args);

void * merge(void *args);