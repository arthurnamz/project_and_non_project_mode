`timescale 1ns / 1ps
(* dont_touch="true" *)
module top_level_wrapper #(
    parameter DATA_WIDTH = 32,
    parameter VECTOR_WIDTH = 4,
    parameter VECTOR_ELEMENT_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter MEM_SIZE = 32,
    parameter RESULT_WIDTH = 2*VECTOR_ELEMENT_WIDTH
)(
    input clk,
    input rst_n,
    
    input start_processing,
    
    input mem1_write_en,
    input [ADDR_WIDTH-1:0]mem1_write_address,
    input [DATA_WIDTH-1:0]mem1_data_in,

    input mem2_write_en,
    input [ADDR_WIDTH-1:0]mem2_write_address,
    input [DATA_WIDTH-1:0]mem2_data_in,

    input mem3_read_en,
    input [ADDR_WIDTH-1:0]mem3_read_address,
    output reg [DATA_WIDTH-1:0] mem3_data_out 
);

  // mem1 wires 
  wire mem1_read_en;
  wire [ADDR_WIDTH-1:0]mem1_read_address;
  wire [DATA_WIDTH-1:0] mem1_data_out;

  // mem2 wires 
  wire mem2_read_en;
  wire [ADDR_WIDTH-1:0]mem2_read_address;
  wire [DATA_WIDTH-1:0] mem2_data_out;


  // mem_reader wires output side of the reader

  wire [DATA_WIDTH-1:0] mem1_reader_output;
  wire [DATA_WIDTH-1:0] mem2_reader_output;

// dotProduct wires
wire [RESULT_WIDTH-1:0] dot_product_result;
wire processing_done;

// mem_writer wires
wire mem_writer_write_en;
wire [ADDR_WIDTH-1:0] mem_writer_write_addr;
wire [DATA_WIDTH-1:0] mem_writer_data_in;

// mem3 wires
wire [DATA_WIDTH-1:0] mem3_data_out_internal;

// assign mem3_data_out = mem3_data_out_internal;

// mem 1 dut
mem1#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem1 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(mem1_write_en),
    .write_address(mem1_write_address),
    .data_in(mem1_data_in),
    .read_en(mem1_read_en), 
    .read_address(mem1_read_address),
    .data_out(mem1_data_out)
);

// mem 2 dut
mem2#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem2 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(mem2_write_en),
    .write_address(mem2_write_address),
    .data_in(mem2_data_in),
    .read_en(mem2_read_en),
    .read_address(mem2_read_address),
    .data_out(mem2_data_out)
);

//mem_reader dut
mem_reader#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) mem1_reader(
    .clk(clk),
    .rst_n(rst_n),
    .start_reading(start_processing),
    .read_en(mem1_read_en),
    .read_address(mem1_read_address),
    .data_in(mem1_data_out),
    .data_out(mem1_reader_output)
);

mem_reader#(

    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) mem2_reader(
    .clk(clk),
    .rst_n(rst_n),
    .start_reading(start_processing),
    .read_en(mem2_read_en),
    .read_address(mem2_read_address),
    .data_in(mem2_data_out),
    .data_out(mem2_reader_output)
);

//dotProduct dut
dotProduct#(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .VECTOR_ELEMENT_WIDTH(VECTOR_ELEMENT_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
) u_dotProduct (
    .clk(clk),
    .rst_n(rst_n),
    .mem1_input(mem1_reader_output),
    .mem2_input(mem2_reader_output),
    .start_processing(start_processing),
    .dot_product_result(dot_product_result),
    .processing_done(processing_done)
);

//mem_writer dut
mem_writer#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE),
    .RESULT_WIDTH(RESULT_WIDTH)
) u_mem_writer (
    .clk(clk),
    .rst_n(rst_n),
    .start_writing(processing_done),
    .dot_product_result(dot_product_result),
    .write_en(mem_writer_write_en),
    .write_address(mem_writer_write_addr),
    .data_in(mem_writer_data_in)
);

//mem3 dut
mem3#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem3 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(mem_writer_write_en),
    .write_address(mem_writer_write_addr),
    .data_in(mem_writer_data_in),
    .read_en(mem3_read_en),
    .read_address(mem3_read_address),
    .data_out(mem3_data_out_internal)
);

endmodule





