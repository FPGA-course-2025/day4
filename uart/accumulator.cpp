#include <ap_int.h>
#include "accumulator.h"

void accumulator(ap_uint<8> in, ap_uint<8>& out) {
    // use a static variable to accumulate the value over successive function calls
    static ap_uint<8> sum = 0;
    sum += in;
    out = sum;
}

