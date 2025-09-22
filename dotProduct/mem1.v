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
 if(write_en) begin
   mem[write_address] <= data_in;
 end
end

always@(posedge clk)
begin
 if(!rst_n)
   data_out <= {DATA_WIDTH{1'b0}};
 else if(read_en) begin
   data_out <= mem[read_address];
 end  
end

// Initialize memory with golden values for simulation
integer i;
initial begin
  for (i = 0; i < MEM_SIZE; i = i + 1) begin
    mem[i] = {DATA_WIDTH{1'b0}};
  end
  // Golden pattern used in mem_reader_tb - initialize all addresses
  mem[0] = 8'h11;  mem[1] = 8'h12;  mem[2] = 8'h13;  mem[3] = 8'h14;
  mem[4] = 8'h15;  mem[5] = 8'h16;  mem[6] = 8'h17;  mem[7] = 8'h18;
  mem[8] = 8'h19;  mem[9] = 8'h1A;  mem[10] = 8'h1B; mem[11] = 8'h1C;
  mem[12] = 8'h1D; mem[13] = 8'h1E; mem[14] = 8'h1F; mem[15] = 8'h20;
  mem[16] = 8'h21; mem[17] = 8'h22; mem[18] = 8'h23; mem[19] = 8'h24;
  mem[20] = 8'h25; mem[21] = 8'h26; mem[22] = 8'h27; mem[23] = 8'h28;
  mem[24] = 8'h29; mem[25] = 8'h2A; mem[26] = 8'h2B; mem[27] = 8'h2C;
  mem[28] = 8'h2D; mem[29] = 8'h2E; mem[30] = 8'h2F; mem[31] = 8'h30;
end

endmodule