#include <limits.h>
#include <stdint.h>

int is_pow2_branchy(uint64_t x) {
    if (x == 0) return 0;
    while (x > 1) {
        if (x & 1) return 0;
        x >>= 1;
    }
    return 1;
}

int32_t sat_add32_branchy(int32_t a, int32_t b) {
    long long s = (long long)a + b;
    if (s > INT32_MAX) return INT32_MAX;
    if (s < INT32_MIN) return INT32_MIN;
    return (int32_t)s;
}