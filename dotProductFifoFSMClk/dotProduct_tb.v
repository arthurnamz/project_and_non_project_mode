`timescale 1ns/1ps

module dotProduct_tb;

  parameter PERIOD       = 10;
  parameter DATA_WIDTH   = 32;
  parameter VECTOR_WIDTH = 4;
  parameter VECTOR_ELEMENT_WIDTH = 8;
  parameter ADDR_WIDTH   = 5;
  parameter RESULT_WIDTH = 2*VECTOR_ELEMENT_WIDTH;
  parameter TEST_COUNT   = 10;

  
  reg clk = 0;
  reg rst_n;
  reg start_processing;
  reg [DATA_WIDTH-1:0] mem1_input;
  reg [DATA_WIDTH-1:0] mem2_input;
  wire [RESULT_WIDTH-1:0] dot_product_result;
  wire processing_done;


  integer i;

  reg [VECTOR_ELEMENT_WIDTH-1:0] element_a, element_b, element_c, element_d;



  dotProduct #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .VECTOR_ELEMENT_WIDTH(VECTOR_ELEMENT_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_dotProduct (
    .clk               (clk),
    .rst_n             (rst_n),
    .mem1_input        (mem1_input),
    .mem2_input        (mem2_input),
    .start_processing  (start_processing),
    .dot_product_result(dot_product_result),
    .processing_done   (processing_done)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [RESULT_WIDTH-1:0] golden_result;
  reg [RESULT_WIDTH-1:0] stored_golden_result;
  
  function [RESULT_WIDTH-1:0] calculate_dot_product;
    input [DATA_WIDTH-1:0] vector_a;
    input [DATA_WIDTH-1:0] vector_b;
    reg [VECTOR_ELEMENT_WIDTH-1:0] a0, a1, a2, a3;
    reg [VECTOR_ELEMENT_WIDTH-1:0] b0, b1, b2, b3;
    reg [RESULT_WIDTH-1:0] result;
    begin
      // Extract elements in descending order to match dotProduct module
      a0 = vector_a[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 31:24
      a1 = vector_a[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 23:16
      a2 = vector_a[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 15:8
      a3 = vector_a[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 7:0
      
      b0 = vector_b[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 31:24
      b1 = vector_b[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 23:16
      b2 = vector_b[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 15:8
      b3 = vector_b[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 7:0
      
      result = (a0 * b0) + (a1 * b1) + (a2 * b2) + (a3 * b3);
      calculate_dot_product = result;
    end
  endfunction

  always @(posedge clk) begin
    if (rst_n && processing_done) begin
      if (dot_product_result !== stored_golden_result) begin
        $error("Time=%0t FAIL: Dot product mismatch. Got %0d, Expected %0d", 
               $time, dot_product_result, stored_golden_result);
      end else begin
        $display("Time=%0t PASS: Dot product match. Result=%0d, Expected %0d", 
                 $time, dot_product_result, stored_golden_result);
      end
    end
  end
  
  initial begin
    rst_n = 0; start_processing = 0;
    mem1_input = 0;
    mem2_input = 0;

    #10 rst_n = 1;

    for (i = 0; i < TEST_COUNT; i = i + 1) begin
      // Set elements directly
      element_a = 8'd1+i;
      element_b = 8'd2+i;
      element_c = 8'd3+i;
      element_d = 8'd4+i;
      
      mem1_input = {element_a, element_b, element_c, element_d};
      mem2_input = {element_a, element_b, element_c, element_d};
      golden_result = calculate_dot_product(mem1_input, mem2_input);
      
      // Store the expected result before starting processing
      stored_golden_result = golden_result;
      
      #10 start_processing = 1;
      #10 start_processing = 0;
      
      // Wait a few cycles for processing to complete
      #30;
    end

    #100 $finish;
  end

  initial begin
    $monitor("Time=%0t rst_n=%b start_processing=%b mem1_input=%0d mem2_input=%0d result=%0d done=%b",
             $time, rst_n, start_processing, mem1_input, mem2_input, 
             dot_product_result, processing_done);
  end

endmodule
