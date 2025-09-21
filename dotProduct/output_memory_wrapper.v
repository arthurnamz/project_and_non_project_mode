`timescale 1ns / 1ps

module output_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)
)(
    input clk,
    input rst_n,
    input [RESULT_WIDTH-1:0] dot_product_result,
    input result_valid,
    input processing_done,
    input read_en,
    input [ADDR_WIDTH-1:0] read_addr,
    output wire [DATA_WIDTH-1:0] result_out,
    output wire writer_busy,
    output wire writer_done
);

    wire mem3_write_en;
    wire [ADDR_WIDTH-1:0] mem3_write_addr;
    wire [DATA_WIDTH-1:0] mem3_write_data;

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
        .write_en(mem3_write_en),
        .write_address(mem3_write_addr),
        .data_in(mem3_write_data),
        .writer_busy(writer_busy),
        .writer_done(writer_done),
        .result_count()
    );

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
