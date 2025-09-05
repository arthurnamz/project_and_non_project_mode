
`timescale 1ns/1ps

module tb;
  localparam PERIOD = 4;
  localparam DATA_WIDTH = 4;

  reg clk = 0;
  reg rst_n;
  reg direction;
  wire [DATA_WIDTH-1:0] count;

  counter #(
    .DATA_WIDTH(DATA_WIDTH)
  ) u_counter (
    .clk(clk),
    .rst_n(rst_n),
    .direction(direction),
    .count(count)
  );

  always #(PERIOD/2) clk = ~clk;

  initial begin
    rst_n = 0;
   

   #100 rst_n = 1;
   
   #10 direction = 1;

   #10 direction = 0;
 
  end 

  initial begin
    $monitor($time, "rst_n = %b, direction = %b, count = %d", rst_n, direction, count);
    #1000 $finish;
  end

endmodule
