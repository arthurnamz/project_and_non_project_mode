create_clock -name clk -period 4 [get_ports clk]
create_generated_clock -name clk_delayed -source [get_pins clk] -divide_by 1 [get_pins BUFGCE_inst/O]