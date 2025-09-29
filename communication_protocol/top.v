`timescale 1ns/1ps


module top
#(
 parameter DATA_WIDTH  = 16
)
(
  input clk,
  input rstn,

  // slave interfaces (inputs of the system)
  input axis1_tvalid,
  output axis1_tready,	  
  input [DATA_WIDTH-1:0] axis1_tdata,

  input axis2_tvalid,
  output axis2_tready,
  input [DATA_WIDTH-1:0] axis2_tdata,

  //master interface (output of the system)
  output axim3_tvalid, 
  input axim3_tready,
  output [DATA_WIDTH-1:0] axim3_tdata,

  //external opcode setting
  input [3:0] opCode 
);

 wire cpu1_axim_tvalid;
 wire cpu1_axim_tready;
 wire [DATA_WIDTH-1:0] cpu1_axim_tdata;

 wire cpu2_axim_tvalid;
 wire cpu2_axim_tready;
 wire [DATA_WIDTH-1:0] cpu2_axim_tdata;

 wire cpu3_axis_tready;
 wire [DATA_WIDTH-1:0] packet;

 //connections
 assign cpu1_axim_tready = cpu3_axis_tready;
 assign cpu2_axim_tready = cpu3_axis_tready;

 //packet construction
 assign packet = {cpu1_axim_tdata[5:0] ,cpu2_axim_tdata[5:0] ,opCode};
 

 //cpu1 instance
 cpu #(.DATA_WIDTH(DATA_WIDTH)) cpu1(
                                      .clk(clk),
				      .rstn(rstn),

				      .axis_tvalid(axis1_tvalid),
				      .axis_tready(axis1_tready),
				      .axis_tdata(axis1_tdata), 

				      .axim_tvalid(cpu1_axim_tvalid),
				      .axim_tready(cpu1_axim_tready),
				      .axim_tdata(cpu1_axim_tdata)
                                    );

 //cpu2 instance
 cpu #(.DATA_WIDTH(DATA_WIDTH)) cpu2(
                                      .clk(clk),
                                      .rstn(rstn),

                                      .axis_tvalid(axis2_tvalid),
                                      .axis_tready(axis2_tready),
                                      .axis_tdata(axis2_tdata), 

                                      .axim_tvalid(cpu2_axim_tvalid),
                                      .axim_tready(cpu2_axim_tready),
                                      .axim_tdata(cpu2_axim_tdata)
                                    );
 
 //cpu3 instance
 cpu #(.DATA_WIDTH(DATA_WIDTH)) cpu3(
                                      .clk(clk),
                                      .rstn(rstn),

                                      .axis_tvalid(cpu1_axim_tvalid & cpu2_axim_tvalid),
                                      .axis_tready(cpu3_axis_tready),
                                      .axis_tdata(packet), 

                                      .axim_tvalid(axim3_tvalid),
                                      .axim_tready(axim3_tready),
                                      .axim_tdata(axim3_tdata)
                                    );

endmodule



