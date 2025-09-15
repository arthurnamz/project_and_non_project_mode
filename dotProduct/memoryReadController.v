`timescale 1ns / 1ps

module memoryReadController #(
    parameter DATA_WIDTH = 8,                   
    parameter NUMBER_OF_VECTORS = 4, 
    parameter DEPTH = DATA_WIDTH*NUMBER_OF_VECTORS,  
    parameter ADDR_WIDTH = 5         
)(
    input clk,
    input rst_n,
    input start,
    output reg rd_en_mem1,
    output reg rd_en_mem2,
    output reg [ADDR_WIDTH-1:0] rd_addr_mem1,
    output reg [ADDR_WIDTH-1:0] rd_addr_mem2,

    input [DATA_WIDTH-1:0] data_from_mem1,
    input [DATA_WIDTH-1:0] data_from_mem2,
    output reg [DATA_WIDTH-1:0] data_out1,
    output reg [DATA_WIDTH-1:0] data_out2,
    output reg done
);
    
    // instantiate two memory modules here
    reg [ADDR_WIDTH-1:0] read_counter;
    reg reading = 0;
    memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_OF_VECTORS(NUMBER_OF_VECTORS),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem1 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(1'b0), // No write operation
        .wr_addr(5'b0), // Not used
        .data_in(8'b0), // Not used
        .rd_en(rd_en_mem1),
        .rd_addr(rd_addr_mem1),
        .rd_data(data_from_mem1)
    );

    memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_OF_VECTORS(NUMBER_OF_VECTORS),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem2 (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(1'b0), // No write operation
        .wr_addr(5'b0), // Not used
        .data_in(8'b0), // Not used
        .rd_en(rd_en_mem2),
        .rd_addr(rd_addr_mem2),
        .rd_data(data_from_mem2)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            rd_en_mem1 <= 0;
            rd_en_mem2 <= 0;
            read_counter <= 0;
            done <= 0;
            reading <= 0;
        end else if (start && !reading) begin
            reading <= 1;
            rd_en_mem1 <= 1;
            rd_en_mem2 <= 1;
            read_counter <= 0;
            done <= 0;
        end else if (reading) begin
            if (read_counter < DEPTH) begin
                rd_addr_mem1 <= read_counter;
                rd_addr_mem2 <= read_counter;
                data_out1 <= data_from_mem1;
                data_out2 <= data_from_mem2;
                read_counter <= read_counter + 1;
            end else begin
                rd_en_mem1 <= 0;
                rd_en_mem2 <= 0;
                done <= 1;
                reading <= 0;
            end
        end
    end     
endmodule