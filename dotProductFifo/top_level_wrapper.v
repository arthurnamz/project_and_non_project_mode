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
    output [DATA_WIDTH-1:0] mem3_data_out 
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

// FIFO wires between mem_readers and dotProduct
wire fifo1_wr_en, fifo1_rd_en, fifo1_full, fifo1_empty;
wire fifo2_wr_en, fifo2_rd_en, fifo2_full, fifo2_empty;
wire [DATA_WIDTH-1:0] fifo1_data_out, fifo2_data_out;

// FIFO wires between dotProduct and mem_writer
wire fifo3_wr_en, fifo3_rd_en, fifo3_full, fifo3_empty;
wire [RESULT_WIDTH-1:0] fifo3_data_out;

// dotProduct wires
wire [RESULT_WIDTH-1:0] dot_product_result;
wire processing_done;

// mem_writer wires
wire mem_writer_write_en;
wire [ADDR_WIDTH-1:0] mem_writer_write_addr;
wire [DATA_WIDTH-1:0] mem_writer_data_out;


// mem 1 instance
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

// mem 2 instance
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

//mem1_reader instance
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

// mem2_reader 
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

// FIFO1 between mem1_reader and dotProduct
fifo #(
    .DEPTH(8),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(3)
) fifo1 (
    .clk(clk),
    .rstn(rst_n),
    .wr_en(fifo1_wr_en),
    .rd_en(fifo1_rd_en),
    .data_in(mem1_reader_output),
    .data_out(fifo1_data_out),
    .full(fifo1_full),
    .empty(fifo1_empty)
);

// FIFO2 between mem2_reader and dotProduct
fifo #(
    .DEPTH(8),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(3)
) fifo2 (
    .clk(clk),
    .rstn(rst_n),
    .wr_en(fifo2_wr_en),
    .rd_en(fifo2_rd_en),
    .data_in(mem2_reader_output),
    .data_out(fifo2_data_out),
    .full(fifo2_full),
    .empty(fifo2_empty)
);

//dotProduct instance
dotProduct#(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .VECTOR_ELEMENT_WIDTH(VECTOR_ELEMENT_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
) u_dotProduct (
    .clk(clk),
    .rst_n(rst_n),
    .mem1_input(fifo1_data_out),
    .mem2_input(fifo2_data_out),
    .start_processing(start_processing),
    .dot_product_result(dot_product_result),
    .processing_done(processing_done)
);

// FIFO3 between dotProduct and mem_writer
fifo #(
    .DEPTH(8),
    .DATA_WIDTH(RESULT_WIDTH),
    .ADDR_WIDTH(3)
) fifo3 (
    .clk(clk),
    .rstn(rst_n),
    .wr_en(fifo3_wr_en),
    .rd_en(fifo3_rd_en),
    .data_in(dot_product_result),
    .data_out(fifo3_data_out),
    .full(fifo3_full),
    .empty(fifo3_empty)
);

//mem_writer instance
mem_writer#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE),
    .RESULT_WIDTH(RESULT_WIDTH)
) u_mem_writer (
    .clk(clk),
    .rst_n(rst_n),
    .start_writing(fifo3_rd_en),
    .data_in(fifo3_data_out),
    .write_en(mem_writer_write_en),
    .write_address(mem_writer_write_addr),
    .data_out(mem_writer_data_out)
);

//mem3 instance
mem3#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_mem3 (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(mem_writer_write_en),
    .write_address(mem_writer_write_addr),
    .data_in(mem_writer_data_out),
    .read_en(mem3_read_en),
    .read_address(mem3_read_address),
    .data_out(mem3_data_out)
);

assign fifo1_wr_en = mem1_read_en && !fifo1_full;
assign fifo2_wr_en = mem2_read_en && !fifo2_full;
assign fifo3_wr_en = processing_done && !fifo3_full;
assign fifo1_rd_en = start_processing && !fifo1_empty;
assign fifo2_rd_en = start_processing && !fifo2_empty;
assign fifo3_rd_en = processing_done && !fifo3_empty;

endmodule





