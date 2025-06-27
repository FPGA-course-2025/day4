#include "example_met.h"
#include "hls_math.h"

T_MET compute_met(unsigned short n_particles, T_pt* pt, T_phi* phi){
#pragma HLS pipeline
    T_pxy px, py = 0;
    ParticleLoop:
    for(unsigned short n = 0; n < n_particles; n++){
#pragma HLS loop_tripcount min=17 max=117 avg=54
#pragma HLS unroll
        T_pt ptn = pt[n];
        T_phi phin = phi[n];
        px += ptn * hls::cos(phin);
        py += ptn * hls::sin(phin);
    }
    T_MET met = hls::sqrt(px * px + py * py);
    return met;
}
