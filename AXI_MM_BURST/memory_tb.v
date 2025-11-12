`timescale 1ns/1ps

module memory_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;    // 8-bit words (byte-addressable)
  parameter MEM_SIZE     = 1024;
  parameter ADDR_WIDTH   = 10;

  reg                     clk = 0;
  reg                     rst_n;
  reg                     write_en;
  reg  [ADDR_WIDTH-1:0]   write_address;
  reg  [DATA_WIDTH-1:0]   data_in;
  reg                     read_en;
  reg  [ADDR_WIDTH-1:0]   read_address;
  wire [DATA_WIDTH-1:0]   data_out;

  // DUT
  memory #(
    .DATA_WIDTH  (DATA_WIDTH),
    .MEM_SIZE    (MEM_SIZE),
    .ADDR_WIDTH  (ADDR_WIDTH)
  ) u_memory (
    .clk      (clk),
    .rst_n    (rst_n),
    .write_en    (write_en),
    .write_address  (write_address),
    .data_in   (data_in),
    .read_en    (read_en),
    .read_address  (read_address),
    .data_out (data_out)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] model_mem [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] model_out;

  always @(posedge clk) begin
    if (!rst_n) begin
      model_mem[write_address] <= {DATA_WIDTH{1'b0}};
      model_out <= {DATA_WIDTH{1'b0}};
    end else begin
      if (write_en) model_mem[write_address] <= data_in;
      if (read_en) model_out <= model_mem[read_address];
    end
  end

  function integer same;
    input [DATA_WIDTH-1:0] a, b;
    begin same = (a === b); end
  endfunction

  always @(posedge clk) begin
    if (rst_n && read_en) begin
      if (!same(data_out, model_out)) begin
        $error("[%0t] memory failed ra=%0d dut=0x%0h exp=0x%0h",
               $time, read_address, data_out, model_out);
      end else begin
        $display("[%0t] memory passed ra=%0d dut=0x%0h exp=0x%0h",
                 $time, read_address, data_out, model_out);
      end
    end
  end

  initial begin
    rst_n = 0; write_en = 0; read_en = 0; write_address = 10'b0; read_address = 10'b0; data_in = 8'b0;

    #10 rst_n = 1;
    
    $display("\n=== Test: Writing 32-bit data (0xDEADBEEF) as 4 bytes ===");
    // Write 32-bit value 0xDEADBEEF starting at address 0
    // Byte 0: 0xEF (LSB)
    #10 write_en=1; write_address=10'd0; data_in=8'hEF;
    #10 write_en=0;
    
    // Byte 1: 0xBE
    #10 write_en=1; write_address=10'd1; data_in=8'hBE;
    #10 write_en=0;
    
    // Byte 2: 0xAD
    #10 write_en=1; write_address=10'd2; data_in=8'hAD;
    #10 write_en=0;
    
    // Byte 3: 0xDE (MSB)
    #10 write_en=1; write_address=10'd3; data_in=8'hDE;
    #10 write_en=0;

    $display("\n=== Test: Reading back the 4 bytes ===");
    // Read back the 4 bytes
    #10 read_en=1; read_address=10'd0;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd1;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd2;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd3;
    #10 read_en=0;

    $display("\n=== Test: Writing another 32-bit value (0x12345678) at address 4 ===");
    // Write 32-bit value 0x12345678 starting at address 4
    #10 write_en=1; write_address=10'd4; data_in=8'h78;
    #10 write_en=0;
    
    #10 write_en=1; write_address=10'd5; data_in=8'h56;
    #10 write_en=0;
    
    #10 write_en=1; write_address=10'd6; data_in=8'h34;
    #10 write_en=0;
    
    #10 write_en=1; write_address=10'd7; data_in=8'h12;
    #10 write_en=0;

    $display("\n=== Test: Reading back from address 4-7 ===");
    #10 read_en=1; read_address=10'd4;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd5;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd6;
    #10 read_en=0;
    
    #10 read_en=1; read_address=10'd7;
    #10 read_en=0;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b write_en=%b read_en=%b write_address=%0d read_address=%0d data_in=0x%0h data_out=0x%0h exp=0x%0h",
      rst_n, write_en, read_en, write_address, read_address, data_in, data_out, model_out);
  end
endmodule