#include "vec_sum.h"

void vec_sum(const data_t in1[8], const data_t in2[8], data_t out[8]) {
    VectorLoop: // label loops to make them easy to find in HLS reports
    for (int i = 0; i < 8; ++i) {
        out[i] = in1[i] + in2[i];
    }
}

