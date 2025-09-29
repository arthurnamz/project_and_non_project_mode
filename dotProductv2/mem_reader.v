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

    output reg read_en1,
    output reg [ADDR_WIDTH-1:0] read_address1,
    input  [DATA_WIDTH-1:0] mem1_input,
    output reg [DATA_WIDTH-1:0] mem1_output,

    output reg read_en2,
    output reg [ADDR_WIDTH-1:0] read_address2,
    input  [DATA_WIDTH-1:0] mem2_input,     
    output reg [DATA_WIDTH-1:0] mem2_output
);


    always @(posedge clk) begin
        if (!rst_n) begin
            mem1_output <= {DATA_WIDTH{1'b0}};
            mem2_output <= {DATA_WIDTH{1'b0}};
            read_address1 <= {ADDR_WIDTH{1'b0}};
            read_address2 <= {ADDR_WIDTH{1'b0}};
            read_en1 <= 1'b0;
            read_en2 <= 1'b0;
        end else if (start_reading ) begin
            read_en1 <= 1'b1;
            read_en2 <= 1'b1;
            mem1_output <= mem1_input;
            mem2_output <= mem2_input;
            read_address1 <= read_address1 + 1'b1;
            read_address2 <= read_address2 + 1'b1;
        end 
    end

endmodule


