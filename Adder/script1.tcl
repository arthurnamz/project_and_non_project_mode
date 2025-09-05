
# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xc7s50csga324-1"
set top_module "counter"
set sim_top_module "tb"


# Create project
create_project $proj_name $proj_dir -part $part_name -force

# add design sources
add_files -fileset sources_1 ./counter.v

# set top-level file
set_property top $top_module [get_filesets sources_1]

# Add simulation files 
add_files -fileset sim_1 ./tb.v

# set testbench top-level
set_property top $sim_top_module [get_filesets sim_1]

# Add constraint files
add_files -fileset constrs_1 ./floorplanning.xdc
add_files -fileset constrs_1 ./pin.xdc

# Run simulation
launch_simulation -simset sim_1 -mode behavioral

# Run synthesis
launch_runs synth_1 -jobs 2
wait_on_run synth_1

# Run Implementation 
launch_runs impl_1 to_step write_bitstream
wait_on_run impl_1

# programming the board
open_hw_manager
connect_hw_server -allow_non_jtag
