`timescale 1ns / 1ps

// Input Memory Wrapper
// Contains mem1, mem2, and mem_reader for complete input processing
// Note: mem_reader has its own mem1 and mem2 instances internally

module input_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst_n,
    
    // Input interface for writing data
    input write_en,
    input [ADDR_WIDTH-1:0] write_addr,
    input [DATA_WIDTH-1:0] data_a,
    input [DATA_WIDTH-1:0] data_b,
    
    // Memory reader control interface
    input start_reading,
    output wire reading_done,
    output wire [DATA_WIDTH-1:0] mem1_output,
    output wire [DATA_WIDTH-1:0] mem2_output,
    output wire data_valid,
    output wire [2:0] element_count
);

    // Memory instances for writing data
    mem1 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) mem1_write_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_address(write_addr),
        .data_in(data_a),
        .read_en(1'b0),            // Write-only instance
        .read_address({ADDR_WIDTH{1'b0}}),
        .data_out()
    );

    mem2 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) mem2_write_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_address(write_addr),
        .data_in(data_b),
        .read_en(1'b0),            // Write-only instance
        .read_address({ADDR_WIDTH{1'b0}}),
        .data_out()
    );

    // Memory reader for reading from its own mem1 and mem2 instances
    mem_reader #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem_reader_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start_reading(start_reading),
        .reading_done(reading_done),
        .rd_en_mem1(),             // Internal to mem_reader
        .rd_en_mem2(),             // Internal to mem_reader
        .rd_addr_mem1(),           // Internal to mem_reader
        .rd_addr_mem2(),           // Internal to mem_reader
        .mem1_output(mem1_output),
        .mem2_output(mem2_output),
        .data_valid(data_valid),
        .element_count(element_count)
    );

endmodule
