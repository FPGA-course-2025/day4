#ifndef DUMMY_MET_H__
#define DUMMY_MET_H__

// type definitions for the main data types
// these don't have to be aliased but it's convenient
typedef float T_pt;
typedef float T_phi;
typedef float T_met;

T_met compute_met(unsigned short n_particles, T_pt* pt, T_phi* phi);

#endif
