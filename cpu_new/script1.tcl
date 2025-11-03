#!/usr/bin/tclsh

# CPU Assignment - Vivado TCL Script
# Author: Updated for CPU project
# Description: Simulation and synthesis script for FSM-based CPU design

proc findWordInFile {word file} {
    set fh [open $file r]
    set foundlines {}
    while {[gets $fh line] >= 0} {
        if {[string match "*$word*" $line]} {
            lappend foundlines $line
        }
    }
    close $fh
    
    if { [llength $foundlines] > 0 } {
       foreach line $foundlines {
           puts "\n$line\n"
       }
    } else {
       puts "Search pattern not found"    
    }
}

# Global variables
set proj_name "cpu_project"
set proj_dir "./cpu_project"
set part_name "xc7s50csga324-1"
set top_module "cpu_top"
set sim_top_module "cpu_tb"

puts "\n=========================================="
puts "CPU Design - TCL Script"
puts "=========================================="
puts "Project: $proj_name"
puts "Top Module: $top_module"
puts "Testbench: $sim_top_module"
puts "==========================================\n"

#////////////////
# 1. Simulation
#////////////////

puts "\n=== PHASE 1: SIMULATION ===\n"

# Create simulation directory
file mkdir sim
cd sim

# Create CPU simulation directory
file mkdir cpu_sim
cd cpu_sim

puts "\n1- Simulating CPU Design ---------------------------------\n" 

# Compile design modules
puts "Compiling design files..."
exec xvlog ../../instruction_memory.v
exec xvlog ../../data_memory.v
exec xvlog ../../cpu.v
exec xvlog ../../cpu_top.v

# Compile testbench
puts "Compiling testbench..."
exec xvlog ../../cpu_tb.v

# Elaborate design
puts "Elaborating design..."
exec xelab $sim_top_module -debug all -timescale 1ns/1ps

# Run simulation
puts "Running simulation..."
exec xsim $sim_top_module --tclbatch ../../saif.tcl

puts "\nSimulation completed!"

# Check if all tests passed
puts "\n--- Checking Test Results ---"
findWordInFile "PASS" "xsim.log"

# Return to project root
cd ../..

puts "\n=== SIMULATION PHASE COMPLETE ===\n"

#////////////////
# 2. Synthesis, Place, and Route
#////////////////

puts "\n=== PHASE 2: SYNTHESIS & IMPLEMENTATION ===\n"

catch {close_design}

# Create synthesis directory
file mkdir synth_place_route
cd synth_place_route

puts "Loading design sources..."
# Load design source files
read_verilog ../instruction_memory.v
read_verilog ../data_memory.v
read_verilog ../cpu.v
read_verilog ../cpu_top.v

# Load constraints files (if you have timing constraints)
read_xdc ../timingConstraints.xdc

puts "Running synthesis..."
# Synthesis 
synth_design -top $top_module -part $part_name
write_checkpoint -force post_synthesis.dcp
puts " Synthesis checkpoint written: post_synthesis.dcp"

puts "\nOptimizing netlist..."
# Optimizing the netlist
opt_design
write_checkpoint -force post_opt.dcp
puts " Optimization checkpoint written: post_opt.dcp"

puts "\nRunning placement..."
# Placement
place_design
write_checkpoint -force post_place.dcp
puts " Placement checkpoint written: post_place.dcp"

puts "\nPost-placement optimization..."
# Post placement optimization
phys_opt_design
write_checkpoint -force post_place_phys_opt.dcp
puts " Post-placement optimization checkpoint written: post_place_phys_opt.dcp"

puts "\nRunning routing..."
# Routing
route_design
write_checkpoint -force post_route.dcp
puts " Routing checkpoint written: post_route.dcp"

puts "\nPost-routing optimization..."
# Post routing optimization
phys_opt_design
write_checkpoint -force post_route_phys_opt.dcp
puts " Post-routing optimization checkpoint written: post_route_phys_opt.dcp"

puts "\nGenerating reports..."
# Reports
report_utilization -file utilization.rpt 
report_timing_summary -file timing_summary.rpt
report_power -file power.rpt
report_drc -file drc.rpt
report_route_status -file route_status.rpt
report_methodology -file methodology.rpt

puts "\n--- Generated Reports ---"
puts "  • utilization.rpt      - Resource utilization"
puts "  • timing_summary.rpt   - Timing analysis"
puts "  • power.rpt            - Power consumption"
puts "  • drc.rpt              - Design rule checks"
puts "  • route_status.rpt     - Routing status"
puts "  • methodology.rpt      - Design methodology checks"

puts "\nSynthesis and Implementation complete!"
puts "All checkpoints and reports saved in synth_place_route/ directory"

# Return to project root
cd ..

puts "\n=== SYNTHESIS PHASE COMPLETE ===\n"

#////////////////
# 3. Programming the Hardware (Optional)
#////////////////

# Uncomment if you want to program an FPGA board
# open_hw_manager
# connect_hw_server -allow_non_jtag
# open_hw_target
# set_property PROGRAM.FILE {synth_place_route/post_route.dcp} [get_hw_devices]
# program_hw_devices [get_hw_devices]

puts "\n=========================================="
puts "Script Execution Complete!"
puts "==========================================\n"
