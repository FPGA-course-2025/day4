# Project
# create a project
open_project -reset "ArithmeticProj"
# add the testbench file
add_files -tb testbench.cpp -cflags "-std=c++17"
# add the design file
add_files vec_sum.cpp

# Solution
open_solution -reset "solution"
# set the FPGA to the one on Arty 100T
set_part {XC7A100TCSG324-1}
# create a 100 MHz clock ie 10 ns
create_clock -period 10.0 -name default

# Simulation
csim_design -ldflags "-fuse-ld=gold"

exit

