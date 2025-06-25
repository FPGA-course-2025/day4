#include <iostream>
#include <cmath>
#include <cstdlib>
#include "ap_fixed.h"
#include "vec_sum.h"

const int N = 8;

// print either float or ap_fixed
template<typename T>
std::string value_to_string(const T& val) {
    if constexpr (std::is_same_v<T, float> || std::is_same_v<T, double>) {
        // For floats: just return decimal string
        std::ostringstream oss;
        oss << std::fixed << std::setprecision(6) << val;
        return oss.str();
    } else {
        // For ap_fixed or other arbitrary precision: return binary string
        return val.to_string(2, true); // binary, signed
    }
}

int main() {
    float in1_float[N], in2_float[N], out_float[N];
    // data_t is a typedef alias defined in vec_sum.h, try changing it!
    data_t in1[N], in2[N], out[N];

    // Generate random values in [-16, 16)
    std::srand(42); // fixed seed for reproducibility
    for (int i = 0; i < N; ++i) {
        float r1 = ((std::rand() % 3200) / 100.0f) - 16.0f;
        float r2 = ((std::rand() % 3200) / 100.0f) - 16.0f;

        in1_float[i] = r1;
        in2_float[i] = r2;
        out_float[i] = r1 + r2;

        in1[i] = r1;
        in2[i] = r2;
    }

    // Run the design
    vec_sum(in1, in2, out);

    std::cout << std::fixed << std::setprecision(4);
    std::cout << "Index |   In1  +  In2   | Float Result | Fixed Result | Error   | Binary Out\n";
    std::cout << "----------------------------------------------------------------------\n";
    for (int i = 0; i < N; ++i) {
        float fixed_out = static_cast<float>(out[i]);
        float err = std::abs(fixed_out - out_float[i]);

        std::cout << "  " << i
                  << "   | " << std::setw(8) << in1_float[i]
                  << " + " << std::setw(8) << in2_float[i]
                  << " | " << std::setw(8) << out_float[i]
                  << " | " << std::setw(8) << fixed_out
                  << " | " << std::setw(7) << err
                  << " | " << value_to_string(out[i])  // base 2, signed
                  << "\n";
    }
    return 0;
}

