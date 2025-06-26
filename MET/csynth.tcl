# Project
open_project -reset "METProjFloat"
add_files example_met.cpp
set_top compute_met

# Solution
open_solution -reset "solution"
set_part {XC7A100TCSG324-1}
create_clock -period 10.0 -name default

# Synthesis
csynth_design

exit

