`timescale 1ns / 1ps

// Pipelined Dot Product Module
// Processes vector elements from mem1 and mem2 in a multi-stage pipeline
// Each stage handles multiplication and accumulation for one vector element

module dotProduct #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)  // Wide enough for accumulation
)(
    input clk,
    input rst_n,
    
    // Input data from memory controllers
    input [DATA_WIDTH-1:0] data_from_mem1,
    input [DATA_WIDTH-1:0] data_from_mem2,
    input data_valid,           // Valid data from memory controllers
    
    // Output
    output reg [RESULT_WIDTH-1:0] dot_product_result,
    output reg result_valid,
    output reg processing_done
);

    // Pipeline stage registers
    reg [DATA_WIDTH-1:0] stage_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] stage_b [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] stage_product [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] stage_accumulator [0:VECTOR_WIDTH-1];
    reg stage_valid [0:VECTOR_WIDTH-1];
    reg [2:0] stage_element_count [0:VECTOR_WIDTH-1];  // Track which element we're processing
    reg stage_vector_done [0:VECTOR_WIDTH-1];
    
    // Control signals
    reg [2:0] current_element;
    reg vector_processing;
    reg [RESULT_WIDTH-1:0] final_accumulator;

    // Stage 0: Input multiplication and initial accumulation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage_a[0] <= {DATA_WIDTH{1'b0}};
            stage_b[0] <= {DATA_WIDTH{1'b0}};
            stage_product[0] <= {RESULT_WIDTH{1'b0}};
            stage_accumulator[0] <= {RESULT_WIDTH{1'b0}};
            stage_valid[0] <= 1'b0;
            stage_element_count[0] <= 3'b0;
            stage_vector_done[0] <= 1'b0;
        end else begin
            if (data_valid && vector_processing) begin
                stage_a[0] <= data_from_mem1;
                stage_b[0] <= data_from_mem2;
                stage_product[0] <= data_from_mem1 * data_from_mem2;  // 16-bit product
                stage_valid[0] <= 1'b1;
                stage_element_count[0] <= current_element;
                
                // Initialize accumulator on first element
                if (current_element == 3'b0) begin
                    stage_accumulator[0] <= data_from_mem1 * data_from_mem2;
                end else begin
                    stage_accumulator[0] <= final_accumulator + (data_from_mem1 * data_from_mem2);
                end
                
                // Mark vector as done on last element
                stage_vector_done[0] <= (current_element == (VECTOR_WIDTH-1));
            end else begin
                stage_valid[0] <= 1'b0;
            end
        end
    end

    // Pipeline stages 1 to VECTOR_WIDTH-1
    genvar i;
    generate
        for (i = 1; i < VECTOR_WIDTH; i = i + 1) begin : pipeline_stages
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    stage_a[i] <= {DATA_WIDTH{1'b0}};
                    stage_b[i] <= {DATA_WIDTH{1'b0}};
                    stage_product[i] <= {RESULT_WIDTH{1'b0}};
                    stage_accumulator[i] <= {RESULT_WIDTH{1'b0}};
                    stage_valid[i] <= 1'b0;
                    stage_element_count[i] <= 3'b0;
                    stage_vector_done[i] <= 1'b0;
                end else begin
                    // Pass data through pipeline
                    stage_a[i] <= stage_a[i-1];
                    stage_b[i] <= stage_b[i-1];
                    stage_product[i] <= stage_product[i-1];
                    stage_accumulator[i] <= stage_accumulator[i-1];
                    stage_valid[i] <= stage_valid[i-1];
                    stage_element_count[i] <= stage_element_count[i-1];
                    stage_vector_done[i] <= stage_vector_done[i-1];
                end
            end
        end
    endgenerate

    // Output stage - final result
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dot_product_result <= {RESULT_WIDTH{1'b0}};
            result_valid <= 1'b0;
            processing_done <= 1'b0;
        end else begin
            if (stage_valid[VECTOR_WIDTH-1] && stage_vector_done[VECTOR_WIDTH-1]) begin
                dot_product_result <= stage_accumulator[VECTOR_WIDTH-1];
                result_valid <= 1'b1;
                processing_done <= 1'b1;
            end else begin
                result_valid <= 1'b0;
                processing_done <= 1'b0;
            end
        end
    end

    // Control logic for element counting and vector processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_element <= 3'b0;
            vector_processing <= 1'b0;
            final_accumulator <= {RESULT_WIDTH{1'b0}};
        end else begin
            if (data_valid) begin
                if (current_element == 3'b0 && !vector_processing) begin
                    // Start new vector
                    vector_processing <= 1'b1;
                    current_element <= 3'b1;
                    final_accumulator <= data_from_mem1 * data_from_mem2;
                end else if (current_element < (VECTOR_WIDTH-1)) begin
                    // Continue processing vector
                    current_element <= current_element + 1'b1;
                    final_accumulator <= final_accumulator + (data_from_mem1 * data_from_mem2);
                end else begin
                    // Vector complete
                    current_element <= 3'b0;
                    vector_processing <= 1'b0;
                    final_accumulator <= {RESULT_WIDTH{1'b0}};
                end
            end
        end
    end

endmodule

