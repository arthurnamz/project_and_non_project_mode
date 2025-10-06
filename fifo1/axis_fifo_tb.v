`timescale 1ns/1ps

module axis_fifo_tb;
   parameter DATA_WIDTH = 8;
   parameter DEPTH = 8;
   parameter ADDR_WIDTH = 3;
   parameter PERIOD = 10;
   parameter TESTCASE = 70;

   reg clk;
   reg rstn;
   
   //Slave interface
   reg [DATA_WIDTH-1:0] s_axis_tdata;
   reg s_axis_tvalid;
   wire s_axis_tready;

   //Master interface
   wire [DATA_WIDTH-1:0] m_axis_tdata;
   wire m_axis_tvalid;
   reg m_axis_tready;

   integer i;

   axis_fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .DEPTH(DEPTH),
      .ADDR_WIDTH(ADDR_WIDTH)
   ) axis_fifo_inst (
      .clk(clk),
      .rstn(rstn),

      .s_axis_tdata(s_axis_tdata),
      .s_axis_tvalid(s_axis_tvalid),
      .s_axis_tready(s_axis_tready),

      .m_axis_tdata(m_axis_tdata),
      .m_axis_tvalid(m_axis_tvalid),
      .m_axis_tready(m_axis_tready)
   );

   always #(PERIOD/2) clk = ~clk;

   initial begin
      clk = 0;
      rstn = 0;
      s_axis_tvalid = 0;
      m_axis_tready = 0;
      
      #20 rstn = 1;
      

      for (i = 0; i < TESTCASE; i = i + 1) begin
         s_axis_tvalid = 1; 
         s_axis_tdata = 22 + i;
         #10;
         s_axis_tvalid = 0;
      end

       #10;
      for (i = 0; i < TESTCASE; i = i + 1) begin
         m_axis_tready = 1;
         #10;
         m_axis_tready = 0;
      end

      #100;
      $finish;
   end
   initial begin
    $monitor("[%0t]   s_axis_tvalid = %d, m_axis_tready = %d, s_axis_tdata = %d, m_axis_tdata = %d", $time, s_axis_tvalid, m_axis_tready, s_axis_tdata, m_axis_tdata);
   end

endmodule
