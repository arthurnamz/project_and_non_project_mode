`timescale 1ns/1ps
module mem_controller#(
    parameter DATA_WIDTH  = 8,
    parameter VETOR_WIDTH = 4,
    parameter DEPTH       = VETOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH  = clog2(DEPTH)
)
(
    input                     clk,
    input                     rst_n,

    // Write-side streaming control (writes to BOTH memories in lockstep)
    input                     start,       // pulse to begin
    input                     in_valid,    // valid data this cycle
    input   [DATA_WIDTH-1:0]  data_a,      // to mem1
    input   [DATA_WIDTH-1:0]  data_b,      // to mem2
    output reg                busy,
    output reg                done,        // 1-cycle pulse at completion

    // Read Port A (mem1)
    input                     rd_en_a,
    input  [ADDR_WIDTH-1:0]   rd_addr_a,
    output wire [DATA_WIDTH-1:0] dout_a,

    // Read Port B (mem2)
    input                     rd_en_b,
    input  [ADDR_WIDTH-1:0]   rd_addr_b,
    output wire [DATA_WIDTH-1:0] dout_b
);
  reg [ADDR_WIDTH-1:0] wr_addr_q;
  reg                  wr_en_q;
  reg [DATA_WIDTH-1:0] din_a_q, din_b_q;

  always @(posedge clk) begin
    if (!rst_n) begin
      busy      <= 1'b0;
      done      <= 1'b0;
      wr_addr_q <= {ADDR_WIDTH{1'b0}};
      wr_en_q   <= 1'b0;
      din_a_q   <= {DATA_WIDTH{1'b0}};
      din_b_q   <= {DATA_WIDTH{1'b0}};
    end else begin
      done    <= 1'b0;     // pulse
      wr_en_q <= 1'b0;     // default

      if (start && !busy) begin
        busy      <= 1'b1;
        wr_addr_q <= {ADDR_WIDTH{1'b0}};
      end

      if (busy && in_valid) begin
        wr_en_q <= 1'b1;
        din_a_q <= data_a;
        din_b_q <= data_b;

        if (wr_addr_q == DEPTH-1) begin
          busy <= 1'b0;
          done <= 1'b1;
        end
        wr_addr_q <= wr_addr_q + 1'b1;
      end
    end
  end

  // Memories
  mem1 #(.DATA_WIDTH(DATA_WIDTH), .VETOR_WIDTH(VETOR_WIDTH)) u_mem1 (
    .clk(clk), .rst_n(rst_n),
    .wr_en(wr_en_q), .wr_addr(wr_addr_q), .datain(din_a_q),
    .rd_en(rd_en_a), .rd_addr(rd_addr_a), .data_out(dout_a)
  );

  mem2 #(.DATA_WIDTH(DATA_WIDTH), .VETOR_WIDTH(VETOR_WIDTH)) u_mem2 (
    .clk(clk), .rst_n(rst_n),
    .wr_en(wr_en_q), .wr_addr(wr_addr_q), .datain(din_b_q),
    .rd_en(rd_en_b), .rd_addr(rd_addr_b), .data_out(dout_b)
  );

  function integer clog2;
  input integer value; integer i;
  begin
    clog2 = 0;
    for (i = value - 1; i > 0; i = i >> 1) clog2 = clog2 + 1;
  end
endfunction
endmodule
