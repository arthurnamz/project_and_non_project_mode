set_property SRC_FILE_INFO {cfile:/home/arthur/personal_projects/FPGA_masterclass/project_and_non_project_mode/Adder/floorplanning.xdc rfile:../../floorplanning.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:/home/arthur/personal_projects/FPGA_masterclass/project_and_non_project_mode/Adder/pin.xdc rfile:../../pin.xdc id:2} [current_design]
set_property src_info {type:XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_adder_i
resize_pblock [get_pblocks pblock_adder_i] -add {SLICE_X52Y200:SLICE_X60Y208}
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_adder_i]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_adder_i]
set_property IS_SOFT FALSE [get_pblocks pblock_adder_i]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock pblock_adder_i [get_cells [list design_1_i/top_0/inst/adder_i]] -clear_locs
set_property src_info {type:XDC file:1 line:10 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_display_a
resize_pblock [get_pblocks pblock_display_a] -add {SLICE_X56Y142:SLICE_X61Y152}
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_a]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_a]
set_property IS_SOFT FALSE [get_pblocks pblock_display_a]
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock pblock_display_a [get_cells [list design_1_i/top_0/inst/display_a]] -clear_locs
set_property src_info {type:XDC file:1 line:18 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_display_b
resize_pblock [get_pblocks pblock_display_b] -add {SLICE_X53Y95:SLICE_X57Y104}
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_b]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_b]
set_property IS_SOFT FALSE [get_pblocks pblock_display_b]
set_property src_info {type:XDC file:1 line:20 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock pblock_display_b [get_cells [list design_1_i/top_0/inst/display_b]] -clear_locs
set_property src_info {type:XDC file:1 line:26 export:INPUT save:INPUT read:READ} [current_design]
create_pblock pblock_display_sum
resize_pblock [get_pblocks pblock_display_sum] -add {SLICE_X73Y132:SLICE_X78Y144}
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_sum]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_sum]
set_property IS_SOFT FALSE [get_pblocks pblock_display_sum]
set_property src_info {type:XDC file:1 line:28 export:INPUT save:INPUT read:READ} [current_design]
add_cells_to_pblock pblock_display_sum [get_cells [list design_1_i/top_0/inst/display_sum]] -clear_locs
set_property src_info {type:XDC file:2 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AH18 [get_ports clk_300mhz_clk_p]
set_property src_info {type:XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AH17 [get_ports clk_300mhz_clk_n]
set_property src_info {type:XDC file:2 line:3 export:INPUT save:INPUT read:READ} [current_design]
current_instance design_1_i/rst_clk_wiz_100M/U0
set_property src_info {type:XDC file:2 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -type CDC -id {CDC-11} -user "proc_sys_reset" -desc "Timing uncritical paths" -tags "1171415" -scope -internal -to [get_pins -quiet -filter REF_PIN_NAME=~*D -of_objects [get_cells -hierarchical -filter {NAME =~ */ACTIVE_LOW_AUX.ACT_LO_AUX/GENERATE_LEVEL_P_S_CDC.SINGLE_BIT.CROSS_PLEVEL_IN2SCNDRY_IN_cdc_to}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
set_property src_info {type:XDC file:2 line:6 export:INPUT save:INPUT read:READ} [current_design]
current_instance design_1_i/vio_0
set_property src_info {type:XDC file:2 line:7 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -type CDC -id {CDC-4} -user "vio" -desc "The path has combinational circuit. But from hardware prospective the design works perfectly and the signals crossing happen after a very long time from the source has the value." -tags "1050886" -scope -internal -from [get_pins -filter REF_PIN_NAME=~C -of_objects [get_cells -hierarchical -filter {NAME =~ "*probe_in_reg_reg*"}]] -to [get_pins -filter REF_PIN_NAME=~D -of_objects [get_cells -hierarchical -filter {NAME =~ "*data_int_sync1_reg*"}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
set_property src_info {type:XDC file:2 line:8 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -type CDC -id {CDC-1} -user "vio" -desc "The path has combinational circuit. But from hardware prospective the design works perfectly and the signals crossing happen after a very long time from the source has the value." -tags "1050886" -scope -internal -from [get_pins -filter REF_PIN_NAME=~C -of_objects [get_cells -hierarchical -filter { NAME =~  "*Hold_probe_in*" &&  IS_SEQUENTIAL }]] -to [get_pins -filter REF_PIN_NAME=~CE -of_objects [get_cells -hierarchical -filter { NAME =~  "*PROBE_IN_INST/probe_in_reg*" && IS_SEQUENTIAL}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M11 [get_ports reset]
set_property src_info {type:XDC file:2 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property DIRECTION IN [get_ports clk_300mhz_clk_n]
set_property src_info {type:XDC file:2 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_300mhz_clk_n]
set_property src_info {type:XDC file:2 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property ODT RTT_NONE [get_ports clk_300mhz_clk_n]
set_property src_info {type:XDC file:2 line:14 export:INPUT save:INPUT read:READ} [current_design]
set_property DIRECTION IN [get_ports clk_300mhz_clk_p]
set_property src_info {type:XDC file:2 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_300mhz_clk_p]
set_property src_info {type:XDC file:2 line:16 export:INPUT save:INPUT read:READ} [current_design]
set_property ODT RTT_NONE [get_ports clk_300mhz_clk_p]
set_property src_info {type:XDC file:2 line:17 export:INPUT save:INPUT read:READ} [current_design]
set_property DIRECTION IN [get_ports reset]
set_property src_info {type:XDC file:2 line:18 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
