#ifndef EXAMPLE_MET_H__
#define EXAMPLE_MET_H__

#include "ap_fixed.h"

typedef ap_fixed<12,10> T_pt;
typedef ap_fixed<12,4> T_phi;
typedef ap_fixed<16,12> T_pxy;
typedef ap_fixed<13,11> T_MET;

/*typedef float T_pt;
typedef float T_phi;
typedef float T_pxy;
typedef float T_MET;*/

T_MET compute_met(unsigned short n_particles, T_pt* pt, T_phi* phi);

#endif
