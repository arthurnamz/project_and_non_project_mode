set_property PACKAGE_PIN AH18 [get_ports clk_300mhz_clk_p]
set_property PACKAGE_PIN AH17 [get_ports clk_300mhz_clk_n]
current_instance design_1_i/rst_clk_wiz_100M/U0
create_waiver -type CDC -id {CDC-11} -user "proc_sys_reset" -desc "Timing uncritical paths" -tags "1171415" -scope -internal -to [get_pins -quiet -filter REF_PIN_NAME=~*D -of_objects [get_cells -hierarchical -filter {NAME =~ */ACTIVE_LOW_AUX.ACT_LO_AUX/GENERATE_LEVEL_P_S_CDC.SINGLE_BIT.CROSS_PLEVEL_IN2SCNDRY_IN_cdc_to}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
current_instance -quiet
current_instance design_1_i/vio_0
create_waiver -type CDC -id {CDC-4} -user "vio" -desc "The path has combinational circuit. But from hardware prospective the design works perfectly and the signals crossing happen after a very long time from the source has the value." -tags "1050886" -scope -internal -from [get_pins -filter REF_PIN_NAME=~C -of_objects [get_cells -hierarchical -filter {NAME =~ "*probe_in_reg_reg*"}]] -to [get_pins -filter REF_PIN_NAME=~D -of_objects [get_cells -hierarchical -filter {NAME =~ "*data_int_sync1_reg*"}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
create_waiver -type CDC -id {CDC-1} -user "vio" -desc "The path has combinational circuit. But from hardware prospective the design works perfectly and the signals crossing happen after a very long time from the source has the value." -tags "1050886" -scope -internal -from [get_pins -filter REF_PIN_NAME=~C -of_objects [get_cells -hierarchical -filter { NAME =~  "*Hold_probe_in*" &&  IS_SEQUENTIAL }]] -to [get_pins -filter REF_PIN_NAME=~CE -of_objects [get_cells -hierarchical -filter { NAME =~  "*PROBE_IN_INST/probe_in_reg*" && IS_SEQUENTIAL}]] -timestamp "Fri Sep  5 13:01:08 GMT 2025"
current_instance -quiet
set_property PACKAGE_PIN M11 [get_ports reset]
set_property DIRECTION IN [get_ports clk_300mhz_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_300mhz_clk_n]
set_property ODT RTT_NONE [get_ports clk_300mhz_clk_n]
set_property DIRECTION IN [get_ports clk_300mhz_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_300mhz_clk_p]
set_property ODT RTT_NONE [get_ports clk_300mhz_clk_p]
set_property DIRECTION IN [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
