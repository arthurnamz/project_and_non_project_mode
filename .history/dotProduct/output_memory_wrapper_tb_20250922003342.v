`timescale 1ns/1ps

module output_memory_wrapper_tb;

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
  reg read_en;
  reg [ADDR_WIDTH-1:0] read_addr;
  wire [DATA_WIDTH-1:0] result_out;
  wire writer_busy;
  wire writer_done;

  integer i;

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

    $display("\n=== Test Case 1: Basic Write and Read ===");
    test_basic_write_read;

    #(PERIOD * 5);

    $display("\n=== Test Case 2: Multiple Results ===");
    test_multiple_results;

    #(PERIOD * 5);

    $display("\n=== Test Case 3: Edge Cases ===");
    test_edge_cases;

    #(PERIOD * 5);

    $display("\n=== Test Case 4: Truncation Test ===");
    test_truncation;

    #(PERIOD * 5);

    $display("\n=== Test Case 5: Write Operations Only ===");
    test_write_operations;

    #(PERIOD * 5);

    $display("\n=== Test Case 6: Read Operations Only ===");
    test_read_operations;

    $display("\n==========================================");
    $display("All output memory wrapper tests completed!");
    $display("==========================================");
    #(PERIOD * 20);
    $finish;
  end

  // Test basic write and read functionality
  task test_basic_write_read;
    begin
      $display("Testing basic write and read operations...");
      
      // Write a result
      @(posedge clk);
      dot_product_result = 18'd42;  // Example result
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      // Wait for writer to be busy
      wait(writer_busy);
      $display("  Writer is busy, processing result...");
      
      // Complete processing
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      
      // Wait for writer to complete
      wait(writer_done);
      $display("  Writer completed, result stored.");
      
      // Read the result
      @(posedge clk);
      read_en = 1'b1;
      read_addr = 0;
      @(posedge clk);
      read_en = 1'b0;
      
      // Verify result (should be truncated to 8 bits)
      if (result_out == 8'd42) begin
        $display("  ✓ Basic write/read PASSED: Expected 42, Got %d", result_out);
      end else begin
        $display("  ✗ Basic write/read FAILED: Expected 42, Got %d", result_out);
      end
    end
  endtask

  // Test multiple results
  task test_multiple_results;
    begin
      $display("Testing multiple results...");
      
      // Write multiple results
      for (i = 0; i < 3; i = i + 1) begin
        @(posedge clk);
        dot_product_result = 18'd10 + i * 5;  // Results: 10, 15, 20
        result_valid = 1'b1;
        processing_done = 1'b0;
        @(posedge clk);
        result_valid = 1'b0;
        
        // Wait for writer to be busy
        wait(writer_busy);
        
        // Complete processing
        @(posedge clk);
        processing_done = 1'b1;
        @(posedge clk);
        processing_done = 1'b0;
        
        // Wait for writer to complete
        wait(writer_done);
        $display("  Result %0d written: %0d", i, 10 + i * 5);
      end
      
      // Read all results
      for (i = 0; i < 3; i = i + 1) begin
        @(posedge clk);
        read_en = 1'b1;
        read_addr = i;
        @(posedge clk);
        read_en = 1'b0;
        
        if (result_out == (10 + i * 5)) begin
          $display("  ✓ Result %0d PASSED: Expected %0d, Got %0d", i, 10 + i * 5, result_out);
        end else begin
          $display("  ✗ Result %0d FAILED: Expected %0d, Got %0d", i, 10 + i * 5, result_out);
        end
      end
    end
  endtask

  // Test edge cases
  task test_edge_cases;
    begin
      $display("Testing edge cases...");
      
      // Test zero result
      @(posedge clk);
      dot_product_result = 18'd0;
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      wait(writer_done);
      
      @(posedge clk);
      read_en = 1'b1;
      read_addr = 3;
      @(posedge clk);
      read_en = 1'b0;
      
      if (result_out == 8'd0) begin
        $display("  ✓ Zero result PASSED: Got %d", result_out);
      end else begin
        $display("  ✗ Zero result FAILED: Expected 0, Got %d", result_out);
      end
      
      // Test maximum 8-bit result
      @(posedge clk);
      dot_product_result = 18'd255;
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      wait(writer_done);
      
      @(posedge clk);
      read_en = 1'b1;
      read_addr = 4;
      @(posedge clk);
      read_en = 1'b0;
      
      if (result_out == 8'd255) begin
        $display("  ✓ Max 8-bit result PASSED: Got %d", result_out);
      end else begin
        $display("  ✗ Max 8-bit result FAILED: Expected 255, Got %d", result_out);
      end
    end
  endtask

  // Test truncation of wide results
  task test_truncation;
    begin
      $display("Testing truncation of wide results...");
      
      // Test result wider than 8 bits (should be truncated)
      @(posedge clk);
      dot_product_result = 18'd1024;  // Wide result
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      wait(writer_done);
      
      @(posedge clk);
      read_en = 1'b1;
      read_addr = 5;
      @(posedge clk);
      read_en = 1'b0;
      
      // Should be truncated to lower 8 bits: 1024 = 0x400 -> 0x00
      if (result_out == 8'd0) begin
        $display("  ✓ Truncation PASSED: Wide result %d truncated to %d", 1024, result_out);
      end else begin
        $display("  ✗ Truncation FAILED: Expected 0 (truncated), Got %d", result_out);
      end
      
      // Test another wide result
      @(posedge clk);
      dot_product_result = 18'd300;  // 300 = 0x12C -> should truncate to 0x2C = 44
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      wait(writer_done);
      
      @(posedge clk);
      read_en = 1'b1;
      read_addr = 6;
      @(posedge clk);
      read_en = 1'b0;
      
      if (result_out == 8'd44) begin
        $display("  ✓ Truncation PASSED: Wide result %d truncated to %d", 300, result_out);
      end else begin
        $display("  ✗ Truncation FAILED: Expected 44 (truncated), Got %d", result_out);
      end
    end
  endtask

  // Test write operations only
  task test_write_operations;
    begin
      $display("Testing write operations only...");
      
      // Test writing without reading
      @(posedge clk);
      dot_product_result = 18'd100;
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      $display("  Writer busy processing result 100...");
      
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      
      wait(writer_done);
      $display("  Write operation completed.");
      
      // Test another write
      @(posedge clk);
      dot_product_result = 18'd200;
      result_valid = 1'b1;
      processing_done = 1'b0;
      @(posedge clk);
      result_valid = 1'b0;
      
      wait(writer_busy);
      $display("  Writer busy processing result 200...");
      
      @(posedge clk);
      processing_done = 1'b1;
      @(posedge clk);
      processing_done = 1'b0;
      
      wait(writer_done);
      $display("  Second write operation completed.");
    end
  endtask

  // Test read operations only
  task test_read_operations;
    begin
      $display("Testing read operations only...");
      
      // Try to read from various addresses
      for (i = 0; i < 7; i = i + 1) begin
        @(posedge clk);
        read_en = 1'b1;
        read_addr = i;
        @(posedge clk);
        read_en = 1'b0;
        
        $display("  Read from address %0d: result = %0d", i, result_out);
      end
    end
  endtask

  initial begin
    $monitor($time,
      " rst_n=%b dot_product_result=%0d result_valid=%b processing_done=%b writer_busy=%b writer_done=%b read_en=%b read_addr=%0d result_out=%0d",
      rst_n, dot_product_result, result_valid, processing_done, writer_busy, writer_done, read_en, read_addr, result_out);
  end

endmodule
