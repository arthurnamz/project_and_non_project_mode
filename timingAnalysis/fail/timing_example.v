`timescale 1ns / 1ps

module timing_example #
(
    parameter DATA_WIDTH = 16,
    parameter RESULT_WIDTH = 30
)
(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] a,b,c,d,
    output reg [RESULT_WIDTH-1:0] y
);
reg [DATA_WIDTH-1:0] a_r,b_r,c_r,d_r;

reg [RESULT_WIDTH-1:0] y_r;

always @(posedge clk) begin
    if(rst) begin
    a_r <= 0;
    b_r <= 0;
    c_r <= 0;
    d_r <= 0;
    end else begin
    a_r <= a;
    b_r <= b;
    c_r <= c;
    d_r <= d;
    end
end

always @(posedge clk) begin
     if(rst) begin
      y_r <= 0;
     end else begin
      y_r <=((a_r+b_r) * (c_r+d_r) )+(a_r*d_r);
     end
end

always @(posedge clk) begin
     if(rst) begin
      y <= 0;
     end else begin
      y <= y_r;
     end
end




endmodule