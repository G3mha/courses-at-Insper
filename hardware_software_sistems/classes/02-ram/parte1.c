#include <stdio.h>

struct player {
    char icon_id;
    long level;
    char name[20];
    long score;
};

struct player one   = {
    2,
    20,
    "nome nome nome",
    1012312312
};


int main(int argc, char *argv[]) {
    printf("Sizeof(struct player) = %lu\n", sizeof(struct player));
    printf("--------\nname:\t%s\nlevel:\t%ld\nicon:\t%d\nscore:\t%ld\n", one.name,
            one.level, one.icon_id, one.score);
    printf("---\nEndereços:\nname:\t%p\nlevel:\t%p\nicon:\t%p\nscore:\t%p\n", &one.name,
            &one.level, &one.icon_id, &one.score);
    printf("----\n&one:\t%p\n", &one);
    return 0;
}

