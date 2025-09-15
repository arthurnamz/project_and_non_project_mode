
`timescale 1ns / 1ps

module memory #(
    parameter DATA_WIDTH = 8,                   
    parameter NUMBER_OF_VECTORS = 4, 
    parameter DEPTH = DATA_WIDTH*NUMBER_OF_VECTORS,  
    parameter ADDR_WIDTH = 5         
)(
    input clk,      
    input rst_n,    
    
    input wr_en,
    input [ADDR_WIDTH-1:0] wr_addr,
    input [DATA_WIDTH-1:0] data_in,

    input rd_en,
    input [ADDR_WIDTH-1:0] rd_addr,
    output reg [DATA_WIDTH-1:0] rd_data
);
    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1];
   
    always @(posedge clk) begin
        if (!rst_n) begin
            memory_array[wr_addr] <= {DATA_WIDTH{1'b0}};
        end else if (wr_en) begin
            memory_array[wr_addr] <= data_in;
        end
    end
    
    always @(posedge clk) begin
        if (!rst_n) begin
            rd_data <= {DATA_WIDTH{1'b0}};
        end else if (rd_en) begin
            rd_data <= memory_array[rd_addr];
        end
    end     
endmodule