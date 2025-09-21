`timescale 1ns / 1ps

module mem_writer #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter ADDR_WIDTH = 4,
    parameter MEM_SIZE = 64,
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH)
)(
    input clk,
    input rst_n,
    input [RESULT_WIDTH-1:0] dot_product_result,
    input result_valid,
    input processing_done,
    output reg write_en,
    output reg [ADDR_WIDTH-1:0] write_address,
    output reg [DATA_WIDTH-1:0] data_in,
    output reg writer_busy,
    output reg writer_done,
    output reg [2:0] result_count
);

    reg [ADDR_WIDTH-1:0] write_addr_counter;
    reg writing_state;
    reg result_received;
    
    mem3 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(MEM_SIZE)
    ) u_mem3 (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_address(write_address),
        .data_in(data_in),
        .read_en(1'b0),
        .read_address({ADDR_WIDTH{1'b0}}),
        .data_out()
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_en <= 1'b0;
            write_address <= {ADDR_WIDTH{1'b0}};
            data_in <= {DATA_WIDTH{1'b0}};
            write_addr_counter <= {ADDR_WIDTH{1'b0}};
            writer_busy <= 1'b0;
            writer_done <= 1'b0;
            result_count <= 3'b0;
            writing_state <= 1'b0;
            result_received <= 1'b0;
        end else begin
            writer_done <= 1'b0;
            write_en <= 1'b0;
            
            if (result_valid && !result_received) begin
                result_received <= 1'b1;
                writing_state <= 1'b1;
                writer_busy <= 1'b1;
                
                write_en <= 1'b1;
                write_address <= write_addr_counter;
                data_in <= dot_product_result[DATA_WIDTH-1:0];
                
                write_addr_counter <= write_addr_counter + 1'b1;
                result_count <= result_count + 1'b1;
                
            end else if (writing_state) begin
                if (processing_done) begin
                    writing_state <= 1'b0;
                    writer_busy <= 1'b0;
                    writer_done <= 1'b1;
                    result_received <= 1'b0;
                end
            end
        end
    end

endmodule
