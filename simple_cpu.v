// Simple CPU with FSM-based architecture
// Instruction Format (10 bits): [result(3) | operand2(3) | operand1(3) | opcode(1)]
// Bit arrangement: [9:7 = res | 6:4 = op2 | 3:1 = op1 | 0 = opcode]
// Opcode: 0 = ADD, 1 = NOT

module cpu #(
    parameter DATA_WIDTH = 10,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = 4  
)(
    input clk,
    input rstn,
    input start,
    output reg done
);


    // FSM States
    localparam IDLE       = 3'd0;
    localparam FETCH      = 3'd1;
    localparam DECODE     = 3'd2;
    localparam LOAD       = 3'd3;
    localparam EXECUTE    = 3'd4;
    localparam WRITEBACK  = 3'd5;

    // Opcode definitions
    localparam OP_ADD = 1'b0;
    localparam OP_NOT = 1'b1;
    
    // FSM States
    reg [2:0] state, next_state;

    // Program counter
    reg [ADDR_WIDTH-1:0] pc;


    // Instantiate instruction memory
    memory #(
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) instr_mem (
        .clk(clk),
        .rstn(rstn),
        .wr_en(),
        .rd_en(),
        .addr(),
        .data_in(),
        .data_out()
    );
    
    // Instantiate data memory
    memory #(
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) data_mem (
        .clk(clk),
        .rstn(rstn),
        .wr_en(),
        .rd_en(),
        .addr(),
        .data_in(),
        .data_out()
    );
    
    
    // Next state logic
    always @(*) begin
        next_state = state;
        
        case (state)
            IDLE: begin
                if (start)
                    next_state = FETCH;
            end
            
            FETCH: begin
                next_state = DECODE;
            end
            
            DECODE: begin
                next_state = LOAD;
            end
            
            LOAD: begin
                if (load_stage == 1'b1) begin
                    next_state = EXECUTE;
                end
            end
            
            EXECUTE: begin
                next_state = WRITEBACK;
            end
            
            WRITEBACK: begin
                if (pc == 3'd7) // All instructions executed
                    next_state = IDLE;
                else
                    next_state = FETCH;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    

endmodule
