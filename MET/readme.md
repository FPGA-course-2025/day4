# MET exercise

- You need to compute the MET (vector sum) from all of the particles in each event
    - An event refers to all of the particles produced from one collision at the LHC
- A particle is represented as an object with three properties:
    - Transverse momentum — pT
    - Angle at vertex — ɸ
    - ‘Angle’ in longitudinal plane — η 
- MET is the magnitude of the vector sum of particles
- You are given:
    - a file with particles from 1000 simulated events of a process with real MET (Higgs produced by Vector Boson Fusion, decaying invisibly)
    - a reference implementation in Python

## Maths functions

- There is a library of math functions for HLS available as `#include “hls_math.h”`
    - This includes implementations of the trigonometric functions you’ll need e.g.  `hls::cos`, `hls::sin`, `hls::sqrt`
- Use them for your first attempt
- Make a plot to validate the HLS trigonometry on your fixed point against the C++ math trigonometry on floating point
- In some cases we can be more efficient by preparing a Look Up Table that we can read with an address
    - Fill the table with the ‘ideal’ floating point function during compile / synthesis time
    - Read the table using the runtime data in the FPGA
    - If you have time, see if you can reduce the latency and resource usage of the trigonometry functions by replacing the HLS functions with a precomputed table
    - Validate your tables with a plot to compare

## Evaluating your results

- In this exercise we will look at three metrics:
1. Accuracy of the MET calculation against the Python reference
    - Aiming for 10 GeV absolute and 2% relative maximum difference
    - Use plots and other tools in the provided Python notebook to judge
    - After running the C Simulation with `vitis_hls -f csim.tcl`, the new `met_hls.csv` is written to `METProj/solution/csim/build/met_hls.csv`
2. Resources of MET calculation HLS function
    - Use synthesis reports
3. Latency of MET calculation HLS function
    - Use synthesis reports and cosimulation

## Improving your results

- Accuracy of the MET calculation
    - Explore the dataset and reference calculation in Python to choose appropriate precision
    - Remember that every operation and variable can have a different precision!
    - The HLS testbench from C Simulation writes a CSV file that the Python script can read to compare
    - Use the plots and “`np.testing.assert_allclose`” cell to evaluate and improve
    - When you change something, save the results to a different filename so that you can compare and improve
- Resources and Latency
    - Use the Schedule viewer and analysis view in Vitis HLS GUI
    - Giving labels to for-loops in HLS C++ can help identify them in reports
    - Defining functions for computation blocks can help identify them in reports
