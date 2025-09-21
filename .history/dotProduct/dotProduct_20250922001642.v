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

    reg [DATA_WIDTH-1:0] stage_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] stage_b [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] stage_product [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] stage_accumulator [0:VECTOR_WIDTH-1];
    reg stage_valid [0:VECTOR_WIDTH-1];
    reg stage_vector_done [0:VECTOR_WIDTH-1];
    
    reg [2:0] current_element;
    reg vector_processing;
    reg [RESULT_WIDTH-1:0] final_accumulator;

    always @(posedge clk ) begin
        if (!rst_n) begin
            stage_a[0] <= 0;
            stage_b[0] <= 0;
            stage_product[0] <= 0;
            stage_accumulator[0] <= 0;
            stage_valid[0] <= 0;
            stage_vector_done[0] <= 0;
        end else if (data_valid && vector_processing) begin
            stage_a[0] <= mem1_input;
            stage_b[0] <= mem2_input;
            stage_product[0] <= mem1_input * mem2_input;
            stage_valid[0] <= 1;
            stage_accumulator[0] <= (current_element == 0) ? mem1_input * mem2_input : final_accumulator + (mem1_input * mem2_input);
            stage_vector_done[0] <= (current_element == (VECTOR_WIDTH-1));
        end else begin
            stage_valid[0] <= 0;
        end
    end

    genvar i;
    generate
        for (i = 1; i < VECTOR_WIDTH; i = i + 1) begin : pipeline_stages
            always @(posedge clk ) begin
                if (!rst_n) begin
                    stage_a[i] <= 0;
                    stage_b[i] <= 0;
                    stage_product[i] <= 0;
                    stage_accumulator[i] <= 0;
                    stage_valid[i] <= 0;
                    stage_vector_done[i] <= 0;
                end else begin
                    stage_a[i] <= stage_a[i-1];
                    stage_b[i] <= stage_b[i-1];
                    stage_product[i] <= stage_product[i-1];
                    stage_accumulator[i] <= stage_accumulator[i-1];
                    stage_valid[i] <= stage_valid[i-1];
                    stage_vector_done[i] <= stage_vector_done[i-1];
                end
            end
        end
    endgenerate

    always @(posedge clk ) begin
        if (!rst_n) begin
            dot_product_result <= 0;
            result_valid <= 0;
            processing_done <= 0;
        end else if (stage_valid[VECTOR_WIDTH-1] && stage_vector_done[VECTOR_WIDTH-1]) begin
            dot_product_result <= stage_accumulator[VECTOR_WIDTH-1];
            result_valid <= 1;
            processing_done <= 1;
        end else begin
            result_valid <= 0;
            processing_done <= 0;
        end
    end

    always @(posedge clk ) begin
        if (!rst_n) begin
            current_element <= 0;
            vector_processing <= 0;
            final_accumulator <= 0;
        end else if (data_valid) begin
            if (current_element == 0 && !vector_processing) begin
                vector_processing <= 1;
                current_element <= 1;
                final_accumulator <= mem1_input * mem2_input;
            end else if (current_element < (VECTOR_WIDTH-1)) begin
                current_element <= current_element + 1;
                final_accumulator <= final_accumulator + (mem1_input * mem2_input);
            end else begin
                current_element <= 0;
                vector_processing <= 0;
                final_accumulator <= 0;
            end
        end
    end

endmodule
