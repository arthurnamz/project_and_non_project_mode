`timescale 1ns / 1ps

module dotProduct #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter ADDR_WIDTH = 5,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)
)(
    input clk,
    input rst_n,
    input [DATA_WIDTH-1:0] mem1_input,
    input [DATA_WIDTH-1:0] mem2_input,
    input data_valid,
    output reg [RESULT_WIDTH-1:0] dot_product_result,
    output reg result_valid,
    output reg processing_done
);

    reg [DATA_WIDTH-1:0] vector_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] vector_b [0:VECTOR_WIDTH-1];
    reg [2:0] element_count;
    reg [RESULT_WIDTH-1:0] accumulator;
    reg vector_complete;
    reg [1:0] result_delay;
    reg data_valid_prev;

    always @(posedge clk) begin
        if (!rst_n) begin
            element_count <= 0;
            accumulator <= 0;
            vector_complete <= 0;
            result_delay <= 0;
            dot_product_result <= 0;
            result_valid <= 0;
            processing_done <= 0;
            data_valid_prev <= 0;
        end else begin
            data_valid_prev <= data_valid;
            
            if (data_valid && !vector_complete) begin
                // Store input vectors
                vector_a[element_count] <= mem1_input;
                vector_b[element_count] <= mem2_input;
                
                // Calculate product and add to accumulator
                if (element_count == 0) begin
                    accumulator <= mem1_input * mem2_input;
                end else begin
                    accumulator <= accumulator + (mem1_input * mem2_input);
                end
                
                // Check if vector is complete after processing the last element
                if (element_count == VECTOR_WIDTH - 1) begin
                    element_count <= 0;
                    vector_complete <= 1;
                end else begin
                    element_count <= element_count + 1;
                end
            end else if (vector_complete) begin
                // Pipeline the result through a few cycles
                result_delay <= result_delay + 1;
                if (result_delay == 1) begin
                    dot_product_result <= accumulator;
                    result_valid <= 1;
                    processing_done <= 1;
                    // Reset for next vector
                    accumulator <= 0;
                    vector_complete <= 0;
                    result_delay <= 0;
                end
            end else if (!data_valid && data_valid_prev) begin
                // Reset when data_valid goes from high to low (end of vector)
                result_valid <= 0;
                processing_done <= 0;
                // Reset accumulator for new vector
                accumulator <= 0;
                vector_complete <= 0;
                result_delay <= 0;
            end else begin
                result_valid <= 0;
                processing_done <= 0;
            end
        end
    end

endmodule