`timescale 1ns/1ps

module mem_controller #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst_n,
    input start,
    input in_valid,
    input [DATA_WIDTH-1:0] data_a,
    input [DATA_WIDTH-1:0] data_b,
    output reg busy,
    output reg done,
    input rd_en_a,
    input [ADDR_WIDTH-1:0] rd_addr_a,
    output wire [DATA_WIDTH-1:0] dout_a,
    input rd_en_b,
    input [ADDR_WIDTH-1:0] rd_addr_b,
    output wire [DATA_WIDTH-1:0] dout_b
);

    reg [ADDR_WIDTH-1:0] wr_addr_q;
    reg wr_en_q;
    reg [DATA_WIDTH-1:0] din_a_q, din_b_q;

    always @(posedge clk) begin
        if (!rst_n) begin
            busy <= 1'b0;
            done <= 1'b0;
            wr_addr_q <= {ADDR_WIDTH{1'b0}};
            wr_en_q <= 1'b0;
            din_a_q <= {DATA_WIDTH{1'b0}};
            din_b_q <= {DATA_WIDTH{1'b0}};
        end else begin
            done <= 1'b0;
            wr_en_q <= 1'b0;

            if (start && !busy) begin
                busy <= 1'b1;
                wr_addr_q <= {ADDR_WIDTH{1'b0}};
            end

            if (busy && in_valid) begin
                wr_en_q <= 1'b1;
                din_a_q <= data_a;
                din_b_q <= data_b;

                if (wr_addr_q == DEPTH-1) begin
                    busy <= 1'b0;
                    done <= 1'b1;
                end
                wr_addr_q <= wr_addr_q + 1'b1;
            end
        end
    end

    mem1 #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .MEM_SIZE(DEPTH)) u_mem1 (
        .clk(clk), .rst_n(rst_n),
        .write_en(wr_en_q), .write_address(wr_addr_q), .data_in(din_a_q),
        .read_en(rd_en_a), .read_address(rd_addr_a), .data_out(dout_a)
    );

    mem2 #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .MEM_SIZE(DEPTH)) u_mem2 (
        .clk(clk), .rst_n(rst_n),
        .write_en(wr_en_q), .write_address(wr_addr_q), .data_in(din_b_q),
        .read_en(rd_en_b), .read_address(rd_addr_b), .data_out(dout_b)
    );

endmodule
