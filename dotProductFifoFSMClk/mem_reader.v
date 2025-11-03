`timescale 1ns / 1ps
(* dont_touch="true" *)
module mem_reader #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter MEM_SIZE = 32
)(
    input clk,
    input rst_n,
    input start_reading,

    output reg read_en,
    output reg [ADDR_WIDTH-1:0] read_address,
    input  [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);

    assign data_out = data_in;

    always @(posedge clk) begin
        if (!rst_n) begin
            read_address <= {ADDR_WIDTH{1'b0}};
            read_en <= 1'b0;
        end else if (start_reading) begin
            read_en <= 1'b1;
            read_address <= read_address + 1'b1;
        end else begin
            read_en <= 1'b0;
        end
    end
            
endmodule


