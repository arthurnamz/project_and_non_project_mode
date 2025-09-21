`timescale 1ns/1ps

module dotProduct_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter ADDR_WIDTH   = 5;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);

  reg clk = 0;
  reg rst_n;
  reg [DATA_WIDTH-1:0] mem1_output;
  reg [DATA_WIDTH-1:0] mem2_output;
  reg data_valid;
  wire [RESULT_WIDTH-1:0] dot_product_result;
  wire result_valid;
  wire processing_done;

  dotProduct #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_dotProduct (
    .clk               (clk),
    .rst_n             (rst_n),
    .mem1_output       (mem1_output),
    .mem2_output       (mem2_output),
    .data_valid        (data_valid),
    .dot_product_result(dot_product_result),
    .result_valid      (result_valid),
    .processing_done   (processing_done)
  );

  always #(PERIOD/2) clk = ~clk;

  // Golden reference for dot product calculation
  reg [RESULT_WIDTH-1:0] golden_result;
  reg [DATA_WIDTH-1:0] test_vector_a [0:VECTOR_WIDTH-1];
  reg [DATA_WIDTH-1:0] test_vector_b [0:VECTOR_WIDTH-1];

  function [RESULT_WIDTH-1:0] calculate_dot_product;
    input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
    integer i;
    reg [RESULT_WIDTH-1:0] result;
    begin
      result = 0;
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        result = result + (vec_a[i] * vec_b[i]);
      end
      calculate_dot_product = result;
    end
  endfunction

  always @(posedge clk) begin
    if (rst_n && result_valid) begin
      if (dot_product_result !== golden_result) begin
        $error("[%0t] DOT PRODUCT failed dut=0x%0h exp=0x%0h",
               $time, dot_product_result, golden_result);
      end else begin
        $display("[%0t] DOT PRODUCT passed dut=0x%0h exp=0x%0h",
                 $time, dot_product_result, golden_result);
      end
    end
  end

  initial begin
    rst_n = 0; 
    mem1_output = 0; 
    mem2_output = 0; 
    data_valid = 0;

    #10 rst_n = 1;

    // Test Case 1: Simple vectors [1,2,3,4] and [1,1,1,1]
    test_vector_a[0] = 8'd1; test_vector_a[1] = 8'd2; test_vector_a[2] = 8'd3; test_vector_a[3] = 8'd4;
    test_vector_b[0] = 8'd1; test_vector_b[1] = 8'd1; test_vector_b[2] = 8'd1; test_vector_b[3] = 8'd1;
    golden_result = calculate_dot_product(test_vector_a, test_vector_b);
    $display("Test Case 1: Expected result = %0d", golden_result);

    // Feed vector elements to dot product
    #10 data_valid = 1; mem1_output = test_vector_a[0]; mem2_output = test_vector_b[0];
    #10 data_valid = 1; mem1_output = test_vector_a[1]; mem2_output = test_vector_b[1];
    #10 data_valid = 1; mem1_output = test_vector_a[2]; mem2_output = test_vector_b[2];
    #10 data_valid = 1; mem1_output = test_vector_a[3]; mem2_output = test_vector_b[3];
    #10 data_valid = 0;

    // Wait for result
    wait(result_valid);
    #10;

    // Test Case 2: Vectors [2,4,6,8] and [1,2,3,4]
    test_vector_a[0] = 8'd2; test_vector_a[1] = 8'd4; test_vector_a[2] = 8'd6; test_vector_a[3] = 8'd8;
    test_vector_b[0] = 8'd1; test_vector_b[1] = 8'd2; test_vector_b[2] = 8'd3; test_vector_b[3] = 8'd4;
    golden_result = calculate_dot_product(test_vector_a, test_vector_b);
    $display("Test Case 2: Expected result = %0d", golden_result);

    // Feed vector elements to dot product
    #20 data_valid = 1; mem1_output = test_vector_a[0]; mem2_output = test_vector_b[0];
    #10 data_valid = 1; mem1_output = test_vector_a[1]; mem2_output = test_vector_b[1];
    #10 data_valid = 1; mem1_output = test_vector_a[2]; mem2_output = test_vector_b[2];
    #10 data_valid = 1; mem1_output = test_vector_a[3]; mem2_output = test_vector_b[3];
    #10 data_valid = 0;

    // Wait for result
    wait(result_valid);
    #10;

    // Test Case 3: Vectors with zeros [0,5,0,3] and [2,0,4,1]
    test_vector_a[0] = 8'd0; test_vector_a[1] = 8'd5; test_vector_a[2] = 8'd0; test_vector_a[3] = 8'd3;
    test_vector_b[0] = 8'd2; test_vector_b[1] = 8'd0; test_vector_b[2] = 8'd4; test_vector_b[3] = 8'd1;
    golden_result = calculate_dot_product(test_vector_a, test_vector_b);
    $display("Test Case 3: Expected result = %0d", golden_result);

    // Feed vector elements to dot product
    #30 data_valid = 1; mem1_output = test_vector_a[0]; mem2_output = test_vector_b[0];
    #10 data_valid = 1; mem1_output = test_vector_a[1]; mem2_output = test_vector_b[1];
    #10 data_valid = 1; mem1_output = test_vector_a[2]; mem2_output = test_vector_b[2];
    #10 data_valid = 1; mem1_output = test_vector_a[3]; mem2_output = test_vector_b[3];
    #10 data_valid = 0;

    // Wait for result
    wait(result_valid);
    #10;

    // Test Case 4: Maximum values [255,255,255,255] and [1,1,1,1]
    test_vector_a[0] = 8'd255; test_vector_a[1] = 8'd255; test_vector_a[2] = 8'd255; test_vector_a[3] = 8'd255;
    test_vector_b[0] = 8'd1; test_vector_b[1] = 8'd1; test_vector_b[2] = 8'd1; test_vector_b[3] = 8'd1;
    golden_result = calculate_dot_product(test_vector_a, test_vector_b);
    $display("Test Case 4: Expected result = %0d", golden_result);

    // Feed vector elements to dot product
    #20 data_valid = 1; mem1_output = test_vector_a[0]; mem2_output = test_vector_b[0];
    #10 data_valid = 1; mem1_output = test_vector_a[1]; mem2_output = test_vector_b[1];
    #10 data_valid = 1; mem1_output = test_vector_a[2]; mem2_output = test_vector_b[2];
    #10 data_valid = 1; mem1_output = test_vector_a[3]; mem2_output = test_vector_b[3];
    #10 data_valid = 0;

    // Wait for result
    wait(result_valid);
    #10;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b data_valid=%b mem1_output=%0d mem2_output=%0d dot_product_result=%0d result_valid=%b processing_done=%b",
      rst_n, data_valid, mem1_output, mem2_output, dot_product_result, result_valid, processing_done);
  end
endmodule
