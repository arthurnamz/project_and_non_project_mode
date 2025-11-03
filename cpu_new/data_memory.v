// Data Memory Module
// Dual-Port Read, Dual-Port Write memory for storing CPU data

`timescale 1ns / 1ps

module data_memory #(
    parameter DEPTH = 8,           
    parameter DATA_WIDTH = 8,           
    parameter ADDR_WIDTH = 3
)(
    input clk,
    // rstn removed - not used in synthesizable RAM template
    input wr_en1,
    input wr_en2,
    input rd_en1,
    input rd_en2,                          
    input [ADDR_WIDTH-1:0] wr_addr1,
    input [ADDR_WIDTH-1:0] wr_addr2,       
    input [ADDR_WIDTH-1:0] rd_addr1,
    input [ADDR_WIDTH-1:0] rd_addr2,       
    input [DATA_WIDTH-1:0] data_in1,
    input [DATA_WIDTH-1:0] data_in2,          
    output reg [DATA_WIDTH-1:0] data_out1,
    output reg [DATA_WIDTH-1:0] data_out2          
);

    // Memory array - stores data
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    // Write Port 1
    always @(posedge clk) begin
        if (wr_en1) begin
            mem[wr_addr1] <= data_in1;
        end
    end
    
    // Write Port 2
    always @(posedge clk) begin
        if (wr_en2) begin
            mem[wr_addr2] <= data_in2;
        end
    end

    // Read Port 1
    always @(posedge clk) begin
        if (rd_en1) begin
            data_out1 <= mem[rd_addr1];
        end
    end
    
    // Read Port 2
    always @(posedge clk) begin
        if (rd_en2) begin
            data_out2 <= mem[rd_addr2];
        end
    end

endmodule


