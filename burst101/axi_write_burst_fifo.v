`timescale 1ns/1ps

module axi_write_burst_fifo #
(
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 32,
  parameter FIFO_WIDTH = 16
)
(
  input wire aclk,
  input wire aresetn,

  // write address channel
  input wire [ADDR_WIDTH-1:0] awaddr,
  input wire [(ADDR_WIDTH/4)-1:0] awlen,
  input wire [2:0] awsize,
  input wire [1:0] awburst,
  input wire awvalid,
  output reg awready,

  // write data channel
  input wire [DATA_WIDTH-1:0] wdata,
  input wire [DATA_WIDTH/8-1:0] wstrb,
  input wire wlast,
  input wire wvalid,
  output reg wready,

  // write response channel
  output reg [1:0] bresp,
  output reg bvalid,
  input bready,

  // AXI-Stream interface output (No TLAST)
  output wire m_axis_tvalid,
  input wire m_axis_tready,
  output wire [DATA_WIDTH-1:0] m_axis_tdata
);

  // External FIFO
  wire fifo_full;
  wire fifo_empty;
  wire pop_stream;

  fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(FIFO_WIDTH)
  ) fifo_inst (
    .clk(aclk),
    .rstn(aresetn),

    // Write interface
    .wr_en(wvalid && wready),
    .data_in(wdata),
    .full(fifo_full),

    // Read interface
    .rd_en(pop_stream),
    .data_out(m_axis_tdata),
    .empty(fifo_empty)
  );
  
  // AXI-Stream output
  assign m_axis_tvalid = !fifo_empty;
  assign pop_stream = m_axis_tvalid && m_axis_tready;

  // AXI Write Address Channel
  always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
      awready <= 0;
    end else begin
      awready <= 1; // always ready for simplified model
    end
  end

  // AXI Write Data Channel
  always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
      wready <= 0;
    end else begin
      wready <= !fifo_full;
    end
  end

  // AXI Write Response Channel
  always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
      bvalid <= 0;
      bresp <= 2'b00; 
    end else begin
      if (bvalid && bready) begin
        bvalid <= 0;
      end else if (!bvalid && wvalid && wready && wlast) begin
        bvalid <= 1;
        bresp <= 2'b00;
      end
    end
  end
endmodule
