#include "example_met.h"
#include "hls_math.h"

T_MET compute_met(unsigned short n_particles, T_pt pt[N], T_phi phi[N]){
#pragma HLS array_partition variable=pt factor=8
#pragma HLS array_partition variable=phi factor=8
#pragma HLS pipeline II=16
    T_pxy px, py = 0;
    ParticleLoop:
    for(unsigned short n = 0; n < N; n++){
#pragma HLS unroll factor=8
        T_pt ptn = pt[n];
        T_phi phin = phi[n];
        if(n < n_particles){
          px += ptn * hls::cos(phin);
          py += ptn * hls::sin(phin);
        }
    }
    T_MET met = hls::sqrt(px * px + py * py);
    return met;
}
