`timescale 1ns/1ps

module memory_tb;

  parameter PERIOD       = 4;
  parameter DATA_WIDTH   = 8;
  parameter MEM_SIZE     = 64;
  parameter ADDR_WIDTH   = 4;

  reg                     clk = 0;
  reg                     rstn;
  reg                     wr_en;
  reg  [ADDR_WIDTH-1:0]   wr_address;
  reg  [DATA_WIDTH-1:0]   data_in;
  reg                     rd_en;
  reg  [ADDR_WIDTH-1:0]   rd_address;
  wire [DATA_WIDTH-1:0]   data_out;

  // DUT
  memory #(
    .DATA_WIDTH  (DATA_WIDTH),
    .MEM_SIZE    (MEM_SIZE),
    .ADDR_WIDTH  (ADDR_WIDTH)
  ) uut (
    .clk      (clk),
    .rstn    (rstn),
    .wr_en    (wr_en),
    .wr_address  (wr_address),
    .data_in   (data_in),
    .rd_en    (rd_en),
    .rd_address  (rd_address),
    .data_out (data_out)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] model_mem [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] model_out;

  always @(posedge clk) begin
    if (!rstn) begin
      model_mem[wr_address] <= {DATA_WIDTH{1'b0}};
      model_out <= {DATA_WIDTH{1'b0}};
    end else begin
      if (wr_en) model_mem[wr_address] <= data_in;
      if (rd_en) model_out <= model_mem[rd_address];
    end
  end

  function integer same;
    input [DATA_WIDTH-1:0] a, b;
    begin same = (a === b); end
  endfunction

  always @(posedge clk) begin
    if (rstn && rd_en) begin
      if (!same(data_out, model_out)) begin
        $error("[%0t] FAIL: memory failed ra=%0d dut=0x%0h exp=0x%0h",
               $time, rd_address, data_out, model_out);
      end else begin
        $display("[%0t] PASS: memory passed ra=%0d dut=0x%0h exp=0x%0h",
                 $time, rd_address, data_out, model_out);
      end
    end
  end

  initial begin
    rstn = 0; wr_en = 0; rd_en = 0; wr_address = 4'b0; rd_address = 4'b0; data_in = 8'b0;

    #10 rstn = 1;

    #10 wr_en=1; wr_address=4'b0; data_in=8'h11;
    #10 wr_en=0;

    #10 wr_en=1; wr_address=4'b1; data_in=8'h22;
    #10 wr_en=0;

    #10 rd_en=1; rd_address=4'b0;
    #10 rd_en=0;

    #10 rd_en=1; rd_address=4'b1;
    #10 rd_en=0;

    #10 wr_en=1; wr_address=4'b1; data_in=8'hA5;
    #10 wr_en=0;

    #10 rd_en=1; rd_address=4'b1;
    #10 rd_en=0;    

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rstn=%b wr_en=%b rd_en=%b wr_address=%0d rd_address=%0d data_in=0x%0h data_out=0x%0h exp=0x%0h",
      rstn, wr_en, rd_en, wr_address, rd_address, data_in, data_out, model_out);
  end
endmodule