`timescale 1ns/1ps

module top_level_tb;

  parameter PERIOD = 4;
  parameter DATA_WIDTH = 8;
  parameter VECTOR_WIDTH = 4;
  parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH;
  parameter ADDR_WIDTH = 5;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);
  parameter MEM3_ADDR_WIDTH = 4;
  parameter MEM3_SIZE = 64;

  reg clk = 0;
  reg rst_n;
  reg write_en;
  reg [ADDR_WIDTH-1:0] write_addr;
  reg [DATA_WIDTH-1:0] data_a;
  reg [DATA_WIDTH-1:0] data_b;
  reg start_reading;
  wire reading_done;
  reg read_en;
  reg [MEM3_ADDR_WIDTH-1:0] read_addr;
  wire [RESULT_WIDTH-1:0] result_out;
  wire writer_busy;
  wire writer_done;

  top_level #(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH),
    .MEM3_ADDR_WIDTH(MEM3_ADDR_WIDTH),
    .MEM3_SIZE(MEM3_SIZE)
  ) u_top_level (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(write_en),
    .write_addr(write_addr),
    .data_a(data_a),
    .data_b(data_b),
    .start_reading(start_reading),
    .reading_done(reading_done),
    .read_en(read_en),
    .read_addr(read_addr),
    .result_out(result_out),
    .writer_busy(writer_busy),
    .writer_done(writer_done)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] test_vector_a_0;
  reg [DATA_WIDTH-1:0] test_vector_a_1;
  reg [DATA_WIDTH-1:0] test_vector_a_2;
  reg [DATA_WIDTH-1:0] test_vector_a_3;
  reg [DATA_WIDTH-1:0] test_vector_b_0;
  reg [DATA_WIDTH-1:0] test_vector_b_1;
  reg [DATA_WIDTH-1:0] test_vector_b_2;
  reg [DATA_WIDTH-1:0] test_vector_b_3;
  reg [RESULT_WIDTH-1:0] expected_result;

  function [RESULT_WIDTH-1:0] calculate_expected;
    input [DATA_WIDTH-1:0] a0, a1, a2, a3;
    input [DATA_WIDTH-1:0] b0, b1, b2, b3;
    reg [RESULT_WIDTH-1:0] result;
    begin
      result = 0;
      result = result + (a0 * b0);
      result = result + (a1 * b1);
      result = result + (a2 * b2);
      result = result + (a3 * b3);
      calculate_expected = result;
    end
  endfunction

  task write_test_vectors;
    input [DATA_WIDTH-1:0] a0, a1, a2, a3;
    input [DATA_WIDTH-1:0] b0, b1, b2, b3;
    begin
      $display("Writing test vectors...");
      
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 0;
      data_a = a0;
      data_b = b0;
      $display("  Element 0: A=%0d, B=%0d", a0, b0);
      @(posedge clk);
      write_en = 1'b0;
      
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 1;
      data_a = a1;
      data_b = b1;
      $display("  Element 1: A=%0d, B=%0d", a1, b1);
      @(posedge clk);
      write_en = 1'b0;
      
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 2;
      data_a = a2;
      data_b = b2;
      $display("  Element 2: A=%0d, B=%0d", a2, b2);
      @(posedge clk);
      write_en = 1'b0;
      
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 3;
      data_a = a3;
      data_b = b3;
      $display("  Element 3: A=%0d, B=%0d", a3, b3);
      @(posedge clk);
      write_en = 1'b0;
      
      $display("Vector writing complete.");
    end
  endtask

  task start_reading_and_processing;
    begin
      $display("Starting reading and processing...");
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;
      wait(reading_done);
      @(posedge clk);
      $display("Reading complete.");
      wait(writer_done);
      @(posedge clk);
      $display("Writing complete.");
    end
  endtask

  initial begin
    rst_n = 0; 
    write_en = 0;
    write_addr = 0;
    data_a = 0;
    data_b = 0;
    start_reading = 0;
    read_en = 0;
    read_addr = 0;

    #10 rst_n = 1;

    $display("\n--- Test Case 1: Simple Vectors ---");
    test_vector_a_0 = 8'd1; test_vector_a_1 = 8'd2; test_vector_a_2 = 8'd3; test_vector_a_3 = 8'd4;
    test_vector_b_0 = 8'd1; test_vector_b_1 = 8'd1; test_vector_b_2 = 8'd1; test_vector_b_3 = 8'd1;
    expected_result = calculate_expected(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    start_reading_and_processing;
    
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 0;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result) begin
      $display("✓ Test Case 1 PASSED: Expected %0d, Got %0d", expected_result, result_out);
    end else begin
      $display("✗ Test Case 1 FAILED: Expected %0d, Got %0d", expected_result, result_out);
    end

    #(PERIOD * 5);

    $display("\n--- Test Case 2: Progressive Vectors ---");
    test_vector_a_0 = 8'd2; test_vector_a_1 = 8'd4; test_vector_a_2 = 8'd6; test_vector_a_3 = 8'd8;
    test_vector_b_0 = 8'd1; test_vector_b_1 = 8'd2; test_vector_b_2 = 8'd3; test_vector_b_3 = 8'd4;
    expected_result = calculate_expected(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    start_reading_and_processing;
    
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 1;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result) begin
      $display("✓ Test Case 2 PASSED: Expected %0d, Got %0d", expected_result, result_out);
    end else begin
      $display("✗ Test Case 2 FAILED: Expected %0d, Got %0d", expected_result, result_out);
    end

    #(PERIOD * 5);

    $display("\n--- Test Case 3: Vectors with Zeros ---");
    test_vector_a_0 = 8'd0; test_vector_a_1 = 8'd5; test_vector_a_2 = 8'd0; test_vector_a_3 = 8'd3;
    test_vector_b_0 = 8'd2; test_vector_b_1 = 8'd0; test_vector_b_2 = 8'd4; test_vector_b_3 = 8'd1;
    expected_result = calculate_expected(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
                      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3);
    start_reading_and_processing;
    
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 2;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result) begin
      $display("✓ Test Case 3 PASSED: Expected %0d, Got %0d", expected_result, result_out);
    end else begin
      $display("✗ Test Case 3 FAILED: Expected %0d, Got %0d", expected_result, result_out);
    end

    $display("\n==========================================");
    $display("All hierarchical wrapper system tests completed!");
    $display("==========================================");
    #(PERIOD * 20);
    $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start_reading=%b reading_done=%b write_en=%b data_a=%0d data_b=%0d result_out=%0d writer_busy=%b writer_done=%b",
      rst_n, start_reading, reading_done, write_en, data_a, data_b, result_out, writer_busy, writer_done);
  end
endmodule
