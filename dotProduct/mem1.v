
`timescale 1ns/1ps

module mem1
#(
    parameter DATA_WIDTH = 8,
    parameter VETOR_WIDTH = 4,
    parameter DEPTH = VETOR_WIDTH  * DATA_WIDTH,
    parameter ADDR_WIDTH = clog2(DEPTH)

)
(
    input  wire                     clk,
    input  wire                     rst_n,     


    input  wire                     wr_en,
    input  wire [ADDR_WIDTH-1:0]    wr_addr,
    input  wire [DATA_WIDTH-1:0]    datain,

    input  wire                     rd_en,
    input  wire [ADDR_WIDTH-1:0]    rd_addr,
    output reg  [DATA_WIDTH-1:0]    data_out
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always @(posedge clk) begin
        if(!rst_n) begin
            mem[0] <= {DATA_WIDTH{1'b0}};
        end
        else if(wr_en) begin
            mem[wr_addr] <= datain;
        end
    end     

    always @(posedge clk) begin
        if(!rst_n) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end
        else if(rd_en) begin
            data_out <= mem[rd_addr];
        end
    end 

    
     function integer clog2;
        input integer value;
        integer i;
        begin
            clog2 = 0;
            for (i = value - 1; i > 0; i = i >> 1)
            clog2 = clog2 + 1;
        end
    endfunction
endmodule
