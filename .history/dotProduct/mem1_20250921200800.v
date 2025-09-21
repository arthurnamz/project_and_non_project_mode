
`timescale 1ns/1ps

module mem1 #(
 parameter ADDR_WIDTH = 4,
 parameter MEM_SIZE = 64,
 parameter DATA_WIDTH = 8
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

reg [DATA_WIDTH-1:0] ram[0:MEM_SIZE-1];

always@(posedge clk)
begin
 if(rst)
  ram[write_address]<= 'bz;
 else
   begin
    if(write_en)
     ram[write_address]<= data_in;
    if(read_en)
     data_out<=ram[read_address];
   end
end
endmodule