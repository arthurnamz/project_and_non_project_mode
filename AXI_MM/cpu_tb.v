`timescale 1ns/1ps

module cpu_tb;
 parameter PERIOD = 4;
 parameter DATA_WIDTH = 8;
 parameter ADDR_WIDTH = 32;

 reg clk = 0;
 reg rstn;

// write address channel
 reg [ADDR_WIDTH-1:0] awaddr;
 reg awvalid;
 wire awready;

// write data channel
 reg [DATA_WIDTH-1:0] wdata;
 reg wvalid;
 wire wready;

// write response channel
 wire [1:0] bresp;
 wire bvalid;
 reg bready;

// read address channel
 reg [ADDR_WIDTH-1:0] araddr;
 reg arvalid;
 wire arready;

// read data channel
 wire [DATA_WIDTH-1:0] rdata;
 wire rvalid;
 wire rresp;
 reg rready;

 cpu #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) DUT(
    .clk(clk),
    .rstn(rstn),

    // write address channel
    .awaddr(awaddr),
    .awvalid(awvalid),
    .awready(awready),

    // write data channel
    .wdata(wdata),
    .wvalid(wvalid),
    .wready(wready),

    // write response channel
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),

    // read address channel
    .araddr(araddr),
    .arvalid(arvalid),
    .arready(arready),

    // read data channel
    .rdata(rdata),
    .rvalid(rvalid),
    .rresp(rresp),
    .rready(rready)
  );

  always #(PERIOD/2) clk = ~clk;

  initial begin
    rstn = 0;
    #10 rstn = 1;

 // write transaction 1 (write op1 to address 0)
    // write address channel
    awaddr = {ADDR_WIDTH{1'b0}};
    awvalid = 1'b1;
    wait (awready == 1'b1);
    $display($time," AWADDR_OP1 = 32'b%0b ", awaddr);
    @(posedge clk);
    awvalid = 1'b0;

    // write data channel
    wdata =  8'b10; // op1 = 5
    wvalid = 1'b1;
    wait (wready == 1'b1);
    $display($time," OP1 = 8'b%0b ", wdata);
    @(posedge clk);
    wvalid = 1'b0;

    // write response channel
    bready = 1'b1;
    wait (bvalid == 1'b1);
    if (bresp > 0) begin
        $display($time," PROBLEM WITH THE WRITE TRANSACTION bresp=2'b%0b ", bresp);
    end
    @(posedge clk);
    bready = 1'b0;

// write transaction 2 (write op2 to address 1)
    // write address channel
    awaddr = 32'b01;
    awvalid = 1'b1;
    wait (awready == 1'b1);
    $display($time," AWADDR_OP2 = 32'b%0b ", awaddr);
    @(posedge clk);
    awvalid = 1'b0;

    // write data channel
    wdata =  8'b011; // op2 = 3
    wvalid = 1'b1;
    wait (wready == 1'b1);
    $display($time," OP2 = 8'b%0b ", wdata);
    @(posedge clk);
    wvalid = 1'b0;

    // write response channel
    bready = 1'b1;
    wait (bvalid == 1'b1);
    if (bresp > 0) begin
        $display($time," PROBLEM WITH THE WRITE TRANSACTION bresp=2'b%0b ", bresp);
    end
    @(posedge clk);
    bready = 1'b0;


  // write transaction 3 (write opcode to address 2)
    // write address channel
    awaddr = 32'b10; // opcode address
    awvalid = 1'b1;
    wait (awready == 1'b1);
    $display($time," AWADDR_OPCODE = 32'b%0b ", awaddr);
    @(posedge clk);
    awvalid = 1'b0;

    // write data channel
    wdata =  8'b0; // opcode = 0
    wvalid = 1'b1;
    wait (wready == 1'b1);
    $display($time," OPCODE = 8'b%0b ", wdata);
    @(posedge clk);
    wvalid = 1'b0;

    // write response channel
    bready = 1'b1;
    wait (bvalid == 1'b1);
    if (bresp > 0) begin
        $display($time," PROBLEM WITH THE WRITE TRANSACTION bresp=2'b%0b ", bresp);
    end
    @(posedge clk);
    bready = 1'b0;

// read transaction 1 (read result from address 3)
    // read address channel
    araddr = 32'b11;
    arvalid = 1'b1;
    wait (arready == 1'b1);
    $display($time," ARADDR_RESULT = 32'b%0b ", araddr);
    @(posedge clk);
    arvalid = 1'b0;

    // read data channel
    rready = 1'b1;
    wait (rvalid == 1'b1);
    $display($time," RDATA = 8'b%0b -- RRESP = 2'b%0b", rdata, rresp);
    @(posedge clk);
    rready = 1'b0;

    #1000 $finish;
  end 



//   initial begin
//     $monitor(" " );
//   end
endmodule