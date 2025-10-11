`timescale 1ns/1ps

module fifo_tb;
   parameter DATA_WIDTH = 8;
   parameter DEPTH = 8;
   parameter PERIOD = 10;
   parameter TESTCASE = 70;

   reg clk;
   reg rstn;
   reg wr_en;
   reg rd_en;
   reg [DATA_WIDTH-1:0] data_in;
   wire [DATA_WIDTH-1:0] data_out;
   wire full;
   wire empty;

   integer i;
   fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .DEPTH(DEPTH)
   ) fifo_inst (
      .clk(clk),
      .rstn(rstn),
      .wr_en(wr_en),
      .rd_en(rd_en),
      .data_in(data_in),
      .data_out(data_out),
      .full(full),
      .empty(empty)
   );

   always #(PERIOD/2) clk = ~clk;

   initial begin
      clk = 0;
      rstn = 0;
      wr_en = 0;
      rd_en = 0;
      
      #20 rstn = 1;
      

      for (i = 0; i < 100; i = i + 1) begin
         wr_en = 1; 
         rd_en = 1;
         data_in = 22 + i;
         #10;
      end


      for (i = 0; i < TESTCASE; i = i + 1) begin
         rd_en = 1;
         wr_en = 0;
         #10;
      end

      #100;
      $finish;
   end
   initial begin
    $monitor("[%0t]   wr_en = %d, rd_en = %d, data_in = %d, data_out = %d, full = %d, empty = %d", $time, wr_en, rd_en, data_in, data_out, full, empty);
   end

endmodule