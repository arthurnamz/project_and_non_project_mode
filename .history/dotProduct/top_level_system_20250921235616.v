`timescale 1ns / 1ps

// Final Top Level System Wrapper
// Hierarchical wrapper approach: Input Wrapper -> Memory Reader Wrapper -> Dot Product -> Output Wrapper
// No state machines, just simple module connections

module top_level_system #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH),
    parameter MEM3_ADDR_WIDTH = 4,
    parameter MEM3_SIZE = 64
)(
    input clk,
    input rst_n,
    
    // Input data interface (for writing vectors)
    input write_en,
    input [ADDR_WIDTH-1:0] write_addr,
    input [DATA_WIDTH-1:0] data_a,      // Data for mem1
    input [DATA_WIDTH-1:0] data_b,      // Data for mem2
    
    // Memory reader control
    input start_reading,
    output wire reading_done,
    
    // Output interface (for reading results from mem3)
    input read_en,
    input [MEM3_ADDR_WIDTH-1:0] read_addr,
    output wire [DATA_WIDTH-1:0] result_out,
    
    // Status signals
    output wire writer_busy,
    output wire writer_done
);

    // Internal signals between modules
    wire [DATA_WIDTH-1:0] mem1_output;
    wire [DATA_WIDTH-1:0] mem2_output;
    wire data_valid;
    wire [2:0] element_count;
    wire [RESULT_WIDTH-1:0] dot_product_result;
    wire result_valid;
    wire processing_done;

    // Input Memory Wrapper (contains mem1 + mem2 + mem_reader)
    input_memory_wrapper #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) input_memory_wrapper_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_addr(write_addr),
        .data_a(data_a),
        .data_b(data_b),
        .start_reading(start_reading),
        .reading_done(reading_done),
        .mem1_output(mem1_output),
        .mem2_output(mem2_output),
        .data_valid(data_valid),
        .element_count(element_count)
    );

    // Dot Product computation module
    dotProduct #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) dp_inst (
        .clk(clk),
        .rst_n(rst_n),
        .mem1_output(mem1_output),
        .mem2_output(mem2_output),
        .data_valid(data_valid),
        .dot_product_result(dot_product_result),
        .result_valid(result_valid),
        .processing_done(processing_done)
    );

    // Output Memory Wrapper (contains mem_writer + mem3)
    output_memory_wrapper #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .ADDR_WIDTH(MEM3_ADDR_WIDTH),
        .MEM_SIZE(MEM3_SIZE),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) output_memory_wrapper_inst (
        .clk(clk),
        .rst_n(rst_n),
        .dot_product_result(dot_product_result),
        .result_valid(result_valid),
        .processing_done(processing_done),
        .read_en(read_en),
        .read_addr(read_addr),
        .result_out(result_out),
        .writer_busy(writer_busy),
        .writer_done(writer_done)
    );

endmodule
