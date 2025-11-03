
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

   // Data Memory Interface
   output reg [ADDR_WIDTH-1:0] data_mem_addr,
   output reg data_mem_rd_en,
   output reg data_mem_wr_en,
   output reg [7:0] data_mem_data_in,
   input [7:0] data_mem_data_out
);

parameter IDLE = 0;
parameter FETCH = 1;
parameter DEC = 2;
parameter LOAD_OP = 3;
parameter EXEC = 4;
parameter WRITE_BACK = 5;

reg [2:0] state;

// Decoded addresses
reg opCode;
reg [2:0] op1;
reg [2:0] op2;
reg [2:0] res;

// Data registers
reg [7:0] operand1;
reg [7:0] operand2;
reg [7:0] result;

// Program Counter
reg [2:0] pc;

reg load_phase;  


always@(posedge clk) begin
	if(~rstn) begin
		state <= IDLE;
		pc <= 3'd0;
		done <= 1'b0;
		
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
                load_phase <= 1'b0;
                state <= LOAD_OP;
            end
            
            LOAD_OP: begin
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
                if(pc == 3'd7) begin
                    state <= IDLE;
                    done <= 1'b1;
                    pc <= 3'd0;
                end else begin
                    pc <= pc + 1'b1;
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
    instr_mem_addr = pc;
    instr_mem_rd_en = 1'b0;
    opCode = 1'b0;
    op1 = 3'd0;
    op2 = 3'd0;
    res = 3'd0;
    operand1 = 8'd0;
    operand2 = 8'd0;
    result = 8'd0;
    load_phase = 1'b0;
    data_mem_addr = 3'd0;
    data_mem_rd_en = 1'b0;
    data_mem_wr_en = 1'b0;
    data_mem_data_in = 8'd0;
    
	case(state)
        FETCH: begin
            instr_mem_addr = pc;
            instr_mem_rd_en = 1'b1;
        end

        DEC: begin
            opCode = instr_mem_data_out[0];
            op1 = instr_mem_data_out[3:1];
            op2 = instr_mem_data_out[6:4];
            res = instr_mem_data_out[9:7];
        end
        
        LOAD_OP: begin
            data_mem_rd_en = 1'b1;
            if (~load_phase) begin
                data_mem_addr = op1;
            end else begin
                data_mem_addr = op2;
            end
        end

        EXEC: begin
            if (~load_phase) begin
                operand1 = data_mem_data_out;
                load_phase = 1'b1;
            end else begin
                operand2 = data_mem_data_out;
            end
        end
        
        WRITE_BACK: begin
            data_mem_wr_en = 1'b1;
            data_mem_addr = res;
            data_mem_data_in = result;
        end
	endcase
end
endmodule
