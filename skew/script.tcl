
# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xc7s50csga324-1"
set top_module "skew"

#////////////////
# 1- Simulation
#////////////////
# file mkdir sim
# cd sim
# file mkdir work
# cd work

# compile design abd testbench
exec xvlog ./skew.v
# exec xvlog ./../../tb.v 

#Elaborate
exec xelab $top_module -debug all

# simulation
# exec xsim $top_module -R
# cd ../..

#////////////////
# 2. Synthesis, place, and route
#////////////////

catch {close_design}

file mkdir synth_place_route
cd synth_place_route

# load design source
read_verilog ./../skew.v

# load constraints files
read_xdc ./../timing_constraints.xdc

# synthesis 
synth_design -top $top_module -part $part_name
write_checkpoint post_synthesis.dcp -force

# optimising the netlist
opt_design

# placement
place_design
write_checkpoint post_place.dcp -force

# post placement optimization
phys_opt_design

# Routing
route_design
write_checkpoint post_route.dcp -force

# Post routing optimization
phys_opt_design
write_checkpoint post_phys_opt.dcp -force

# Reports
report_utilization -file utilization.rpt 
report_timing_summary -file timing_summary.rpt
report_power -file power.rpt
report_power_opt -file power_opt.rpt
