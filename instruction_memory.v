// Instruction Memory Module
// Read-only memory for storing CPU instructions

`timescale 1ns / 1ps

module instruction_memory #(
    parameter DEPTH = 8,           
    parameter DATA_WIDTH = 10,           
    parameter ADDR_WIDTH = 3
)(
    input clk,
    // rstn removed - not used in synthesizable RAM template
    input rd_en,                          
    input [ADDR_WIDTH-1:0] addr,       
    output reg [DATA_WIDTH-1:0] data_out          
);

    // Memory array - stores instructions
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read operation
    always @(posedge clk) begin
        if (rd_en) begin
            data_out <= mem[addr];
        end
    end

endmodule

