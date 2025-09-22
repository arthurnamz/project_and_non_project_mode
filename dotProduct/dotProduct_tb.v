`timescale 1ns/1ps

module dotProduct_tb;

  // Parameters
  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter ADDR_WIDTH   = 5;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);

  // Testbench signals
  reg clk = 0;
  reg rst_n;
  reg [DATA_WIDTH-1:0] mem1_output;
  reg [DATA_WIDTH-1:0] mem2_output;
  reg data_valid;
  wire [RESULT_WIDTH-1:0] dot_product_result;
  wire result_valid;
  wire processing_done;

  // DUT instantiation
  dotProduct #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_dotProduct (
    .clk               (clk),
    .rst_n             (rst_n),
    .mem1_input       (mem1_output),
    .mem2_input       (mem2_output),
    .data_valid        (data_valid),
    .dot_product_result(dot_product_result),
    .result_valid      (result_valid),
    .processing_done   (processing_done)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #(PERIOD/2) clk = ~clk;
  end

  // Test vectors and expected results
  reg [RESULT_WIDTH-1:0] golden_result;
  reg [DATA_WIDTH-1:0] test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3;
  reg [DATA_WIDTH-1:0] test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3;

  // Calculate expected dot product
  function [RESULT_WIDTH-1:0] calculate_dot_product;
    input [DATA_WIDTH-1:0] a0, a1, a2, a3;
    input [DATA_WIDTH-1:0] b0, b1, b2, b3;
    reg [RESULT_WIDTH-1:0] result;
    begin
      result = (a0 * b0) + (a1 * b1) + (a2 * b2) + (a3 * b3);
      calculate_dot_product = result;
    end
  endfunction

  // Result checking
  always @(posedge clk) begin
    if (rst_n && result_valid) begin
      if (dot_product_result !== golden_result) begin
        $error("Time=%0t ERROR: Dot product mismatch. Got %0d, Expected %0d", 
               $time, dot_product_result, golden_result);
      end else begin
        $display("Time=%0t SUCCESS: Dot product match. Result=%0d", 
                 $time, dot_product_result);
      end
    end
  end

  // Test stimulus
  task send_vector;
    input [DATA_WIDTH-1:0] a0, a1, a2, a3;
    input [DATA_WIDTH-1:0] b0, b1, b2, b3;
    begin
      data_valid = 1;
      mem1_output = a0; mem2_output = b0; #PERIOD;
      mem1_output = a1; mem2_output = b1; #PERIOD;
      mem1_output = a2; mem2_output = b2; #PERIOD;
      mem1_output = a3; mem2_output = b3; #PERIOD;
      data_valid = 0;
      #PERIOD;
    end
  endtask

  // Main test sequence
  initial begin
    // Initialize
    rst_n = 0;
    mem1_output = 0;
    mem2_output = 0;
    data_valid = 0;

    // Wait 100ns and release reset
    #100 rst_n = 1;
    #PERIOD;

    // Test Case 1: Simple test with [1,2,3,4] * [1,1,1,1]
    test_vector_a_0 = 8'd1; test_vector_a_1 = 8'd2; 
    test_vector_a_2 = 8'd3; test_vector_a_3 = 8'd4;
    test_vector_b_0 = 8'd1; test_vector_b_1 = 8'd1;
    test_vector_b_2 = 8'd1; test_vector_b_3 = 8'd1;
    golden_result = calculate_dot_product(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    $display("\nTest Case 1: [1,2,3,4] * [1,1,1,1]");
    send_vector(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    #(PERIOD*5);

    // Test Case 2: Larger numbers [2,4,6,8] * [1,2,3,4]
    test_vector_a_0 = 8'd2; test_vector_a_1 = 8'd4;
    test_vector_a_2 = 8'd6; test_vector_a_3 = 8'd8;
    test_vector_b_0 = 8'd1; test_vector_b_1 = 8'd2;
    test_vector_b_2 = 8'd3; test_vector_b_3 = 8'd4;
    golden_result = calculate_dot_product(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    $display("\nTest Case 2: [2,4,6,8] * [1,2,3,4]");
    send_vector(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    #(PERIOD*5);

    // Test Case 3: Zero elements [0,5,0,3] * [2,0,4,1]
    test_vector_a_0 = 8'd0; test_vector_a_1 = 8'd5;
    test_vector_a_2 = 8'd0; test_vector_a_3 = 8'd3;
    test_vector_b_0 = 8'd2; test_vector_b_1 = 8'd0;
    test_vector_b_2 = 8'd4; test_vector_b_3 = 8'd1;
    golden_result = calculate_dot_product(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    $display("\nTest Case 3: [0,5,0,3] * [2,0,4,1]");
    send_vector(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    #(PERIOD*5);

    // Test Case 4: Maximum values [255,255,255,255] * [1,1,1,1]
    test_vector_a_0 = 8'd255; test_vector_a_1 = 8'd255;
    test_vector_a_2 = 8'd255; test_vector_a_3 = 8'd255;
    test_vector_b_0 = 8'd1; test_vector_b_1 = 8'd1;
    test_vector_b_2 = 8'd1; test_vector_b_3 = 8'd1;
    golden_result = calculate_dot_product(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    $display("\nTest Case 4: [255,255,255,255] * [1,1,1,1]");
    send_vector(
      test_vector_a_0, test_vector_a_1, test_vector_a_2, test_vector_a_3,
      test_vector_b_0, test_vector_b_1, test_vector_b_2, test_vector_b_3
    );
    #(PERIOD*5);

    // End simulation
    #100 $finish;
  end

  // Waveform monitoring
  initial begin
    $monitor("Time=%0t rst_n=%b data_valid=%b mem1=%0d mem2=%0d result=%0d valid=%b done=%b",
             $time, rst_n, data_valid, mem1_output, mem2_output, 
             dot_product_result, result_valid, processing_done);
  end

endmodule
