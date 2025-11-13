`timescale 1ns/1ps

module alu #(
    parameter DATA_WIDTH = 8
)(
    input [DATA_WIDTH-1:0] op1,
    input [DATA_WIDTH-1:0] op2,
    input [DATA_WIDTH-1:0] opcode,
    output reg [DATA_WIDTH-1:0] result
);

always @(*) begin
    case (opcode)
        8'd0: result = op1 + op2;
        8'd1: result = op1 - op2;
        8'd2: result = ~op1;
        8'd3: result = op1 << op2;
        default: result = 8'b0;
    endcase
end

endmodule

