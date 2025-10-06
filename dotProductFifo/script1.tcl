
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
        puts "simulation failed"    
     }
}

# Global variable
set proj_name "project1"
set proj_dir "./project1"
set part_name "xc7s50csga324-1"
set top_module "top_level_wrapper"
set sim_top_module "top_level_wrapper_tb"


#////////////////
# 1- Simulation
#////////////////
file mkdir sim
cd sim
file mkdir top_module
cd top_module
puts "\n1- Simulating $sim_top_module ---------------------------------\n" 
# compile design abd testbench
exec xvlog ./../../mem1.v 
exec xvlog ./../../mem2.v 
exec xvlog ./../../mem_reader.v 
exec xvlog ./../../dotProduct.v 
exec xvlog ./../../mem_writer.v 
exec xvlog ./../../mem3.v 
exec xvlog ./../../top_level_wrapper.v 
exec xvlog ./../../top_level_wrapper_tb.v 

#Elaborate
exec xelab $sim_top_module -debug all

# simulation
exec xsim $sim_top_module -R
puts "simulation completed"

# check if the simulation passed
findWordInFile  "PASS" "xsim.log"
cd ../..

#////////////////
# 2. Synthesis, place, and route
#////////////////

catch {close_design}

file mkdir synth_place_route
cd synth_place_route

# load design source
read_verilog ./../mem1.v
read_verilog ./../mem2.v
read_verilog ./../mem_reader.v
read_verilog ./../dotProduct.v
read_verilog ./../mem_writer.v
read_verilog ./../mem3.v
read_verilog ./../top_level_wrapper.v

# load constraints files
read_xdc ./../timingconstraints.xdc


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
report_route_status -file route_status.rpt

# Generate the Bitstream
# write_bitstream -file $bitfile

#////////////////
# 3. Programming the hw
#////////////////


# programming the board
# open_hw_manager
# connect_hw_server -allow_non_jtag
