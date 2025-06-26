# Arithmetic exercise

- Introduction to the Vitis HLS workflow
- Porting code that uses `float` to `ap_fixed`

## Exercise 1.
-  run the scripts, and browse the reports and Vitis HLS GUI
    - What is the latency and resource usage of this design?

| DSP | LUT | FF  | BRAM | Latency | Worst Error | Mean Error  |
|-----|-----|-----|------|---------|-------------|-------------|
| ?   | ?   | ?   | ?    | ?       | ?           | ?           |

### First time setup:

```
source /opt/tools/Xilinx/Vivado/2023.2/settings64.sh
git clone https://github.com/FPGA-course-2025/day4.git
cd day4/arithmetic
vitis_hls -f csim.tcl
vitis_hls -f csynth.tcl
vitis_hls -f cosim.tcl
vitis_hls &
```


- clone the repository
- change directory to the arithmetic exercise
- run the Vitis HLS C Simulation, C Synthesis, Co Simulation steps
- in the Vitis HLS GUI (after `vitis_hls &` command):
  - Click "No" to try new IDE
  - Click -> Open Project
  - Click -> `ArithmeticProj/` directory
  - Click -> "Open"

## Exercise 2. 
- `vec_sum.h` has a line:
    - `typedef float data_t;` that defines that we used floating point for all of the variables
- adapt the function to use fixed point instead
    - Find the necessary number of integer bits to avoid overflow
    - Find the smallest total bit width that keeps the worst error smaller than 0.1
    - Track your experiments in a results table, and plot LUT usage vs error
    - Note running the script overwrites the existing project, so log your results after each run

|         | DSP | LUT | FF  | BRAM | Latency | Worst Error | Mean Error  |
|---------|-----|-----|-----|------|---------|-------------|-------------|
| Width 0 | ?   | ?   | ?   | ?    | ?       | ?           | ?           |
| Width 1 | ?   | ?   | ?   | ?    | ?       | ?           | ?           |
| Width 2 | ?   | ?   | ?   | ?    | ?       | ?           | ?           |
| Width 3 | ?   | ?   | ?   | ?    | ?       | ?           | ?           |

