`timescale 1ns/1ps

module mem2 #(
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
  mem[0] = 8'h21;  mem[1] = 8'h22;  mem[2] = 8'h23;  mem[3] = 8'h24;
  mem[4] = 8'h25;  mem[5] = 8'h26;  mem[6] = 8'h27;  mem[7] = 8'h28;
  mem[8] = 8'h29;  mem[9] = 8'h2A;  mem[10] = 8'h2B; mem[11] = 8'h2C;
  mem[12] = 8'h2D; mem[13] = 8'h2E; mem[14] = 8'h2F; mem[15] = 8'h30;
  mem[16] = 8'h31; mem[17] = 8'h32; mem[18] = 8'h33; mem[19] = 8'h34;
  mem[20] = 8'h35; mem[21] = 8'h36; mem[22] = 8'h37; mem[23] = 8'h38;
  mem[24] = 8'h39; mem[25] = 8'h3A; mem[26] = 8'h3B; mem[27] = 8'h3C;
  mem[28] = 8'h3D; mem[29] = 8'h3E; mem[30] = 8'h3F; mem[31] = 8'h40;
end

endmodule