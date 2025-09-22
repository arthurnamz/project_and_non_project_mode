
`timescale 1ns/1ps

module mem1 #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64
)
(
 input clk,
 input rst_n,

 input write_en,
 input [ADDR_WIDTH-1:0]write_address,
 input [DATA_WIDTH-1:0]data_in,
 
 input read_en,
 input [ADDR_WIDTH-1:0]read_address,
 output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] mem[0:MEM_SIZE-1];

always@(posedge clk)
begin
 if(!rst_n)
  mem[write_address]<= 8'b0;
 else if(write_en) begin
     mem[write_address]<= data_in;
   end
end

always@(posedge clk)
begin
 if(!rst_n)
  data_out <= 8'b0;
 else if(read_en) begin
     data_out <= mem[read_address];
   end  
end

endmodule