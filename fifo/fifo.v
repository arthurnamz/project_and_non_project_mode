`timescale 1ns/1ps

module fifo #(
 parameter DEPTH = 8,
 parameter DATA_WIDTH = 8
)
(
 input clk,
 input rstn,
 input [DATA_WIDTH-1:0] data_in,
 output reg [DATA_WIDTH-1:0] data_out,
 output reg full,
 output reg empty
);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
reg [DEPTH-1:0] wr_ptr;
reg [DEPTH-1:0] rd_ptr;
reg [1:0] rd_cnt = 0;
reg [1:0] wr_cnt = 0;

always @(posedge clk) begin
    if (!rstn) begin
        wr_ptr <= 0;
        wr_cnt <= 0;
    end else begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            wr_cnt <= 1;
    end 
end

always @(posedge clk) begin
    if (!rstn) begin
        rd_ptr <= 0;
        rd_cnt <= 0;
    end else begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            rd_cnt <= 1;
    end
end

always @(*) begin
   assign full = (wr_ptr == rd_ptr && wr_cnt != rd_cnt);
    assign empty = (rd_ptr == wr_ptr && rd_cnt == wr_cnt);
end

endmodule