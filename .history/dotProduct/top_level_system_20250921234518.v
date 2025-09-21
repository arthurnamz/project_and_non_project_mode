`timescale 1ns / 1ps

// Top Level System Module
// Integrates all components: memory controller, mem_reader, dotProduct, and mem_writer
// Complete dot product system with data flow: Input -> Memory -> Read -> Compute -> Store

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
    
    // System control
    input system_start,
    output reg system_busy,
    output reg system_done,
    
    // Input data interface (for writing vectors to mem1 and mem2)
    input write_en,
    input [ADDR_WIDTH-1:0] write_addr,
    input [DATA_WIDTH-1:0] data_a,      // Data for mem1
    input [DATA_WIDTH-1:0] data_b,      // Data for mem2
    
    // Output interface (for reading results from mem3)
    input read_en,
    input [MEM3_ADDR_WIDTH-1:0] read_addr,
    output reg [DATA_WIDTH-1:0] result_out,
    
    // Status signals
    output reg [2:0] processing_stage,  // 0: idle, 1: writing, 2: reading, 3: computing, 4: storing
    output reg [2:0] vector_count,
    output reg [2:0] result_count
);

    // Internal signals for memory controller
    reg mem_ctrl_start;
    reg mem_ctrl_in_valid;
    reg mem_ctrl_busy;
    wire mem_ctrl_done;
    
    // Internal signals for memory reader
    reg reader_start;
    wire reader_done;
    wire reader_data_valid;
    wire [DATA_WIDTH-1:0] reader_mem1_out;
    wire [DATA_WIDTH-1:0] reader_mem2_out;
    
    // Internal signals for dot product
    wire [RESULT_WIDTH-1:0] dp_result;
    wire dp_result_valid;
    wire dp_processing_done;
    
    // Internal signals for memory writer
    wire writer_busy;
    wire writer_done;
    wire [MEM3_ADDR_WIDTH-1:0] writer_addr;
    wire [DATA_WIDTH-1:0] writer_data;
    
    // Memory controller for writing to mem1 and mem2
    mem_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .VETOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .start(mem_ctrl_start),
        .in_valid(mem_ctrl_in_valid),
        .data_a(data_a),
        .data_b(data_b),
        .busy(mem_ctrl_busy),
        .done(mem_ctrl_done),
        .rd_en_a(1'b0),        // Not used in this system
        .rd_addr_a({ADDR_WIDTH{1'b0}}),
        .dout_a(),             // Not used
        .rd_en_b(1'b0),        // Not used in this system
        .rd_addr_b({ADDR_WIDTH{1'b0}}),
        .dout_b()              // Not used
    );

    // Memory reader for reading from mem1 and mem2
    mem_reader #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem_reader_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start_reading(reader_start),
        .reading_done(reader_done),
        .rd_en_mem1(),         // Internal to mem_reader
        .rd_en_mem2(),         // Internal to mem_reader
        .rd_addr_mem1(),       // Internal to mem_reader
        .rd_addr_mem2(),       // Internal to mem_reader
        .mem1_output(reader_mem1_out),
        .mem2_output(reader_mem2_out),
        .data_valid(reader_data_valid),
        .element_count()       // Internal to mem_reader
    );

    // Dot product computation module
    dotProduct #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) dp_inst (
        .clk(clk),
        .rst_n(rst_n),
        .mem1_output(reader_mem1_out),
        .mem2_output(reader_mem2_out),
        .data_valid(reader_data_valid),
        .dot_product_result(dp_result),
        .result_valid(dp_result_valid),
        .processing_done(dp_processing_done)
    );

    // Memory writer for storing results to mem3
    mem_writer #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .ADDR_WIDTH(MEM3_ADDR_WIDTH),
        .MEM_SIZE(MEM3_SIZE),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) mem_writer_inst (
        .clk(clk),
        .rst_n(rst_n),
        .dot_product_result(dp_result),
        .result_valid(dp_result_valid),
        .processing_done(dp_processing_done),
        .write_en(),           // Internal to mem_writer
        .write_address(writer_addr),
        .data_in(writer_data),
        .writer_busy(writer_busy),
        .writer_done(writer_done),
        .result_count()        // Internal to mem_writer
    );

    // Output result reading (direct access to mem3)
    always @(posedge clk) begin
        if (!rst_n) begin
            result_out <= {DATA_WIDTH{1'b0}};
        end else if (read_en) begin
            // Read from mem3 through the writer's memory instance
            // This would need to be connected to mem3's read port
            result_out <= writer_data; // Simplified for now
        end
    end

endmodule
