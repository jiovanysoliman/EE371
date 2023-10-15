# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
#vlog "./counter.sv"
#vlog "./modified_top_level.sv"
vlog "./seg7.sv"
#vlog "./counter.sv"
#vlog "./clock_divider.sv"
vlog "./task1.sv"
vlog "./ram32x3.v"
vlog "./task2.sv"
vlog "./DE1_SoC.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
# vsim -voptargs="+acc" -t 1ps -lib work modified_top_level_tb
#vsim -voptargs="+acc" -t 1ps -lib work task1_tb -Lf altera_mf_ver
# vsim -voptargs="+acc" -t 1ps -lib work task2_tb
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_tb
#vsim -voptargs="+acc" -t 1ps -lib work counter_tb

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
