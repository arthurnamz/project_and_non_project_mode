`timescale 1ns/1ps

module mem_reader_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter DEPTH        = VECTOR_WIDTH * DATA_WIDTH;
  parameter ADDR_WIDTH   = 5;

  reg                     clk = 0;
  reg                     rst_n;
  reg                     start_reading;
  wire                    reading_done;
  wire                    rd_en_mem1;
  wire                    rd_en_mem2;
  wire [ADDR_WIDTH-1:0]   rd_addr_mem1;
  wire [ADDR_WIDTH-1:0]   rd_addr_mem2;
  wire [DATA_WIDTH-1:0]   mem1_output;
  wire [DATA_WIDTH-1:0]   mem2_output;
  wire                    data_valid;
  wire [2:0]              element_count;

  // DUT
  mem_reader #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH),
    .DEPTH       (DEPTH),
    .ADDR_WIDTH  (ADDR_WIDTH)
  ) u_mem_reader (
    .clk         (clk),
    .rst_n       (rst_n),
    .start_reading(start_reading),
    .reading_done(reading_done),
    .rd_en_mem1  (rd_en_mem1),
    .rd_en_mem2  (rd_en_mem2),
    .rd_addr_mem1(rd_addr_mem1),
    .rd_addr_mem2(rd_addr_mem2),
    .mem1_output (mem1_output),
    .mem2_output (mem2_output),
    .data_valid  (data_valid),
    .element_count(element_count)
  );

  always #(PERIOD/2) clk = ~clk;

  // Model memory arrays for verification
  reg [DATA_WIDTH-1:0] model_mem1 [0:DEPTH-1];
  reg [DATA_WIDTH-1:0] model_mem2 [0:DEPTH-1];
  reg [DATA_WIDTH-1:0] model_mem1_out;
  reg [DATA_WIDTH-1:0] model_mem2_out;

  // Model the memory behavior
  always @(posedge clk) begin
    if (!rst_n) begin
      model_mem1_out <= 8'bz;
      model_mem2_out <= 8'bz;
    end else begin
      if (rd_en_mem1) model_mem1_out <= model_mem1[rd_addr_mem1];
      if (rd_en_mem2) model_mem2_out <= model_mem2[rd_addr_mem2];
    end
  end

  function integer same;
    input [DATA_WIDTH-1:0] a, b;
    begin same = (a === b); end
  endfunction

  // Verification logic
  always @(posedge clk) begin
    if (rst_n && data_valid) begin
      if (!same(mem1_output, model_mem1_out)) begin
        $error("[%0t] MEM1 failed addr=%0d dut=0x%0h exp=0x%0h",
               $time, rd_addr_mem1, mem1_output, model_mem1_out);
      end else begin
        $display("[%0t] MEM1 passed addr=%0d dut=0x%0h exp=0x%0h",
                 $time, rd_addr_mem1, mem1_output, model_mem1_out);
      end
      
      if (!same(mem2_output, model_mem2_out)) begin
        $error("[%0t] MEM2 failed addr=%0d dut=0x%0h exp=0x%0h",
               $time, rd_addr_mem2, mem2_output, model_mem2_out);
      end else begin
        $display("[%0t] MEM2 passed addr=%0d dut=0x%0h exp=0x%0h",
                 $time, rd_addr_mem2, mem2_output, model_mem2_out);
      end
    end
  end

  initial begin
    rst_n = 0; start_reading = 0;

    // Initialize model memories with test data
    model_mem1[0] = 8'h11; model_mem2[0] = 8'h21;
    model_mem1[1] = 8'h12; model_mem2[1] = 8'h22;
    model_mem1[2] = 8'h13; model_mem2[2] = 8'h23;
    model_mem1[3] = 8'h14; model_mem2[3] = 8'h24;
    model_mem1[4] = 8'h15; model_mem2[4] = 8'h25;
    model_mem1[5] = 8'h16; model_mem2[5] = 8'h26;
    model_mem1[6] = 8'h17; model_mem2[6] = 8'h27;
    model_mem1[7] = 8'h18; model_mem2[7] = 8'h28;
    model_mem1[8] = 8'h19; model_mem2[8] = 8'h29;
    model_mem1[9] = 8'h1A; model_mem2[9] = 8'h2A;
    model_mem1[10] = 8'h1B; model_mem2[10] = 8'h2B;
    model_mem1[11] = 8'h1C; model_mem2[11] = 8'h2C;
    model_mem1[12] = 8'h1D; model_mem2[12] = 8'h2D;
    model_mem1[13] = 8'h1E; model_mem2[13] = 8'h2E;
    model_mem1[14] = 8'h1F; model_mem2[14] = 8'h2F;
    model_mem1[15] = 8'h20; model_mem2[15] = 8'h30;

    #10 rst_n = 1;

    #10 start_reading = 1;
    #10 start_reading = 0;

    // Wait for reading to complete
    wait(reading_done);
    #10;

    // Test second read sequence
    #20 start_reading = 1;
    #10 start_reading = 0;

    // Wait for second reading to complete
    wait(reading_done);
    #10;

    // Test third read sequence with different timing
    #30 start_reading = 1;
    #10 start_reading = 0;

    // Wait for third reading to complete
    wait(reading_done);
    #10;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start_reading=%b reading_done=%b data_valid=%b rd_en_mem1=%b rd_en_mem2=%b rd_addr_mem1=%0d rd_addr_mem2=%0d mem1_output=0x%0h mem2_output=0x%0h element_count=%0d",
      rst_n, start_reading, reading_done, data_valid, rd_en_mem1, rd_en_mem2, rd_addr_mem1, rd_addr_mem2, mem1_output, mem2_output, element_count);
  end
endmodule
