
`timescale 1ns/1ps
(* dont_touch="true" *)
module memory #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter MEM_SIZE = 32
)
(
 input clk,
 input rstn,

 input wr_en,
 input [ADDR_WIDTH-1:0]wr_address,
 input [DATA_WIDTH-1:0]data_in,
 
 input rd_en,
 input [ADDR_WIDTH-1:0]rd_address,
 output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] mem[0:MEM_SIZE-1];

always@(posedge clk)
begin
 if(!rstn)
   mem[wr_address] <= {DATA_WIDTH{1'b0}};
 else if(wr_en) begin
   mem[wr_address] <= data_in;
 end
end

always@(posedge clk)
begin
 if(!rstn)
   data_out <= {DATA_WIDTH{1'b0}};
 else if(rd_en) begin
   data_out <= mem[rd_address];
 end  
end

endmodule