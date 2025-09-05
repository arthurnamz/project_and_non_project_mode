`timescale 1ns / 1ps

module top #
(
    parameter DATA_WIDTH = 3,
    parameter SEG_WIDTH  = 7
)
(
    input                      clk,
    input                      rstn,     
    input  [DATA_WIDTH-1:0]    a,
    input  [DATA_WIDTH-1:0]    b,
    output [SEG_WIDTH-1:0]     seg_a,
    output [SEG_WIDTH-1:0]     seg_b,
    output [SEG_WIDTH-1:0]     seg_sum,
    output                     led_carry
);
    reg [DATA_WIDTH-1:0] a_r, b_r;
    reg [DATA_WIDTH-1:0] sum_r;
    reg                  carry_r;

    wire [DATA_WIDTH-1:0] sum_w;
    wire                  carry_w;

    full_carry_adder #(
        .DATA_WIDTH(DATA_WIDTH)
    ) adder_i (
        .a     (a_r),
        .b     (b_r),
        .sum   (sum_w),
        .carry (carry_w)
    );

    always @(posedge clk) begin
        if (~rstn) begin
            a_r     <= {DATA_WIDTH{1'b0}};
            b_r     <= {DATA_WIDTH{1'b0}};
            sum_r   <= {DATA_WIDTH{1'b0}};
            carry_r <= 1'b0;
        end else begin
            a_r     <= a;
            b_r     <= b;
            sum_r   <= sum_w;
            carry_r <= carry_w;
        end
    end

    seven_segment_display #(
        .DATA_WIDTH  (DATA_WIDTH),
        .RESULT_WIDTH(SEG_WIDTH)
    ) display_a (
        .dataIN  (a_r),
        .dataOUT (seg_a)
    );

    seven_segment_display #(
        .DATA_WIDTH  (DATA_WIDTH),
        .RESULT_WIDTH(SEG_WIDTH)
    ) display_b (
        .dataIN  (b_r),
        .dataOUT (seg_b)
    );

    seven_segment_display #(
        .DATA_WIDTH  (DATA_WIDTH),
        .RESULT_WIDTH(SEG_WIDTH)
    ) display_sum (
        .dataIN  (sum_r),
        .dataOUT (seg_sum)
    );

    assign led_carry = carry_r;

endmodule



