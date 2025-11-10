`timescale 1ns/1ps

module top_tb;

parameter DATA_WIDTH = 16;
parameter PERIOD = 4;

reg clk = 0;
reg rstn;

  reg axis1_tvalid;
  wire axis1_tready;	  
  reg [DATA_WIDTH-1:0] axis1_tdata;

  reg axis2_tvalid;
  wire axis2_tready;
  reg [DATA_WIDTH-1:0] axis2_tdata;

  wire axim3_tvalid;
  reg axim3_tready;
  wire [DATA_WIDTH-1:0] axim3_tdata;

  reg [3:0] opCode ;

  top #(
    .DATA_WIDTH(DATA_WIDTH)
    ) DUT(
    .clk(clk),
    .rstn(rstn),

    .axis1_tvalid(axis1_tvalid),
    .axis1_tready(axis1_tready),
    .axis1_tdata(axis1_tdata),

    .axis2_tvalid(axis2_tvalid),
    .axis2_tready(axis2_tready),
    .axis2_tdata(axis2_tdata),

    .axim3_tvalid(axim3_tvalid),
    .axim3_tready(axim3_tready),
    .axim3_tdata(axim3_tdata),

    .opCode(opCode)
  );


  always #(PERIOD/2) clk = ~clk;

  initial begin
    rstn = 0;
    #10 rstn = 1;

    axim3_tready = 0;
    
    repeat(4) @(posedge clk);
    // send data to cpu1
    axis1_tdata = {6'b0000101, 6'b0000011, 4'b0000}; // 5 + 3 = 8
    axis1_tvalid = 1;

    axis2_tdata = {6'b0000001, 6'b0000010, 4'b0000}; // 1 + 2 = 3
    axis2_tvalid = 1;
    opCode = 4'b0001; // opcode =2, AND

    repeat(1) @(posedge clk);
    axim3_tready = 1'b1;

    #1000 $finish;  
  end

  initial begin
    $monitor($time , " axim3_tvalid = %d, axim3_tdata = %d", axim3_tvalid, axim3_tdata);
  end


endmodule