#include <stdio.h>
#include <time.h>

int main() {
    time_t rawtime = time(NULL);
    struct tm *ptime = localtime(&rawtime);

    printf("Agora são %02d:%02d:%02d\n", ptime->tm_hour, ptime->tm_min, ptime->tm_sec);
    
}