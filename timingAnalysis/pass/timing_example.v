`timescale 1ns / 1ps

module timing_example #
(
    parameter DATA_WIDTH = 16,
    parameter RESULT_WIDTH = 32
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

reg [DATA_WIDTH - 1:0] sum1, sum2;
reg [RESULT_WIDTH -1:0] mult2;

always @(posedge clk) begin
    if(rst) begin
       sum1 <= 0;
       sum2 <= 0;
       mult2 <= 0;
    end else begin
       sum1 <= a_r + b_r;
       sum2 <= c_r + d_r;
       mult2 <= a_r * d_r;
    end
end
reg [RESULT_WIDTH - 1:0] mult1;
always @(posedge clk) begin
    if(rst)
        mult1 <= 0;
    else 
        mult1 <= sum1 * sum2;
end

always @(posedge clk) begin
    if(rst)
        y_r <= 0;
    else 
        y_r <= mult1 + mult2;
end

always @(posedge clk) begin
    if(rst)
        y <= 0;
    else 
        y <= y_r;
end

endmodule
