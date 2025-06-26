#include "example_met.h"
#include "hls_math.h"

T_MET compute_met(unsigned short n_particles, T_pt* pt, T_phi* phi){
    T_pxy px, py = 0;
    ParticleLoop:
    for(unsigned short n = 0; n < n_particles; n++){
        T_pt ptn = pt[n];
        T_phi phin = phi[n];
        px += ptn * hls::cos(phin);
        py += ptn * hls::sin(phin);
    }
    T_MET met = hls::sqrt(px * px + py * py);
    return met;
}
