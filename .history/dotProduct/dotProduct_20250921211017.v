// Write your dot product code here. use the input from mem1 and mem2 as input 

module dotProduct #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4
)
(
    input clk,
    input rst_n,
    input start,
    input [VECTOR_WIDTH-1:0] data_in_mem1,
    input [DATA_WIDTH-1:0] data_in_mem2,
    output reg [DATA_WIDTH-1:0] data_out
    output reg done
);

