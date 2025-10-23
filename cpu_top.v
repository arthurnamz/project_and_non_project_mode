// Top-level module that instantiates CPU, Instruction Memory, and Data Memory
// and connects them together

`timescale 1ns/1ps

module cpu_top#(
    parameter DATA_WIDTH = 10,
    parameter MEM_DEPTH = 8,
    parameter ADDR_WIDTH = 3
) (
    input clk,
    input rstn,
    input start,
    output done
);

// Wires for instruction memory and cpu
wire [DATA_WIDTH-1:0] instr_mem_data_out_wire;
wire [ADDR_WIDTH-1:0] instr_mem_addr_wire;
wire instr_mem_rd_en_wire;

// Wires for data memory and cpu (Data memory is 8-bit wide, dual-port read and write)
wire [7:0] data_mem_data_out1_wire;
wire [7:0] data_mem_data_out2_wire;
wire [7:0] data_mem_data_in1_wire;
wire [7:0] data_mem_data_in2_wire;
wire [ADDR_WIDTH-1:0] data_mem_rd_addr1_wire;
wire [ADDR_WIDTH-1:0] data_mem_rd_addr2_wire;
wire [ADDR_WIDTH-1:0] data_mem_wr_addr1_wire;
wire [ADDR_WIDTH-1:0] data_mem_wr_addr2_wire;
wire data_mem_rd_en1_wire;
wire data_mem_rd_en2_wire;
wire data_mem_wr_en1_wire;
wire data_mem_wr_en2_wire;


//==================================================================
// INSTRUCTION MEMORY INSTANTIATION (10-bit wide)
//==================================================================
instruction_memory #(
    .DEPTH(MEM_DEPTH),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut_instr_mem (
    .clk(clk),
    // .rstn(rstn),  // Removed - not used in memory module
    .addr(instr_mem_addr_wire),
    .rd_en(instr_mem_rd_en_wire),
    .data_out(instr_mem_data_out_wire)
);

//==================================================================
// DATA MEMORY INSTANTIATION (8-bit wide)
//==================================================================
data_memory #(
    .DEPTH(MEM_DEPTH),
    .DATA_WIDTH(8),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut_data_mem (
    .clk(clk),
    // .rstn(rstn),  // Removed - not used in memory module
    .wr_addr1(data_mem_wr_addr1_wire),
    .wr_addr2(data_mem_wr_addr2_wire),
    .rd_addr1(data_mem_rd_addr1_wire),
    .rd_addr2(data_mem_rd_addr2_wire),
    .rd_en1(data_mem_rd_en1_wire),
    .rd_en2(data_mem_rd_en2_wire),
    .wr_en1(data_mem_wr_en1_wire),
    .wr_en2(data_mem_wr_en2_wire),
    .data_in1(data_mem_data_in1_wire),
    .data_in2(data_mem_data_in2_wire),
    .data_out1(data_mem_data_out1_wire),
    .data_out2(data_mem_data_out2_wire)
);

//==================================================================
// CPU INSTANTIATION
//==================================================================
cpu #(
    .DATA_WIDTH(DATA_WIDTH),
    .MEM_DEPTH(MEM_DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut_cpu (
    .clk(clk),
    .rstn(rstn),
    .start(start),
    .done(done),
    
    // Instruction memory interface
    .instr_mem_addr(instr_mem_addr_wire),
    .instr_mem_rd_en(instr_mem_rd_en_wire),
    .instr_mem_data_out(instr_mem_data_out_wire),
    
    // Data memory interface (dual-port read and write)
    .data_mem_rd_addr1(data_mem_rd_addr1_wire),
    .data_mem_rd_addr2(data_mem_rd_addr2_wire),
    .data_mem_wr_addr1(data_mem_wr_addr1_wire),
    .data_mem_wr_addr2(data_mem_wr_addr2_wire),
    .data_mem_rd_en1(data_mem_rd_en1_wire),
    .data_mem_rd_en2(data_mem_rd_en2_wire),
    .data_mem_wr_en1(data_mem_wr_en1_wire),
    .data_mem_wr_en2(data_mem_wr_en2_wire),
    .data_mem_data_in1(data_mem_data_in1_wire),
    .data_mem_data_in2(data_mem_data_in2_wire),
    .data_mem_data_out1(data_mem_data_out1_wire),
    .data_mem_data_out2(data_mem_data_out2_wire)
);

endmodule
