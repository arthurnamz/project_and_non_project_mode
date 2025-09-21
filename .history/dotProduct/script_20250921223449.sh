
# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xc7s50csga324-1"
set top_module1 "mem1_tb"
set top_module2 "mem2_tb"
set top_module3 "mem3_tb"

# Create project
create_project $proj_name $proj_dir -part $part_name -force

# Add design sources
add_files -fileset sources_1 ./mem1.v
add_files -fileset sources_1 ./mem2.v
add_files -fileset sources_1 ./mem3.v

# Set top-level file
set_property top $top_module1 [get_filesets sources_1]
set_property top $top_module2 [get_filesets sources_1]
set_property top $top_module3 [get_filesets sources_1]

# Add simulation files
add_files -fileset sim_1 ./mem1_tb.v
add_files -fileset sim_1 ./mem2_tb.v
add_files -fileset sim_1 ./mem3_tb.v

# Set testbench top-level
set_property top $top_module1 [get_filesets sim_1]
set_property top $top_module2 [get_filesets sim_1]
set_property top $top_module3 [get_filesets sim_1]

# Add constraint files
add_files -fileset constrs_1 ./timingconstraints.xdc

# Run simulation from one module to another
launch_simulation -simset sim_1 -mode behavioral

# Run synthesis
launch_runs synth_1 -jobs 2
wait_on_run synth_1

# Run Implementation
launch_runs impl_1 to_step route_design
wait_on_run impl_1

# Programming the board
# open_hw_manager
# connect_hw_server -allow_non_jtag
