`timescale 1ns/1ps

module mem_writer_tb;

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 5;
  parameter MEM_SIZE = 32;
  parameter RESULT_WIDTH = 32;
  parameter PERIOD = 10; 
  parameter TEST_COUNT = 4;

  reg clk = 0;
  reg rst_n;
  reg start_writing;

  reg [RESULT_WIDTH-1:0] data_in;
  wire write_en;
  wire [ADDR_WIDTH-1:0] write_address;
  wire [DATA_WIDTH-1:0] data_out;


  integer i;

  mem_writer #(
    .DATA_WIDTH  (DATA_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .MEM_SIZE    (MEM_SIZE),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) u_mem_writer (
    .clk         (clk),
    .rst_n       (rst_n),
    .start_writing(start_writing),
    .data_in(data_in),
    .write_en(write_en),
    .write_address(write_address),
    .data_out(data_out)
  );

  always #(PERIOD/2) clk = ~clk;

  
  reg [DATA_WIDTH-1:0] golden_mem3 [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] expected_data;
  reg [ADDR_WIDTH-1:0] expected_address;
  
  
  function [DATA_WIDTH-1:0] calculate_expected_data;
    input [ADDR_WIDTH-1:0] addr;
    begin
      // Expected data should match what we input: (addr-1) * 10 + 5
      // because mem_writer increments address before writing
      calculate_expected_data = (addr - 1) * 10 + 5;
    end
  endfunction

  
  always @(posedge clk) begin
    if (rst_n && write_en) begin
      expected_data = calculate_expected_data(write_address);
      expected_address = write_address;
      
      if (data_out !== expected_data) begin
        $error("Time=%0t FAIL: mem_writer failed addr=%0d got=%0d expected=%0d", 
               $time, write_address, data_out, expected_data);
      end else begin
        $display("Time=%0t PASS: mem_writer passed addr=%0d data=%0d", 
                 $time, write_address, data_out);
      end
      
      golden_mem3[write_address] = data_out;
    end
  end

  
  initial begin
    rst_n = 0; start_writing = 0;
    data_in = 0;

    #10 rst_n = 1;

    for (i = 0; i < TEST_COUNT; i = i + 1) begin
      data_in = i * 10 + 5;  // Set data_in BEFORE start_writing
      #10 start_writing = 1;
      #10 start_writing = 0;
      #10; 
    end

    // Final verification - check all written data
    #20;
    $display("\n=== FINAL VERIFICATION ===");
    for (i = 1; i <= TEST_COUNT; i = i + 1) begin  // Start from 1, not 0
      expected_data = calculate_expected_data(i);
      if (golden_mem3[i] !== expected_data) begin
        $error("FINAL CHECK FAILED: addr=%0d got=%0d expected=%0d", 
               i, golden_mem3[i], expected_data);
      end else begin
        $display("FINAL CHECK PASSED: addr=%0d data=%0d", i, golden_mem3[i]);
      end
    end
    $display("=== VERIFICATION COMPLETE ===\n");

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start_writing=%b data_in=%0d write_en=%b write_address=%0d data_out=%0d expected_data=%0d",
      rst_n, start_writing, data_in, write_en, write_address, data_out, expected_data);
  end
endmodule
