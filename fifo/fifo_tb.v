
`timescale 1ns/1ps
module fifo_tb;

parameter DEPTH = 8;
parameter DATA_WIDTH = 8;
parameter PERIOD = 10;
parameter TEST_COUNT = 10;

reg clk = 0;
reg rstn;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire full;
wire empty;
integer i;

fifo #(.DEPTH(DEPTH), .DATA_WIDTH(DATA_WIDTH)) u_fifo (
    .clk(clk),
    .rstn(rstn),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

always #(PERIOD/2) clk = ~clk;

initial begin
    rstn = 0;
    #10 rstn = 1;

   for ( i = 0; i < TEST_COUNT; i=i+1) begin
    data_in = i;
    #PERIOD;
   end

    #1000 $finish;
end

initial begin
    $monitor("clk = %d, rstn = %d, data_in = %d, data_out = %d, full = %d, empty = %d", clk, rstn, data_in, data_out, full, empty);
end


endmodule