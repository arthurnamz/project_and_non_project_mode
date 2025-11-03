`timescale 1ns/1ps

module fsm
#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5
)
(
    input clk,
    input rst_n,

    // input interface
    input memIn_write_en,
    input [ADDR_WIDTH-1:0]memIn_write_address,
    input [DATA_WIDTH-1:0]memIn_data_in,

   // output interface
    output reg memOut_write_en,
    output reg [ADDR_WIDTH-1:0]memOut_write_address,
    output reg [DATA_WIDTH-1:0]memOut_data,
    output reg ready
);
//using GRAY's code to encode the state
localparam IDLE = 3'b000;
localparam ADDR = 3'b001;
localparam DATA = 3'b011;
localparam WRITE = 3'b010;
localparam WAIT = 3'b110;

reg [2:0] state;

reg [ADDR_WIDTH-1:0] addr_reg;
reg [DATA_WIDTH-1:0] data_reg;

always @(posedge clk) begin
    if (!rst_n) begin
        state <= IDLE;
    end else begin
      case (state)
        IDLE: 
            if (memIn_write_en) begin
                state <= ADDR;
            end

        ADDR:
            state <= DATA;

        DATA:
            state <= WRITE;

        WRITE:
            state <= WAIT;

        WAIT:
            state <= IDLE;
      endcase
    end
end

always @(*) begin
    case (state)
        IDLE:begin
            ready <= 1'b1;
            memOut_write_en <= 1'b0;
        end

        ADDR: begin
            ready <= 1'b0;
            addr_reg <= memIn_write_address;
        end

        DATA: begin
            data_reg <= memIn_data_in;
        end

        WRITE:begin
            memOut_write_en <= 1'b1;
            memOut_write_address <= addr_reg;
            memOut_data <= data_reg;
        end

        WAIT:begin
            memOut_write_en <= 1'b0;
        end

    endcase
end

endmodule
