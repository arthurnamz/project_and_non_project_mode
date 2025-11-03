`timescale 1ns / 1ps
(* dont_touch="true" *)
module dotProduct #(
    parameter DATA_WIDTH = 32,
    parameter VECTOR_WIDTH = 4,
    parameter VECTOR_ELEMENT_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter RESULT_WIDTH = 2*VECTOR_ELEMENT_WIDTH
)(
    input clk,
    input rst_n,
    input start_processing,
    input [DATA_WIDTH-1:0] mem1_input,
    input [DATA_WIDTH-1:0] mem2_input,
    
    output reg [RESULT_WIDTH-1:0] dot_product_result,
    output reg processing_done
);

    reg [VECTOR_ELEMENT_WIDTH-1:0] mem1_vec [0:VECTOR_WIDTH-1];
    reg [VECTOR_ELEMENT_WIDTH-1:0] mem2_vec [0:VECTOR_WIDTH-1];
    reg [2*VECTOR_ELEMENT_WIDTH-1:0] products [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] sum;
    integer i;
    genvar gi;

    generate
        for (gi = 0; gi < VECTOR_WIDTH; gi = gi + 1) begin 
            always @(posedge clk) begin
             mem1_vec[gi] <= mem1_input[(VECTOR_WIDTH-1-gi)*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
             mem2_vec[gi] <= mem2_input[(VECTOR_WIDTH-1-gi)*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            end
        end
    endgenerate
    
    generate
        for (gi = 0; gi < VECTOR_WIDTH; gi = gi + 1) begin
	       always @(posedge clk)	
            	 products[gi] <= mem1_vec[gi] * mem2_vec[gi];
        end
    endgenerate

    
    always @* begin
        sum = {RESULT_WIDTH{1'b0}};
        for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
            sum = sum + products[i];
        end
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            dot_product_result <= {RESULT_WIDTH{1'b0}};
            processing_done <= 1'b0;
        end else begin
            if (start_processing) begin
                dot_product_result <= sum;
                processing_done <= 1'b1;
            end else begin
                processing_done <= 1'b0;
            end
        end
    end

endmodule
