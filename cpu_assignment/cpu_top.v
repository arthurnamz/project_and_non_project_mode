// Top-level module that instantiates CPU, Instruction Memory, and Data Memory
// and connects them together

`timescale 1ns/1ps

module cpu_top#(
    parameter DATA_WIDTH = 10,
    parameter MEM_DEPTH = 8,
    parameter ADDR_WIDTH = 3,
    parameter MEM_DATA_WIDTH = 8
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

wire [MEM_DATA_WIDTH-1:0] data_mem_data_out_wire;
wire [ADDR_WIDTH-1:0] data_mem_addr_wire;
wire data_mem_rd_en_wire;
wire data_mem_wr_en_wire;
wire [MEM_DATA_WIDTH-1:0] data_mem_data_in_wire;


memory #(
    .DEPTH(MEM_DEPTH),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut_instr_mem (
    .clk(clk),
    .rstn(rstn),

    .wr_en(1'b0),
    .wr_address(instr_mem_addr_wire),
    .data_in({DATA_WIDTH{1'b0}}),
    
    .rd_en(instr_mem_rd_en_wire),
    .rd_address(instr_mem_addr_wire),
    .data_out(instr_mem_data_out_wire)
);


memory #(
    .DATA_WIDTH(MEM_DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_DEPTH)
) uut_data_mem (
    .clk(clk),
    .rstn(rstn),

    .wr_en(data_mem_wr_en_wire),
    .wr_address(data_mem_addr_wire),
    .DATA_WIDTH(MEM_DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut_data_mem (
    .clk,
    .rstn,

    .wr_en(data_mem_wr_en_wire),
    .wr_address(data_mem_addr_wire),
    .data_in(data_mem_data_in_wire),
    
    .rd_en(data_mem_rd_en_wire),
    .rd_address(data_mem_addr_wire),
    .data_out(data_mem_data_out_wire)
);


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
    
    // Data memory interface
    .data_mem_addr(data_mem_addr_wire),
    .data_mem_rd_en(data_mem_rd_en_wire),
    .data_mem_wr_en(data_mem_wr_en_wire),
    .data_mem_data_in(data_mem_data_in_wire),
    .data_mem_data_out(data_mem_data_out_wire)
);

endmodule
