`timescale 1ns / 1ps
(* dont_touch="true" *)
module mem_writer #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64,
    parameter RESULT_WIDTH = 16
)(
    input clk,
    input rst_n,
    input start_writing,
    
    input [RESULT_WIDTH-1:0] dot_product_result,
    
    output reg write_en,
    output reg [ADDR_WIDTH-1:0] write_address,
    output reg [DATA_WIDTH-1:0] data_in
);

    reg [RESULT_WIDTH-1:0] hold_dot_product_result;

    
    always @(posedge clk) begin
        if (!rst_n) begin
            write_en <= 1'b0;
            write_address <= {ADDR_WIDTH{1'b0}};
            data_in <= {DATA_WIDTH{1'b0}};
        end else if (start_writing) begin 
            hold_dot_product_result <= dot_product_result;

            if (hold_dot_product_result != dot_product_result) begin
                write_en <= 1'b1;
                write_address <= write_address + 1'b1;
                data_in <= dot_product_result[RESULT_WIDTH-1:0];
            end
        end 
    end

endmodule
