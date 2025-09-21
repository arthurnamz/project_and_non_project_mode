
`timescale 1ns/1ps

module mem2_tb;

  function integer clog2;
        input integer value;
        integer i;
        begin
            clog2 = 0;
            for (i = value - 1; i > 0; i = i >> 1)
            clog2 = clog2 + 1;
        end
  endfunction

  localparam PERIOD       = 4;
  localparam DATA_WIDTH   = 8;
  localparam VETOR_WIDTH  = 4;
  localparam DEPTH        = VETOR_WIDTH * DATA_WIDTH;
  localparam ADDR_WIDTH   = clog2(DEPTH);

  reg                     clk = 0;
  reg                     rst_n;
  reg                     wr_en;
  reg  [ADDR_WIDTH-1:0]   wr_addr;
  reg  [DATA_WIDTH-1:0]   datain;
  reg                     rd_en;
  reg  [ADDR_WIDTH-1:0]   rd_addr;
  wire [DATA_WIDTH-1:0]   data_out;

  // DUT
  mem2 #(
    .DATA_WIDTH  (DATA_WIDTH),
    .VETOR_WIDTH (VETOR_WIDTH)
  ) u_mem1 (
    .clk      (clk),
    .rst_n    (rst_n),
    .wr_en    (wr_en),
    .wr_addr  (wr_addr),
    .datain   (datain),
    .rd_en    (rd_en),
    .rd_addr  (rd_addr),
    .data_out (data_out)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] model_mem [0:DEPTH-1];
  reg [DATA_WIDTH-1:0] model_out;

  always @(posedge clk) begin
    if (!rst_n) begin
      model_mem[0] <= {DATA_WIDTH{1'b0}}; 
      model_out    <= {DATA_WIDTH{1'b0}};
    end else begin
      if (wr_en) model_mem[wr_addr] <= datain;
      if (rd_en) model_out <= model_mem[rd_addr];
    end
  end

  function integer same;
    input [DATA_WIDTH-1:0] a, b;
    begin same = (a === b); end
  endfunction

  always @(posedge clk) begin
    if (rst_n && rd_en) begin
      if (!same(data_out, model_out)) begin
        $error("[%0t] MISMATCH ra=%0d dut=0x%0h exp=0x%0h",
               $time, rd_addr, data_out, model_out);
      end else begin
        $display("[%0t] MATCH    ra=%0d dut=0x%0h exp=0x%0h",
                 $time, rd_addr, data_out, model_out);
      end
    end
  end

  initial begin
    rst_n = 0; wr_en = 0; rd_en = 0; wr_addr = 8'b0; rd_addr = 8'b0; datain = 8'b0;

    #100 rst_n = 1;

    #10  wr_en=1; wr_addr=0; datain=8'h11;
    #PERIOD wr_en=0;

    #10  wr_en=1; wr_addr=1; datain=8'h22;
    #PERIOD wr_en=0;

    #10  rd_en=1; rd_addr=0;
    #PERIOD rd_en=0;

    #10  rd_en=1; rd_addr=1;
    #PERIOD rd_en=0;

    #10  wr_en=1; wr_addr=1; datain=8'hA5;
    #PERIOD wr_en=0;

    #10  rd_en=1; rd_addr=1;
    #PERIOD rd_en=0;

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b wr_en=%b rd_en=%b wr_addr=%0d rd_addr=%0d din=%0d dout=%0d exp=%0d",
      rst_n, wr_en, rd_en, wr_addr, rd_addr, datain, data_out, model_out);
  end
endmodule
