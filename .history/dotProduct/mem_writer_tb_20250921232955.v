`timescale 1ns/1ps

module mem_writer_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter ADDR_WIDTH   = 4;
  parameter MEM_SIZE     = 64;
  parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);

  reg clk = 0;
  reg rst_n;
  reg [RESULT_WIDTH-1:0] dot_product_result;
  reg result_valid;
  reg processing_done;
  wire write_en;
  wire [ADDR_WIDTH-1:0] write_address;
  wire [DATA_WIDTH-1:0] data_in;
  wire writer_busy;
  wire writer_done;
  wire [2:0] result_count;

  mem_writer #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .MEM_SIZE    (MEM_SIZE),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_mem_writer (
    .clk               (clk),
    .rst_n             (rst_n),
    .dot_product_result(dot_product_result),
    .result_valid      (result_valid),
    .processing_done   (processing_done),
    .write_en          (write_en),
    .write_address     (write_address),
    .data_in           (data_in),
    .writer_busy       (writer_busy),
    .writer_done       (writer_done),
    .result_count      (result_count)
  );

  always #(PERIOD/2) clk = ~clk;

  // Golden reference for verification
  reg [DATA_WIDTH-1:0] golden_mem3 [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] expected_data;

  always @(posedge clk) begin
    if (rst_n && write_en) begin
      expected_data = dot_product_result[DATA_WIDTH-1:0]; // Truncated result
      if (data_in !== expected_data) begin
        $error("[%0t] MEM_WRITER failed addr=%0d dut=0x%0h exp=0x%0h",
               $time, write_address, data_in, expected_data);
      end else begin
        $display("[%0t] MEM_WRITER passed addr=%0d dut=0x%0h exp=0x%0h",
                 $time, write_address, data_in, expected_data);
      end
      golden_mem3[write_address] = data_in;
    end
  end

  initial begin
    rst_n = 0; 
    dot_product_result = 0; 
    result_valid = 0; 
    processing_done = 0;

    #10 rst_n = 1;

    // Test Case 1: Simple result (10)
    dot_product_result = 18'd10; // 18-bit result, will be truncated to 8-bit
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    // Test Case 2: Larger result (60)
    dot_product_result = 18'd60;
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    // Test Case 3: Result with zeros (3)
    dot_product_result = 18'd3;
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    // Test Case 4: Maximum 8-bit value (255)
    dot_product_result = 18'd255;
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    // Test Case 5: Large result that will be truncated (1020 -> 252)
    dot_product_result = 18'd1020; // Will be truncated to 8'hFC (252)
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    // Test Case 6: Very large result (65535 -> 255)
    dot_product_result = 18'd65535; // Will be truncated to 8'hFF (255)
    result_valid = 1;
    #10 result_valid = 0;
    #10 processing_done = 1;
    #10 processing_done = 0;
    wait(writer_done);
    #10;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b result_valid=%b processing_done=%b dot_product_result=%0d write_en=%b write_address=%0d data_in=0x%0h writer_busy=%b writer_done=%b result_count=%0d",
      rst_n, result_valid, processing_done, dot_product_result, write_en, write_address, data_in, writer_busy, writer_done, result_count);
  end
endmodule
