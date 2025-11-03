
create_clock -name clk1 -period 4 [get_ports clk1]
create_clock -name clk2 -period 4 [get_ports clk2]
create_clock -name clk3 -period 4 [get_ports clk3]

# preventing timing analysis  
set_clock_groups -asynchronous -group {clk1} -group {clk2} -group {clk3}


