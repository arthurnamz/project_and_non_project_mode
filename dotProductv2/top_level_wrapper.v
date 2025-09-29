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
    
    input write_en1,
    input [ADDR_WIDTH-1:0]write_address1,
    input [DATA_WIDTH-1:0]data_in1,

    input write_en2,
    input [ADDR_WIDTH-1:0]write_address2,
    input [DATA_WIDTH-1:0]data_in2,

    input read_en3,
    input [ADDR_WIDTH-1:0]read_address3,
    output reg [DATA_WIDTH-1:0] data_out3 
);

  // mem1 wires 
  wire read_en1;
  wire [ADDR_WIDTH-1:0]read_address1;
  wire [DATA_WIDTH-1:0] data_out1;

  // mem2 wires 
  wire read_en2;
  wire [ADDR_WIDTH-1:0]read_address2;
  wire [DATA_WIDTH-1:0] data_out2;


  // mem_reader wires output side of the reader

  wire [DATA_WIDTH-1:0] mem1_output;
  wire [DATA_WIDTH-1:0] mem2_output;

// dotProduct wires
wire [RESULT_WIDTH-1:0] dot_product_result;
wire processing_done;

// mem_writer wires
wire mem_writer_write_en;
wire [ADDR_WIDTH-1:0] mem_writer_write_addr;
wire [DATA_WIDTH-1:0] mem_writer_data_in;

// mem3 wires
wire [DATA_WIDTH-1:0] mem3_data_out;

assign mem3_data_out = data_out3;
// mem 1 dut
mem1#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem1 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(write_en1),
    .write_address(write_address1),
    .data_in(data_in1),
    .read_en(read_en1), 
    .read_address(read_address1),
    .data_out(data_out1)
);

// mem 2 dut
mem2#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem2 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(write_en2),
    .write_address(write_address2),
    .data_in(data_in2),
    .read_en(read_en2),
    .read_address(read_address2),
    .data_out(data_out2)
);

//mem_reader dut
mem_reader#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem_reader (
    .clk(clk),
    .rst_n(rst_n),
    .start_reading(start_processing),
    .read_en1(read_en1),
    .read_address1(read_address1),
    .read_en2(read_en2),
    .read_address2(read_address2),
    .mem1_input(data_out1),
    .mem2_input(data_out2),
    .mem1_output(mem1_output),
    .mem2_output(mem2_output)
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
    .mem1_input(mem1_output),
    .mem2_input(mem2_output),
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
    .read_en(read_en3),
    .read_address(read_address3),
    .data_out(mem3_data_out)
);

endmodule





