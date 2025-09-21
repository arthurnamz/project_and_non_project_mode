`timescale 1ns / 1ps

// Output Memory Wrapper
// Contains mem_writer and mem3 for complete output processing

module output_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)
)(
    input clk,
    input rst_n,
    
    // Input interface for writing results
    input [RESULT_WIDTH-1:0] dot_product_result,
    input result_valid,
    input processing_done,
    
    // Output interface for reading results
    input read_en,
    input [ADDR_WIDTH-1:0] read_addr,
    output wire [DATA_WIDTH-1:0] result_out,
    
    // Status signals
    output wire writer_busy,
    output wire writer_done
);

    // Internal signals for mem3 access
    wire mem3_write_en;
    wire [ADDR_WIDTH-1:0] mem3_write_addr;
    wire [DATA_WIDTH-1:0] mem3_write_data;

    // Memory writer for storing results to mem3
    mem_writer #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(MEM_SIZE),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) mem_writer_inst (
        .clk(clk),
        .rst_n(rst_n),
        .dot_product_result(dot_product_result),
        .result_valid(result_valid),
        .processing_done(processing_done),
        .write_en(mem3_write_en),           // Connect to mem3
        .write_address(mem3_write_addr),    // Connect to mem3
        .data_in(mem3_write_data),          // Connect to mem3
        .writer_busy(writer_busy),
        .writer_done(writer_done),
        .result_count()                     // Internal to mem_writer
    );

    // mem3 instance for storing and reading results
    mem3 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(MEM_SIZE)
    ) mem3_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(mem3_write_en),
        .write_address(mem3_write_addr),
        .data_in(mem3_write_data),
        .read_en(read_en),
        .read_address(read_addr),
        .data_out(result_out)
    );

endmodule
