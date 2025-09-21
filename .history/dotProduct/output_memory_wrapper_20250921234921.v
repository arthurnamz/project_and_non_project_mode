`timescale 1ns / 1ps

// Output Memory Wrapper
// Wraps mem3 with memory writer for storing results

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
        .write_en(),           // Internal to mem_writer
        .write_address(),      // Internal to mem_writer
        .data_in(),            // Internal to mem_writer
        .writer_busy(writer_busy),
        .writer_done(writer_done),
        .result_count()        // Internal to mem_writer
    );

    // Direct access to mem3 for reading results
    // This needs to be connected to the actual mem3 instance inside mem_writer
    // For now, we'll create a simple interface
    assign result_out = dot_product_result[DATA_WIDTH-1:0]; // Simplified for now

endmodule
