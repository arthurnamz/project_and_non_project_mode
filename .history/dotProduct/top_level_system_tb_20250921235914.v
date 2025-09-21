`timescale 1ns/1ps

module top_level_system_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter DEPTH        = VECTOR_WIDTH * DATA_WIDTH;
  parameter ADDR_WIDTH   = 5;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);
  parameter MEM3_ADDR_WIDTH = 4;
  parameter MEM3_SIZE    = 64;

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
  wire [DATA_WIDTH-1:0] result_out;
  wire writer_busy;
  wire writer_done;

  top_level_system #(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH),
    .MEM3_ADDR_WIDTH(MEM3_ADDR_WIDTH),
    .MEM3_SIZE(MEM3_SIZE)
  ) u_top_system (
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

  // Test vectors
  reg [DATA_WIDTH-1:0] test_vector_a [0:VECTOR_WIDTH-1];
  reg [DATA_WIDTH-1:0] test_vector_b [0:VECTOR_WIDTH-1];
  reg [RESULT_WIDTH-1:0] expected_result;

  // Golden reference calculation
  function [RESULT_WIDTH-1:0] calculate_expected;
    input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
    integer i;
    reg [RESULT_WIDTH-1:0] result;
    begin
      result = 0;
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        result = result + (vec_a[i] * vec_b[i]);
      end
      calculate_expected = result;
    end
  endfunction

  // Task to write test vectors
  task write_test_vectors;
    input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
    integer i;
    begin
      $display("Writing test vectors...");
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        @(posedge clk);
        write_en = 1'b1;
        write_addr = i[ADDR_WIDTH-1:0];
        data_a = vec_a[i];
        data_b = vec_b[i];
        $display("  Element %0d: A=%0d, B=%0d", i, vec_a[i], vec_b[i]);
        @(posedge clk);
        write_en = 1'b0;
      end
      $display("Vector writing complete.");
    end
  endtask

  // Task to start reading and processing
  task start_reading_and_processing;
    begin
      $display("Starting reading and processing...");
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;
      
      // Wait for reading to complete
      wait(reading_done);
      @(posedge clk);
      $display("Reading complete.");
      
      // Wait for writing to complete
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

    // Test Case 1: Simple vectors [1,2,3,4] and [1,1,1,1]
    $display("\n--- Test Case 1: Simple Vectors ---");
    test_vector_a[0] = 8'd1; test_vector_a[1] = 8'd2; test_vector_a[2] = 8'd3; test_vector_a[3] = 8'd4;
    test_vector_b[0] = 8'd1; test_vector_b[1] = 8'd1; test_vector_b[2] = 8'd1; test_vector_b[3] = 8'd1;
    expected_result = calculate_expected(test_vector_a, test_vector_b);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a, test_vector_b);
    start_reading_and_processing;
    
    // Read result
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 0;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result[DATA_WIDTH-1:0]) begin
      $display("✓ Test Case 1 PASSED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
    end else begin
      $display("✗ Test Case 1 FAILED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
    end

    #(PERIOD * 5);

    // Test Case 2: Vectors [2,4,6,8] and [1,2,3,4]
    $display("\n--- Test Case 2: Progressive Vectors ---");
    test_vector_a[0] = 8'd2; test_vector_a[1] = 8'd4; test_vector_a[2] = 8'd6; test_vector_a[3] = 8'd8;
    test_vector_b[0] = 8'd1; test_vector_b[1] = 8'd2; test_vector_b[2] = 8'd3; test_vector_b[3] = 8'd4;
    expected_result = calculate_expected(test_vector_a, test_vector_b);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a, test_vector_b);
    start_reading_and_processing;
    
    // Read result
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 1;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result[DATA_WIDTH-1:0]) begin
      $display("✓ Test Case 2 PASSED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
    end else begin
      $display("✗ Test Case 2 FAILED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
    end

    #(PERIOD * 5);

    // Test Case 3: Vectors with zeros [0,5,0,3] and [2,0,4,1]
    $display("\n--- Test Case 3: Vectors with Zeros ---");
    test_vector_a[0] = 8'd0; test_vector_a[1] = 8'd5; test_vector_a[2] = 8'd0; test_vector_a[3] = 8'd3;
    test_vector_b[0] = 8'd2; test_vector_b[1] = 8'd0; test_vector_b[2] = 8'd4; test_vector_b[3] = 8'd1;
    expected_result = calculate_expected(test_vector_a, test_vector_b);
    $display("Expected result: %0d", expected_result);
    
    write_test_vectors(test_vector_a, test_vector_b);
    start_reading_and_processing;
    
    // Read result
    @(posedge clk);
    read_en = 1'b1;
    read_addr = 2;
    @(posedge clk);
    read_en = 1'b0;
    
    if (result_out == expected_result[DATA_WIDTH-1:0]) begin
      $display("✓ Test Case 3 PASSED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
    end else begin
      $display("✗ Test Case 3 FAILED: Expected %0d, Got %0d", expected_result[DATA_WIDTH-1:0], result_out);
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
