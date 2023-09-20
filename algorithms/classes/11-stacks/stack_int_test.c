#include "mintest/macros.h"
#include "stack_int.h"

#define assert_empty(s) { test_assert(stack_int_empty(s), "not empty"); }
#define assert_not_empty(s) { test_assert(!stack_int_empty(s), "empty"); }
#define assert_full(s) { test_assert(stack_int_full(s), "not full"); }
#define assert_not_full(s) { test_assert(!stack_int_full(s), "full"); }
#define assert_pop(s, expected) { int actual = stack_int_pop(s); char str[50]; sprintf(str, "popped %d but expected %d", actual, expected); test_assert(actual == expected, str); }

int capacity1_push_pop_push_pop(void) {
    stack_int *s = stack_int_new(1);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 20);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity2_push_pop_push_push_pop_pop(void) {
    stack_int *s = stack_int_new(2);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity2_push_push_pop_push_pop_pop(void) {
    stack_int *s = stack_int_new(2);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity2_push_push_pop_pop_push_pop(void) {
    stack_int *s = stack_int_new(2);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 30);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity3_push_pop_push_push_push_pop_pop_pop(void) {
    stack_int *s = stack_int_new(3);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 40);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity3_push_push_pop_push_push_pop_pop_pop(void) {
    stack_int *s = stack_int_new(3);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 40);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity3_push_push_push_pop_push_pop_pop_pop(void) {
    stack_int *s = stack_int_new(3);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 40);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity3_push_push_push_pop_pop_push_pop_pop(void) {
    stack_int *s = stack_int_new(3);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

int capacity3_push_push_push_pop_pop_pop_push_pop(void) {
    stack_int *s = stack_int_new(3);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 10);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    stack_int_push(s, 30);
    assert_not_empty(s);
    assert_full(s);

    assert_pop(s, 30);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 20);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 10);
    assert_empty(s);
    assert_not_full(s);

    stack_int_push(s, 40);
    assert_not_empty(s);
    assert_not_full(s);

    assert_pop(s, 40);
    assert_empty(s);
    assert_not_full(s);

    stack_int_delete(&s);
    return 1;
}

test_list = {
    TEST(capacity1_push_pop_push_pop),
    TEST(capacity2_push_pop_push_push_pop_pop),
    TEST(capacity2_push_push_pop_push_pop_pop),
    TEST(capacity2_push_push_pop_pop_push_pop),
    TEST(capacity3_push_pop_push_push_push_pop_pop_pop),
    TEST(capacity3_push_push_pop_push_push_pop_pop_pop),
    TEST(capacity3_push_push_push_pop_push_pop_pop_pop),
    TEST(capacity3_push_push_push_pop_pop_push_pop_pop),
    TEST(capacity3_push_push_push_pop_pop_pop_push_pop),
};

#include "mintest/runner.h"
