// Generic Memory Module

`timescale 1ns / 1ps

module memory #(
    parameter DEPTH = 8,           
    parameter DATA_WIDTH = 10,           
    parameter ADDR_WIDTH = 4       
)(
    input clk,
    input rstn,
    input wr_en,
    input rd_en,                          
    input [ADDR_WIDTH-1:0] addr,       
    input [DATA_WIDTH-1:0] data_in,          
    output reg [DATA_WIDTH-1:0] data_out          
);

    // Memory array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    // Write operation
    always @(posedge clk) begin
        if (!rstn) begin
            mem[addr] <= {DATA_WIDTH{1'b0}};
        end else begin
            if (wr_en) begin
                mem[addr] <= data_in;
            end
        end
    end

    // Read operation
    always @(posedge clk) begin
        if(!rstn) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end else begin
            if (rd_en) begin
                data_out <= mem[addr];
            end
        end
    end

endmodule

