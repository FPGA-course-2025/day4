open_project AccumulatorProj
set_top accumulator

add_files accumulator.cpp

open_solution "solution1"
set_part {xc7a100tcsg324-1}
create_clock -period 10 -name default

csynth_design
exit

