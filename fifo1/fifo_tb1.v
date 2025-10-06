`timescale 1ns/1ps

module fifo_tb1;
   parameter DATA_WIDTH = 8;
   parameter DEPTH = 8;
   parameter PERIOD = 10;
   parameter TESTCASE = 10;

   reg clk;
   reg rstn;
   reg wr_en;
   reg rd_en;
   reg [DATA_WIDTH-1:0] data_in;
   wire [DATA_WIDTH-1:0] data_out;
   wire full;
   wire empty;

   reg stop;
   reg [DATA_WIDTH-1:0] rdata;


   integer i;

   fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .DEPTH(DEPTH)
   ) fifo_inst1 (
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
    clk 	= 0;
    rstn 	= 0;
    wr_en 	= 0;
    rd_en 	= 0;
    stop  	= 0;

    #50 rstn = 1;
  end

  initial begin
    @(posedge clk);

    for ( i = 0; i < TESTCASE; i = i+1) begin

      // Wait until there is space in fifo
      while (full) begin
      	@(posedge clk);
        $display("[%0t] FIFO is full, wait for reads to happen", $time);
      end

      // Drive new values into FIFO
      wr_en = 1;
      data_in 	= 22 + i;
      $display("[%0t] clk i=%0d wr_en=%0d din=%0d ", $time, i, wr_en, data_in);

      // Wait for next clock edge
      @(posedge clk);
    end

    stop = 1;
  end

  initial begin
    @(posedge clk);

    while (!stop) begin
      // Wait until there is data in fifo
      while (empty) begin
        rd_en = 0;
        $display("[%0t] FIFO is empty, wait for writes to happen", $time);
        @(posedge clk);
      end

      // Sample new values from FIFO at random pace
      rd_en = 1;
      @(posedge clk);
      rdata = data_out;
      $display("[%0t] clk rd_en=%0d rdata=%0d ", $time, rd_en, rdata);
    end

    #1000 $finish;
  end
endmodule