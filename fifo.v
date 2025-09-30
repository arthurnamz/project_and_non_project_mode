`timescale 1ns/1ps

module fifo #(
parameter DEPTH = 8,
parameter DATA_WIDTH = 8
)
(
input clk,
input rstn,
input wr_en,
input rd_en,
input [DATA_WIDTH-1:0] data_in,
output reg [DATA_WIDTH-1:0] data_out,
output  full,
output  empty
);


reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
reg [DEPTH-1:0] wr_ptr;
reg [DEPTH-1:0] rd_ptr;
reg wr_count;
reg rd_count;


always @(posedge clk) begin
   if (!rstn) begin
       wr_ptr <= 0;
       wr_count <= 0;
   end else begin
       if (wr_en && !full) begin
           mem[wr_ptr] <= data_in;
           if (wr_ptr == DEPTH-1) begin
               wr_ptr <= 0;
               wr_count <= ~wr_count;
           end else begin
               wr_ptr <= wr_ptr + 1;
               
           end
       end
   end
end


always @(posedge clk) begin
   if (!rstn) begin
       rd_ptr <= 0;
       rd_count <= 0;
   end else begin
       if (rd_en && !empty) begin
           data_out <= mem[rd_ptr];
           if (rd_ptr == DEPTH-1) begin
               rd_ptr <= 0;
               rd_count <= ~rd_count;
           end else begin
               rd_ptr <= rd_ptr + 1;
               
           end
       end
   end
end

assign full = (wr_ptr == rd_ptr) && (wr_count != rd_count);
assign empty = (wr_ptr == rd_ptr) && (wr_count == rd_count);

endmodule
