`timescale 1ns/1ps

module tb;
    localparam PERIOD = 4;
    localparam DATA_WIDTH = 3;
    localparam SEG_WIDTH  = 7;

    reg clk = 0;
    reg rstn;
    reg [DATA_WIDTH-1:0] a;
    reg [DATA_WIDTH-1:0] b;
    wire [SEG_WIDTH-1:0] seg_a;
    wire [SEG_WIDTH-1:0] seg_b;
    wire [SEG_WIDTH-1:0] seg_sum;
    wire                 led_carry;

    top #(
        .DATA_WIDTH(DATA_WIDTH),
        .SEG_WIDTH (SEG_WIDTH)
    ) dut (
        .clk      (clk),
        .rstn     (rstn),
        .a        (a),
        .b        (b),
        .seg_a    (seg_a),
        .seg_b    (seg_b),
        .seg_sum  (seg_sum),
        .led_carry(led_carry)
    );

    always #(PERIOD/2) clk = ~clk;

    initial begin
        rstn = 0;
        a    = 0;
        b    = 0;

        #100 rstn = 1;

        #10 a = 3'd2; b = 3'd3;
        #10 a = 3'd5; b = 3'd7;
        #10 a = 3'd7; b = 3'd7;
        #10 a = 3'd1; b = 3'd6;
        #10 a = 3'd4; b = 3'd2;
        #10 a = 3'd0; b = 3'd0;
    end

    initial begin
        $monitor($time, " rstn=%b a=%d b=%d seg_a=%b seg_b=%b seg_sum=%b led_carry=%b", 
            rstn, a, b, seg_a, seg_b, seg_sum, led_carry);
        #200;
        $finish;
    end
endmodule