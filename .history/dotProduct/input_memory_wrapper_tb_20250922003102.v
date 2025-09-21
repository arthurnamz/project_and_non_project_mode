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

  integer i;

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

    $display("\n=== Test Case 1: Basic Write and Read ===");
    write_test_vectors;
    #(PERIOD * 2);
    start_reading_and_verify;

    #(PERIOD * 5);

    test_write_operations;

    #(PERIOD * 5);

    test_read_operations;

    #(PERIOD * 5);

    $display("\n==========================================");
    $display("All input memory wrapper tests completed!");
    $display("==========================================");
    #(PERIOD * 20);
    $finish;
  end

  task write_test_vectors;
    begin
      $display("Writing test vectors to input memory wrapper...");
      for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
        @(posedge clk);
        write_en = 1'b1;
        write_addr = i[ADDR_WIDTH-1:0];
        data_a = i;
        data_b = VECTOR_WIDTH - i;
        @(posedge clk);
        write_en = 1'b0;
      end
      $display("Vector writing complete.");
    end
  endtask

  task start_reading_and_verify;
    begin
      $display("Starting reading sequence...");
      @(posedge clk);
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;

      i = 0;
      while (!reading_done) begin
        @(posedge clk);
        if (data_valid) begin
          $display("  Read element %0d: A=%0d, B=%0d (element_count=%0d)", 
                   i, mem1_output, mem2_output, element_count);
          i = i + 1;
        end
      end

      wait(reading_done);
      @(posedge clk);
      $display("Reading sequence complete.");
    end
  endtask

  task test_write_operations;
    begin
      $display("\n--- Testing Write Operations ---");
      @(posedge clk);
      write_en = 1'b1;
      write_addr = 0;
      data_a = 8'hAA;
      data_b = 8'hBB;
      @(posedge clk);
      write_en = 1'b0;
      $display("Write test: A=0x%h, B=0x%h at addr=0", 8'hAA, 8'hBB);

      @(posedge clk);
      write_en = 1'b1;
      write_addr = 1;
      data_a = 8'hCC;
      data_b = 8'hDD;
      @(posedge clk);
      write_en = 1'b0;
      $display("Write test: A=0x%h, B=0x%h at addr=1", 8'hCC, 8'hDD);

      @(posedge clk);
      write_en = 1'b1;
      write_addr = 0;
      data_a = 8'hEE;
      data_b = 8'hFF;
      @(posedge clk);
      write_en = 1'b0;
      $display("Overwrite test: A=0x%h, B=0x%h at addr=0", 8'hEE, 8'hFF);
    end
  endtask

  task test_read_operations;
    begin
      $display("\n--- Testing Read Operations ---");
      @(posedge clk);
      start_reading = 1'b1;
      @(posedge clk);
      start_reading = 1'b0;

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
    $monitor($time,
      " rst_n=%b write_en=%b write_addr=%0d data_a=0x%h data_b=0x%h start_reading=%b reading_done=%b mem1_output=0x%h mem2_output=0x%h data_valid=%b element_count=%0d",
      rst_n, write_en, write_addr, data_a, data_b, start_reading, reading_done, mem1_output, mem2_output, data_valid, element_count);
  end

endmodule
