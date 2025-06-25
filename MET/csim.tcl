# Project
open_project -reset "METProj"
add_files -tb pt.csv
add_files -tb phi.csv
add_files -tb testbench.cpp
# replace with your implementation
add_files dummy_met.cpp

# Solution
open_solution -reset "solution"
set_part {XC7A100TCSG324-1}
create_clock -period 10.0 -name default

# Simulation
csim_design

exit

