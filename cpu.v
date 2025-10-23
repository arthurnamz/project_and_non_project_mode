

`timescale 1ns/1ps


module cpu
#( 
  parameter DATA_WIDTH  = 10,
  parameter MEM_DEPTH  = 8,
  parameter ADDR_WIDTH  = 3
)
( 
   input clk,
   input rstn,
   input start,
   output reg done,

   // Instruction Memory Interface
   output reg [ADDR_WIDTH-1:0] instr_mem_addr,
   output reg instr_mem_rd_en,
   input [DATA_WIDTH-1:0] instr_mem_data_out,

   // Data Memory Interface (Dual-Port Read, Dual-Port Write)
   output reg [ADDR_WIDTH-1:0] data_mem_rd_addr1,
   output reg [ADDR_WIDTH-1:0] data_mem_rd_addr2,
   output reg [ADDR_WIDTH-1:0] data_mem_wr_addr1,
   output reg [ADDR_WIDTH-1:0] data_mem_wr_addr2,
   output reg data_mem_rd_en1,
   output reg data_mem_rd_en2,
   output reg data_mem_wr_en1,
   output reg data_mem_wr_en2,
   output reg [7:0] data_mem_data_in1,
   output reg [7:0] data_mem_data_in2,
   input [7:0] data_mem_data_out1,
   input [7:0] data_mem_data_out2
);

localparam IDLE = 0;
localparam FETCH = 1;
parameter DEC = 2;
localparam LOAD_OP = 3;
localparam LOAD_WAIT = 4;
localparam EXEC = 5;
localparam WRITE_BACK = 6;

reg [2:0] state;

// Decoded addresses
reg opCode;
reg [2:0] op1;
reg [2:0] op2;
reg [2:0] res;

// Data registers (hold actual values from memory)
reg [7:0] operand1;
reg [7:0] operand2;
reg [7:0] result;

// Program Counter
reg [2:0] pc;

always@(posedge clk) begin
	if(~rstn) begin
		state <= IDLE;
		pc <= 3'd0;
		done <= 1'b0;
		opCode <= 1'b0;
		op1 <= 3'd0;
		op2 <= 3'd0;
		res <= 3'd0;
		operand1 <= 8'd0;
		operand2 <= 8'd0;
		result <= 8'd0;
	end else begin
        case (state)
            IDLE: begin
                done <= 1'b0;
                if(start) begin
                    state <= FETCH;
                    pc <= 3'd0;
                end
            end
            
            FETCH: begin
                state <= DEC;
            end
            
            DEC: begin
                opCode <= instr_mem_data_out[0];
                op1 <= instr_mem_data_out[3:1];
                op2 <= instr_mem_data_out[6:4];
                res <= instr_mem_data_out[9:7];
                state <= LOAD_OP;
            end
            
            LOAD_OP: begin
                // Issue read requests to memory
                state <= LOAD_WAIT;
            end
            
            LOAD_WAIT: begin
                // Wait for memory read (1 cycle latency), then capture data
                operand1 <= data_mem_data_out1;
                operand2 <= data_mem_data_out2;
                state <= EXEC;
            end
            
            EXEC: begin
                if(opCode == 1'b0)
                    result <= operand1 + operand2; 
                else
                    result <= ~operand1;            
                state <= WRITE_BACK;
            end
            
            WRITE_BACK: begin
                if(pc == (MEM_DEPTH - 1)) begin
                    state <= IDLE;
                    done <= 1'b1;
                end else begin
                    pc <= pc + 3'b001; 
                    state <= FETCH;
                end
            end
            
            default: begin
                state <= IDLE;
            end
        endcase
    end
end	


always @(*) begin
    // Default values for instruction memory
    instr_mem_addr = pc;
    instr_mem_rd_en = 1'b0;
    
    // Default values for data memory (dual-port read, single-port write)
    data_mem_rd_addr1 = 3'b000;
    data_mem_rd_addr2 = 3'b000;
    data_mem_wr_addr1 = 3'b000;
    data_mem_wr_addr2 = 3'b000;
    data_mem_rd_en1 = 1'b0;
    data_mem_rd_en2 = 1'b0;
    data_mem_wr_en1 = 1'b0;
    data_mem_wr_en2 = 1'b0;  // Always 0 - write port 2 not used
    data_mem_data_in1 = 8'b00000000;
    data_mem_data_in2 = 8'b00000000;
    
	case(state)
        FETCH: begin
            instr_mem_addr = pc;
            instr_mem_rd_en = 1'b1;
        end
        
        LOAD_OP: begin
            // Read both operands simultaneously using dual-port
            data_mem_rd_en1 = 1'b1;
            data_mem_rd_en2 = 1'b1;
            data_mem_rd_addr1 = op1;
            data_mem_rd_addr2 = op2;
        end
        
        LOAD_WAIT: begin
            // Keep read enables active during wait
            data_mem_rd_en1 = 1'b1;
            data_mem_rd_en2 = 1'b1;
            data_mem_rd_addr1 = op1;
            data_mem_rd_addr2 = op2;
        end
        
        WRITE_BACK: begin
            // Write to port 1 (port 2 unused for now)
            data_mem_wr_en1 = 1'b1;
            data_mem_wr_addr1 = res;
            data_mem_data_in1 = result;
        end
	endcase
end


endmodule
