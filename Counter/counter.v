`timescale 1ns/1ps

module counter#(
    parameter DATA_WIDTH = 4
)(
    input clk,
    input rst_n,
    input direction,
    output reg [DATA_WIDTH-1:0] count
);

reg clk_tmp;
reg [25:0] counter;

always @(posedge clk) begin
    if (~rst_n) begin
        counter <= 1;
    end
    else begin
        counter <= counter + 1;
        if (counter == 50000000) begin
            clk_tmp <= ~clk_tmp;
            counter <= 1;
        end
    end
end

always @(posedge clk ) 
begin
    if (~rst_n) 
        count <= 0;
    else
        if (direction) 
            count <= count + 1;
        else 
            count <= count - 1;
            
end

endmodule
