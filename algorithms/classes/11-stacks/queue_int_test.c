#include "mintest/macros.h"
#include "queue_int.h"

#define assert_empty(q) { test_assert(queue_int_empty(q), "not empty"); }
#define assert_not_empty(q) { test_assert(!queue_int_empty(q), "empty"); }
#define assert_full(q) { test_assert(queue_int_full(q), "not full"); }
#define assert_not_full(q) { test_assert(!queue_int_full(q), "full"); }
#define assert_get(q, expected) { int actual = queue_int_get(q); char str[50]; sprintf(str, "got %d but expected %d", actual, expected); test_assert(actual == expected, str); }

int capacity1_put_get_put_get(void) {
    queue_int *q = queue_int_new(1);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity2_put_get_put_put_get_get(void) {
    queue_int *q = queue_int_new(2);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 10);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity2_put_put_get_put_get_get(void) {
    queue_int *q = queue_int_new(2);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity2_put_put_get_get_put_get(void) {
    queue_int *q = queue_int_new(2);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 20);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity3_put_get_put_put_put_get_get_get(void) {
    queue_int *q = queue_int_new(3);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 10);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 40);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 40);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity3_put_put_get_put_put_get_get_get(void) {
    queue_int *q = queue_int_new(3);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 40);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 40);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity3_put_put_put_get_put_get_get_get(void) {
    queue_int *q = queue_int_new(3);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 40);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 40);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity3_put_put_put_get_get_put_get_get(void) {
    queue_int *q = queue_int_new(3);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 40);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 40);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

int capacity3_put_put_put_get_get_get_put_get(void) {
    queue_int *q = queue_int_new(3);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    queue_int_put(q, 30);
    assert_not_empty(q);
    assert_full(q);

    assert_get(q, 10);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 20);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 30);
    assert_empty(q);
    assert_not_full(q);

    queue_int_put(q, 40);
    assert_not_empty(q);
    assert_not_full(q);

    assert_get(q, 40);
    assert_empty(q);
    assert_not_full(q);

    queue_int_delete(&q);
    return 1;
}

test_list = {
    TEST(capacity1_put_get_put_get),
    TEST(capacity2_put_get_put_put_get_get),
    TEST(capacity2_put_put_get_put_get_get),
    TEST(capacity2_put_put_get_get_put_get),
    TEST(capacity3_put_get_put_put_put_get_get_get),
    TEST(capacity3_put_put_get_put_put_get_get_get),
    TEST(capacity3_put_put_put_get_put_get_get_get),
    TEST(capacity3_put_put_put_get_get_put_get_get),
    TEST(capacity3_put_put_put_get_get_get_put_get),
};

#include "mintest/runner.h"
