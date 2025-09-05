`timescale 1ns / 1ps

module full_carry_adder #
(
    parameter DATA_WIDTH = 3
)(
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    output [DATA_WIDTH-1:0] sum,
    output carry
);
  
    wire [DATA_WIDTH:0] carry_chain;
    assign carry_chain[0] = 1'b0;  
    
    genvar i;
    generate
        for (i = 0; i < DATA_WIDTH; i = i + 1) begin : full_adder_chain
            assign sum[i] = a[i] ^ b[i] ^ carry_chain[i];
            assign carry_chain[i+1] = (a[i] & b[i]) | (carry_chain[i] & (a[i] ^ b[i]));
        end
    endgenerate
   
    assign carry = carry_chain[DATA_WIDTH];

endmodule
