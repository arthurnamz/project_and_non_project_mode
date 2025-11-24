`timescale 1ns/1ps

module tb_axi_write_to_axis;

  localparam DATA_WIDTH = 32;
  localparam ADDR_WIDTH = 32;
  localparam FIFO_WIDTH = 16;
  localparam PERIOD = 10;

  reg aclk = 0;
  reg aresetn;

  // write address channel
  reg [ADDR_WIDTH-1:0] awaddr;
  reg [(ADDR_WIDTH/4)-1:0] awlen;
  reg [2:0] awsize;
  reg [1:0] awburst;
  reg awvalid;
  wire awready;

  // write data channel
  reg [DATA_WIDTH-1:0] wdata;
  reg [DATA_WIDTH/8-1:0] wstrb;
  reg wlast;
  reg wvalid;
  wire wready;

  // write response channel
  wire [1:0] bresp;
  wire bvalid;
  reg bready;

  // AXI-Stream interface output (No TLAST)
  wire m_axis_tvalid;
  reg m_axis_tready;
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  
  

  axi_write_burst_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .FIFO_WIDTH(FIFO_WIDTH)
  ) dut (
    .aclk(aclk),
    .aresetn(aresetn),
  
    // write address channel
    .awaddr(awaddr),
    .awlen(awlen),
    .awsize(awsize),
    .awburst(awburst),
    .awvalid(awvalid),
    .awready(awready),

    // write data channel
    .wdata(wdata),
    .wstrb(wstrb),
    .wlast(wlast),
    .wvalid(wvalid),
    .wready(wready),

    // write response channel
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),

    // AXI-Stream interface output (No TLAST)
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tdata(m_axis_tdata)
  );

 always #(PERIOD/2) aclk = ~aclk;

 initial begin
  aresetn = 0;

  // wait for 5 clock cycles
  repeat(5) @(posedge aclk);
  aresetn = 1;
  bready = 1;


  // write address channel
  awaddr = 32'h1000_0000;
  awlen = 3; // 4 packets
  awsize = 2; // 4 bytes per packet
  awburst = 1; // INCR burst
  awvalid = 1;
  // wait for awready to be asserted
  wait (awready);
  @(posedge aclk);
  awvalid = 0;

  // write data channel - send 4 words (awlen=3 means 4 beats)
  @(posedge aclk)
  wlast = 0;
  wvalid = 1;
  @(posedge aclk);

  wdata = 32'h10;
  wait (wready);
  @(posedge aclk);

  wlast = 0;
  wdata = 32'h11;
  wait (wready);
  @(posedge aclk);

  wlast = 0;
  wdata = 32'h12;
  wait (wready);
  @(posedge aclk);

  wlast = 1;
  wdata = 32'h13;
  wait (wready);
  @(posedge aclk);
  wvalid = 0;
  wlast = 0;

  // wait for response in the response channel
  wait (bvalid);
  @(posedge aclk);
  bready = 0;
 
 // Wait for all data to be streamed out from the axi stream interface
 m_axis_tready = 1;  // Enable AXI-Stream ready early to capture all data
 repeat(3) @(posedge aclk);
 bready = 1;
  m_axis_tready = 0;  // Enable AXI-Stream ready early to capture all data


  // write address channel
  awaddr = 32'h2000_0000;
  awlen = 3; // 4 packets
  awsize = 2; // 4 bytes per packet
  awburst = 1; // INCR burst
  awvalid = 1;
  // wait for awready to be asserted
  wait (awready);
  @(posedge aclk);
  awvalid = 0;

  // write data channel - send 4 words (awlen=3 means 4 beats)
  @(posedge aclk)
  wlast = 0;
  wvalid = 1;
  @(posedge aclk);

  wdata = 32'h21;
  wait (wready);
  @(posedge aclk);

  wlast = 0;
  wdata = 32'h22;
  wait (wready);
  @(posedge aclk);

  wlast = 0;
  wdata = 32'h23;
  wait (wready);
  @(posedge aclk);

  wlast = 1;
  wdata = 32'h24;
  wait (wready);
  @(posedge aclk);
  wvalid = 0;
  wlast = 0;

  // wait for response in the response channel
  wait (bvalid);
  @(posedge aclk);
  bready = 0;
 
 // Wait for all data to be streamed out from the axi stream interface
 m_axis_tready = 1;  // Enable AXI-Stream ready early to capture all data
 repeat(20) @(posedge aclk);

 $finish;
 end

 always @(posedge aclk) begin
    if (m_axis_tvalid && m_axis_tready) begin
        $display($time, " AXI OUT : data = 0x%0h", m_axis_tdata);
    end
 end
 
endmodule
