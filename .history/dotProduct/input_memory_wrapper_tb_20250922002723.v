`timescale 1ns/1ps

module input_memory_wrapper_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter DEPTH        = VECTOR_WIDTH * DATA_WIDTH;
  parameter ADDR_WIDTH   = 5;

  reg clk = 0;
  reg rst_n;
  reg write_en;
  reg [ADDR_WIDTH-1:0] write_addr;
  reg [DATA_WIDTH-1:0] data_a;
  reg [DATA_WIDTH-1:0] data_b;
  reg start_reading;
  wire reading_done;
  wire [DATA_WIDTH-1:0] mem1_output;
  wire [DATA_WIDTH-1:0] mem2_output;
  wire data_valid;
  wire [2:0] element_count;

  input_memory_wrapper #(
    .DATA_WIDTH(DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) u_input_wrapper (
    .clk(clk),
    .rst_n(rst_n),
    .write_en(write_en),
    .write_addr(write_addr),
    .data_a(data_a),
    .data_b(data_b),
    .start_reading(start_reading),
    .reading_done(reading_done),
    .mem1_output(mem1_output),
    .mem2_output(mem2_output),
    .data_valid(data_valid),
    .element_count(element_count)
  );

  always #(PERIOD/2) clk = ~clk;

  initial begin
    rst_n = 0;
    write_en = 0;
    write_addr = 0;
    data_a = 0;
    data_b = 0;
    start_reading = 0;

    #10 rst_n = 1;

    // Test Case 1: Basic write and read operations
    $display("\n=== Test Case 1: Basic Write and Read ===");
    write_test_vectors;
    #(PERIOD * 2);
    start_reading_and_verify;

    #(PERIOD * 5);

    // Test Case 2: Write operations only
    test_write_operations;

    #(PERIOD * 5);

    // Test Case 3: Read operations only
    test_read_operations;

    #(PERIOD * 5);

    $display("\n==========================================");
    $display("All input memory wrapper tests completed!");
    $display("==========================================");
    #(PERIOD * 20);
    $finish;
  end

  task write_test_vectors;
    integer i;
    begin
      $display("Writing test vectors to input memory wrapper...");
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        @(posedge clk);
        write_en = 1'b1;
        write_addr = i[ADDR_WIDTH-1:0];
        data_a = vec_a[i];
        data_b = vec_b[i];
        expected_mem1[i] = vec_a[i];
        expected_mem2[i] = vec_b[i];
        $display("  Element %0d: A=%0d, B=%0d at addr=%0d", i, vec_a[i], vec_b[i], i);
        @(posedge clk);
        write_en = 1'b0;
      end
      $display("Vector writing complete.");
    end
  endtask

  // Task to start reading and verify output
  task start_reading_and_verify;
    input [DATA_WIDTH-1:0] expected_vec_a [0:VECTOR_WIDTH-1];
    input [DATA_WIDTH-1:0] expected_vec_b [0:VECTOR_WIDTH-1];
    integer i;
    reg [DATA_WIDTH-1:0] received_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] received_b [0:VECTOR_WIDTH-1];
    begin
      $display("Starting reading sequence...");
      
      // Start reading
      @(posedge clk);
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;
      
      // Collect output data during reading
      i = 0;
      while (!reading_done) begin
        @(posedge clk);
        if (data_valid) begin
          received_a[i] = mem1_output;
          received_b[i] = mem2_output;
          $display("  Read element %0d: A=%0d, B=%0d (element_count=%0d)", 
                   i, mem1_output, mem2_output, element_count);
          i = i + 1;
        end
      end
      
      // Wait for reading to complete
      wait(reading_done);
      @(posedge clk);
      $display("Reading sequence complete.");
      
      // Verify results
      $display("Verifying results...");
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        if (received_a[i] === expected_vec_a[i] && received_b[i] === expected_vec_b[i]) begin
          $display("  ✓ Element %0d PASSED: A=%0d, B=%0d", i, received_a[i], received_b[i]);
        end else begin
          $display("  ✗ Element %0d FAILED: A expected=%0d got=%0d, B expected=%0d got=%0d", 
                   i, expected_vec_a[i], received_a[i], expected_vec_b[i], received_b[i]);
        end
      end
    end
  endtask

  // Test write-only operations
  task test_write_operations;
    begin
      $display("\n--- Testing Write Operations ---");
      
      // Test single writes
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 0;
      data_a = 8'hAA;
      data_b = 8'hBB;
      expected_mem1[0] = 8'hAA;
      expected_mem2[0] = 8'hBB;
      @(posedge clk);
      write_en = 1'b0;
      $display("Write test: A=0x%h, B=0x%h at addr=0", 8'hAA, 8'hBB);
      
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 1;
      data_a = 8'hCC;
      data_b = 8'hDD;
      expected_mem1[1] = 8'hCC;
      expected_mem2[1] = 8'hDD;
      @(posedge clk);
      write_en = 1'b0;
      $display("Write test: A=0x%h, B=0x%h at addr=1", 8'hCC, 8'hDD);
      
      // Test write to same address (overwrite)
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 0;
      data_a = 8'hEE;
      data_b = 8'hFF;
      expected_mem1[0] = 8'hEE;
      expected_mem2[0] = 8'hFF;
      @(posedge clk);
      write_en = 1'b0;
      $display("Overwrite test: A=0x%h, B=0x%h at addr=0", 8'hEE, 8'hFF);
    end
  endtask

  // Test read-only operations
  task test_read_operations;
    begin
      $display("\n--- Testing Read Operations ---");
      
      // Start reading
      @(posedge clk);
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;
      
      // Monitor reading sequence
      $display("Monitoring read sequence...");
      while (!reading_done) begin
        @(posedge clk);
        if (data_valid) begin
          $display("  Read: A=0x%h, B=0x%h (element_count=%0d)", 
                   mem1_output, mem2_output, element_count);
        end
      end
      
      wait(reading_done);
      @(posedge clk);
      $display("Read sequence complete.");
    end
  endtask

  initial begin
    rst_n = 0; 
    write_en = 0;
    write_addr = 0;
    data_a = 0;
    data_b = 0;
    start_reading = 0;

    #10 rst_n = 1;

    // Test Case 1: Basic write and read operations
    $display("\n=== Test Case 1: Basic Write and Read ===");
    test_vector_a[0] = 8'd1; test_vector_a[1] = 8'd2; test_vector_a[2] = 8'd3; test_vector_a[3] = 8'd4;
    test_vector_b[0] = 8'd5; test_vector_b[1] = 8'd6; test_vector_b[2] = 8'd7; test_vector_b[3] = 8'd8;
    
    write_test_vectors(test_vector_a, test_vector_b);
    #(PERIOD * 2);
    start_reading_and_verify(test_vector_a, test_vector_b);

    #(PERIOD * 5);

    // Test Case 2: Write operations only
    test_write_operations;

    #(PERIOD * 5);

    // Test Case 3: Read operations only
    test_read_operations;

    #(PERIOD * 5);

    // Test Case 4: Different vector values
    $display("\n=== Test Case 4: Different Vector Values ===");
    test_vector_a[0] = 8'h10; test_vector_a[1] = 8'h20; test_vector_a[2] = 8'h30; test_vector_a[3] = 8'h40;
    test_vector_b[0] = 8'h50; test_vector_b[1] = 8'h60; test_vector_b[2] = 8'h70; test_vector_b[3] = 8'h80;
    
    write_test_vectors(test_vector_a, test_vector_b);
    #(PERIOD * 2);
    start_reading_and_verify(test_vector_a, test_vector_b);

    #(PERIOD * 5);

    // Test Case 5: Edge case - all zeros
    $display("\n=== Test Case 5: Edge Case - All Zeros ===");
    test_vector_a[0] = 8'd0; test_vector_a[1] = 8'd0; test_vector_a[2] = 8'd0; test_vector_a[3] = 8'd0;
    test_vector_b[0] = 8'd0; test_vector_b[1] = 8'd0; test_vector_b[2] = 8'd0; test_vector_b[3] = 8'd0;
    
    write_test_vectors(test_vector_a, test_vector_b);
    #(PERIOD * 2);
    start_reading_and_verify(test_vector_a, test_vector_b);

    #(PERIOD * 5);

    // Test Case 6: Edge case - maximum values
    $display("\n=== Test Case 6: Edge Case - Maximum Values ===");
    test_vector_a[0] = 8'hFF; test_vector_a[1] = 8'hFF; test_vector_a[2] = 8'hFF; test_vector_a[3] = 8'hFF;
    test_vector_b[0] = 8'hFF; test_vector_b[1] = 8'hFF; test_vector_b[2] = 8'hFF; test_vector_b[3] = 8'hFF;
    
    write_test_vectors(test_vector_a, test_vector_b);
    #(PERIOD * 2);
    start_reading_and_verify(test_vector_a, test_vector_b);

    $display("\n==========================================");
    $display("All input memory wrapper tests completed!");
    $display("==========================================");
    #(PERIOD * 20);
    $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b write_en=%b write_addr=%0d data_a=0x%h data_b=0x%h start_reading=%b reading_done=%b mem1_output=0x%h mem2_output=0x%h data_valid=%b element_count=%0d",
      rst_n, write_en, write_addr, data_a, data_b, start_reading, reading_done, mem1_output, mem2_output, data_valid, element_count);
  end

endmodule
