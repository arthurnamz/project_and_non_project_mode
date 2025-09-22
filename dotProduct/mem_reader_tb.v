`timescale 1ns/1ps

module mem_reader_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter VECTOR_WIDTH = 4;
  parameter DEPTH        = VECTOR_WIDTH * DATA_WIDTH;
  parameter ADDR_WIDTH   = 5;

  reg clk = 0;
  reg rst_n;
  reg start_reading;
  wire reading_done;
  wire rd_en_mem1;
  wire rd_en_mem2;
  wire [ADDR_WIDTH-1:0] rd_addr_mem1;
  wire [ADDR_WIDTH-1:0] rd_addr_mem2;
  wire [DATA_WIDTH-1:0] mem1_output;
  wire [DATA_WIDTH-1:0] mem2_output;
  wire data_valid;
  wire [2:0] element_count;
  wire [ADDR_WIDTH-1:0] check_addr_mem1;
  wire [ADDR_WIDTH-1:0] check_addr_mem2;
  wire check_en_mem1;
  wire check_en_mem2;

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
    .element_count(element_count),
    .check_addr_mem1(check_addr_mem1),
    .check_addr_mem2(check_addr_mem2),
    .check_en_mem1(check_en_mem1),
    .check_en_mem2(check_en_mem2)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] golden_mem1 [0:DEPTH-1];
  reg [DATA_WIDTH-1:0] golden_mem2 [0:DEPTH-1];

  always @(posedge clk) begin
    if (rst_n && data_valid && !reading_done) begin
      if (check_en_mem1 && mem1_output !== golden_mem1[check_addr_mem1]) begin
        $error("[%0t] MEM1 failed addr=%0d dut=0x%0h exp=0x%0h",
               $time, check_addr_mem1, mem1_output, golden_mem1[check_addr_mem1]);
      end else if (check_en_mem1) begin
        $display("[%0t] MEM1 passed addr=%0d dut=0x%0h exp=0x%0h",
                 $time, check_addr_mem1, mem1_output, golden_mem1[check_addr_mem1]);
      end
      
      if (check_en_mem2 && mem2_output !== golden_mem2[check_addr_mem2]) begin
        $error("[%0t] MEM2 failed addr=%0d dut=0x%0h exp=0x%0h",
               $time, check_addr_mem2, mem2_output, golden_mem2[check_addr_mem2]);
      end else if (check_en_mem2) begin
        $display("[%0t] MEM2 passed addr=%0d dut=0x%0h exp=0x%0h",
                 $time, check_addr_mem2, mem2_output, golden_mem2[check_addr_mem2]);
      end
    end
  end

  initial begin
    rst_n = 0; start_reading = 0;

  
    golden_mem1[0] = 8'h11;  golden_mem2[0] = 8'h21;
    golden_mem1[1] = 8'h12;  golden_mem2[1] = 8'h22;
    golden_mem1[2] = 8'h13;  golden_mem2[2] = 8'h23;
    golden_mem1[3] = 8'h14;  golden_mem2[3] = 8'h24;
    golden_mem1[4] = 8'h15;  golden_mem2[4] = 8'h25;
    golden_mem1[5] = 8'h16;  golden_mem2[5] = 8'h26;
    golden_mem1[6] = 8'h17;  golden_mem2[6] = 8'h27;
    golden_mem1[7] = 8'h18;  golden_mem2[7] = 8'h28;
    golden_mem1[8] = 8'h19;  golden_mem2[8] = 8'h29;
    golden_mem1[9] = 8'h1A;  golden_mem2[9] = 8'h2A;
    golden_mem1[10] = 8'h1B; golden_mem2[10] = 8'h2B;
    golden_mem1[11] = 8'h1C; golden_mem2[11] = 8'h2C;
    golden_mem1[12] = 8'h1D; golden_mem2[12] = 8'h2D;
    golden_mem1[13] = 8'h1E; golden_mem2[13] = 8'h2E;
    golden_mem1[14] = 8'h1F; golden_mem2[14] = 8'h2F;
    golden_mem1[15] = 8'h20; golden_mem2[15] = 8'h30;
    golden_mem1[16] = 8'h21; golden_mem2[16] = 8'h31;
    golden_mem1[17] = 8'h22; golden_mem2[17] = 8'h32;
    golden_mem1[18] = 8'h23; golden_mem2[18] = 8'h33;
    golden_mem1[19] = 8'h24; golden_mem2[19] = 8'h34;
    golden_mem1[20] = 8'h25; golden_mem2[20] = 8'h35;
    golden_mem1[21] = 8'h26; golden_mem2[21] = 8'h36;
    golden_mem1[22] = 8'h27; golden_mem2[22] = 8'h37;
    golden_mem1[23] = 8'h28; golden_mem2[23] = 8'h38;
    golden_mem1[24] = 8'h29; golden_mem2[24] = 8'h39;
    golden_mem1[25] = 8'h2A; golden_mem2[25] = 8'h3A;
    golden_mem1[26] = 8'h2B; golden_mem2[26] = 8'h3B;
    golden_mem1[27] = 8'h2C; golden_mem2[27] = 8'h3C;
    golden_mem1[28] = 8'h2D; golden_mem2[28] = 8'h3D;
    golden_mem1[29] = 8'h2E; golden_mem2[29] = 8'h3E;
    golden_mem1[30] = 8'h2F; golden_mem2[30] = 8'h3F;
    golden_mem1[31] = 8'h30; golden_mem2[31] = 8'h40;

    #10 rst_n = 1;

    #10 start_reading = 1;
    #10 start_reading = 0;

    wait(reading_done);
    #10;

    #20 start_reading = 1;
    #10 start_reading = 0;

    wait(reading_done);
    #10;

    #30 start_reading = 1;
    #10 start_reading = 0;

    wait(reading_done);
    #10;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start_reading=%b reading_done=%b data_valid=%b rd_en_mem1=%b rd_en_mem2=%b rd_addr_mem1=%0d rd_addr_mem2=%0d mem1_output=0x%0h mem2_output=0x%0h element_count=%0d check_addr_mem1=%0d check_addr_mem2=%0d check_en_mem1=%b check_en_mem2=%b",
      rst_n, start_reading, reading_done, data_valid, rd_en_mem1, rd_en_mem2, rd_addr_mem1, rd_addr_mem2, mem1_output, mem2_output, element_count, check_addr_mem1, check_addr_mem2, check_en_mem1, check_en_mem2);
  end
endmodule
