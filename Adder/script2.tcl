
# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xczu7ev-ffvc1156-2-e"
set top_module "top"
set sim_top_module "tb"
set bitfile "adder.bit"

#////////////////
# 1- Simulation
#////////////////
file mkdir sim
cd sim
file mkdir work
cd work

# compile design abd testbench
exec xvlog ./../../full_carry_adder.v 
exec xvlog ./../../seven_segment_display.v
exec xvlog ./../../top.v 
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
read_verilog ./../full_carry_adder.v
read_verilog ./../seven_segment_display.v
read_verilog ./../top.v

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

open_hw_target
set_property PROGRAM.FILE {/home/arthur/personal_projects/FPGA_masterclass/project_and_non_project_mode/Adder/synth_place_route/adder.bit} [get_hw_devices xczu7_0]
set_property PROBES.FILE {/home/arthur/personal_projects/FPGA_masterclass/project_and_non_project_mode/Adder/synth_place_route/design_1_wrapper.ltx} [get_hw_devices xczu7_0]
set_property FULL_PROBES.FILE {/home/arthur/personal_projects/FPGA_masterclass/adder_here/adder_here.runs/impl_1/design_1_wrapper.ltx} [get_hw_devices xczu7_0]
current_hw_device [get_hw_devices xczu7_0]
refresh_hw_device [lindex [get_hw_devices xczu7_0] 0]
current_hw_device [get_hw_devices arm_dap_1]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices arm_dap_1] 0]
current_hw_device [get_hw_devices xczu7_0]

