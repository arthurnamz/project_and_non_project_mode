
`timescale 1ns/1ps

module mem2_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter MEM_SIZE     = 64;
  parameter ADDR_WIDTH   = 4;

  reg                     clk = 0;
  reg                     rst_n;
  reg                     write_en;
  reg  [ADDR_WIDTH-1:0]   write_address;
  reg  [DATA_WIDTH-1:0]   data_in;
  reg                     read_en;
  reg  [ADDR_WIDTH-1:0]   read_address;
  wire [DATA_WIDTH-1:0]   data_out;

  // DUT
  mem2 #(
    .DATA_WIDTH  (DATA_WIDTH),
    .MEM_SIZE    (MEM_SIZE),
    .ADDR_WIDTH  (ADDR_WIDTH)
  ) u_mem2 (
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
      model_mem[0] <= 8'bz; 
      model_out    <= 8'bz;
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
        $error("[%0t] MISMATCH ra=%0d dut=0x%0h exp=0x%0h",
               $time, read_address, data_out, model_out);
      end else begin
        $display("[%0t] MATCH    ra=%0d dut=0x%0h exp=0x%0h",
                 $time, read_address, data_out, model_out);
      end
    end
  end

  initial begin
    rst_n = 0; write_en = 0; read_en = 0; write_address = 4'b0; read_address = 4'b0; data_in = 8'b0;

    #10 rst_n = 1;

    #10 write_en=1; write_address=4'b0; data_in=8'h11;
    #10 write_en=0;

    #10 write_en=1; write_address=4'b1; data_in=8'h22;
    #10 write_en=0;

    #10 read_en=1; read_address=4'b0;
    #10 read_en=0;

    #10 read_en=1; read_address=4'b1;
    #10 read_en=0;

    #10 write_en=1; write_address=4'b1; data_in=8'hA5;
    #10 write_en=0;

    #10 read_en=1; read_address=4'b1;
    #10 read_en=0;    

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b write_en=%b read_en=%b write_address=%0d read_address=%0d data_in=%0d data_out=%0d exp=%0d",
      rst_n, write_en, read_en, write_address, read_address, data_in, data_out, model_out);
  end
endmodule
