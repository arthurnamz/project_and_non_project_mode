
# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xc7s50csga324-1"
set top_module "counter"
set sim_top_module "tb"
set bitfile "counter.bit"

#////////////////
# 1- Simulation
#////////////////
file mkdir sim
cd sim
file mkdir work
cd work

# compile design abd testbench
exec xvlog ./../../counter.v 
exec xvlog ./../../tb.v 

#Elaborate
exec xelab $sim_top_module -debug all

# simulation
exec xsim $sim_top_module -R
cd ../..

#////////////////
# 2. Synthesis, place, and route
#////////////////

catch {close_design}

file mkdir synth_place_route
cd synth_place_route

# load design source
read_verilog ./../counter.v

# load constraints files
read_xdc ./../floorplanning.xdc
read_xdc ./../pin.xdc

# synthesis 
synth_design -top $top_module -part $part_name

# optimising the netlist
opt_design

# placement
place_design

# post placement optimization
phys_opt_design

# Routing
route_design

# Post routing optimization
phys_opt_design

# Reports
report_utilization -file utilization.rpt 
report_timing_summary -file timing_summary.rpt

# Generate the Bitstream
write_bitstream -file $bitfile

#////////////////
# 3. Programming the hw
#////////////////


# programming the board
open_hw_manager
connect_hw_server -allow_non_jtag
