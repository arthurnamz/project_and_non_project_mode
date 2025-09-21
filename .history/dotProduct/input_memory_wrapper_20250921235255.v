`timescale 1ns / 1ps

// Input Memory Wrapper
// Wraps mem1 and mem2 with memory controller for writing data

module input_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst_n,
    
    // Input interface
    input write_en,
    input [ADDR_WIDTH-1:0] write_addr,
    input [DATA_WIDTH-1:0] data_a,
    input [DATA_WIDTH-1:0] data_b,
    
    // Output interface for reading
    input rd_en_a,
    input [ADDR_WIDTH-1:0] rd_addr_a,
    output wire [DATA_WIDTH-1:0] dout_a,
    input rd_en_b,
    input [ADDR_WIDTH-1:0] rd_addr_b,
    output wire [DATA_WIDTH-1:0] dout_b
);

    // Memory controller for writing to mem1 and mem2
    mem_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .start(1'b1),              // Always ready for writes
        .in_valid(write_en),
        .data_a(data_a),
        .data_b(data_b),
        .busy(),
        .done(),
        .rd_en_a(rd_en_a),
        .rd_addr_a(rd_addr_a),
        .dout_a(dout_a),
        .rd_en_b(rd_en_b),
        .rd_addr_b(rd_addr_b),
        .dout_b(dout_b)
    );

endmodule
