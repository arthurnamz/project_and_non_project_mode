`timescale 1ns/1ps

module output_memory_wrapper_tb;

  parameter PERIOD = 4;
  parameter DATA_WIDTH = 8;
  parameter VECTOR_WIDTH = 4;
  parameter ADDR_WIDTH = 4;
  parameter MEM_SIZE = 64;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);

  reg clk = 0;
  reg rst_n;
  reg [RESULT_WIDTH-1:0] dot_product_result;
  reg result_valid;
  reg processing_done;
  reg read_en;
  reg [ADDR_WIDTH-1:0] read_addr;
  wire [DATA_WIDTH-1:0] result_out;
  wire writer_busy;
  wire writer_done;

  output_memory_wrapper #(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_output_wrapper (
    .clk(clk),
    .rst_n(rst_n),
    .dot_product_result(dot_product_result),
    .result_valid(result_valid),
    .processing_done(processing_done),
    .read_en(read_en),
    .read_addr(read_addr),
    .result_out(result_out),
    .writer_busy(writer_busy),
    .writer_done(writer_done)
  );

  always #(PERIOD/2) clk = ~clk;

  initial begin
    rst_n = 0;
    dot_product_result = 0;
    result_valid = 0;
    processing_done = 0;
    read_en = 0;
    read_addr = 0;

    #10 rst_n = 1;

    test_single_case;

    #(PERIOD * 20);
    $finish;
  end

  task test_single_case;
    begin
      #5;
      dot_product_result = 18'd123;
      result_valid = 1'b1;
      processing_done = 1'b0;
      #5;
      result_valid = 1'b0;
      wait(writer_busy);
      #5;
      processing_done = 1'b1;
      #5;
      processing_done = 1'b0;
      wait(writer_done);
      #5;
      read_en = 1'b1;
      read_addr = 0;
      #5;
      read_en = 1'b0;
      if (result_out == 8'd123) $display("  ✓ Single case PASSED: Expected 123, Got %d", result_out);
      else $display("  ✗ Single case FAILED: Expected 123, Got %d", result_out);
    end
  endtask

  initial begin
    $monitor($time,
      " rst_n=%b dot_product_result=%0d result_valid=%b processing_done=%b writer_busy=%b writer_done=%b read_en=%b read_addr=%0d result_out=%0d",
      rst_n, dot_product_result, result_valid, processing_done, writer_busy, writer_done, read_en, read_addr, result_out);
  end

endmodule
