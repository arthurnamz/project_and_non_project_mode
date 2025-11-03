// Testbench for Simple CPU
`timescale 1ns/1ps

module cpu_tb;

    // Parameters
    parameter DATA_WIDTH = 10;
    parameter MEM_DEPTH = 8;
    parameter ADDR_WIDTH = 3;
    parameter PERIOD = 10;

    // Testbench signals
    reg clk = 0;
    reg rstn;
    reg start;
    wire done;

    cpu_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .MEM_DEPTH(MEM_DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .rstn(rstn),
        .start(start),
        .done(done)
    );
    
    always #(PERIOD/2) clk = ~clk;
    

    initial begin
        // Wait a bit for reset
        #5;
        
        // Initialize Data Memory
        uut.uut_data_mem.mem[0] = 8'd5;
        uut.uut_data_mem.mem[1] = 8'd3;
        uut.uut_data_mem.mem[2] = 8'd0;
        uut.uut_data_mem.mem[3] = 8'd0;
        uut.uut_data_mem.mem[4] = 8'd0;
        uut.uut_data_mem.mem[5] = 8'd0;
        uut.uut_data_mem.mem[6] = 8'd0;
        uut.uut_data_mem.mem[7] = 8'd0;
        
        // Initialize Instruction Memory
        // Format: [9:7 = res | 6:4 = op2 | 3:1 = op1 | 0 = opcode]
        // opcode: 0=ADD, 1=NOT
        
        // Instruction 0: ADD data[0] + data[1] -> data[2]
        // res=2, op2=1, op1=0, opcode=0 => [010|001|000|0] = 10'b0100010000
        uut.uut_instr_mem.mem[0] = 10'b0100010000;
        
        // Instruction 1: ADD data[2] + data[1] -> data[3]
        // res=3, op2=1, op1=2, opcode=0 => [011|001|010|0] = 10'b0110010100
        uut.uut_instr_mem.mem[1] = 10'b0110010100;
        
        // Instruction 2: NOT ~data[2] -> data[4]
        // res=4, op2=X, op1=2, opcode=1 => [100|000|010|1] = 10'b1000000101
        uut.uut_instr_mem.mem[2] = 10'b1000000101;
        
        // Instruction 3: ADD data[3] + data[4] -> data[5]
        // res=5, op2=4, op1=3, opcode=0 => [101|100|011|0] = 10'b1011000110
        uut.uut_instr_mem.mem[3] = 10'b1011000110;
        
        // Instruction 4: NOT ~data[5] -> data[6]
        // res=6, op2=X, op1=5, opcode=1 => [110|000|101|1] = 10'b1100001011
        uut.uut_instr_mem.mem[4] = 10'b1100001011;
        
        // Instruction 5: ADD data[0] + data[0] -> data[7]
        // res=7, op2=0, op1=0, opcode=0 => [111|000|000|0] = 10'b1110000000
        uut.uut_instr_mem.mem[5] = 10'b1110000000;
        
        // Instruction 6: ADD data[7] + data[7] -> data[7] (dummy)
        // res=7, op2=7, op1=7, opcode=0 => [111|111|111|0] = 10'b1111111110
        uut.uut_instr_mem.mem[6] = 10'b1111111110;
        
        // Instruction 7: ADD data[0] + data[0] -> data[0] (dummy)
        // res=0, op2=0, op1=0, opcode=0 => [000|000|000|0] = 10'b0000000000
        uut.uut_instr_mem.mem[7] = 10'b0000000000;
    end
    
    // Test sequence
    initial begin

        // Display header
        $display("\n=== Simple CPU Testbench ===");
        $display("Time\tState\t\tPC\tOp\tOp1\tOp2\tRes\tResult");
        $display("=================================================================");
        
        // Initialize signals
        rstn = 0;
        start = 0;
        
        // Hold reset for a few clock cycles
        #25;
        
        // Release reset
        rstn = 1;
        #20;
        
        // Display initial data memory
        $display("\nInitial Data Memory:");
        $display("Address\tValue");
        $display("---------------");
        $display("   0\t%d", uut.uut_data_mem.mem[0]);
        $display("   1\t%d", uut.uut_data_mem.mem[1]);
        $display("   2\t%d", uut.uut_data_mem.mem[2]);
        $display("   3\t%d", uut.uut_data_mem.mem[3]);
        $display("   4\t%d", uut.uut_data_mem.mem[4]);
        $display("   5\t%d", uut.uut_data_mem.mem[5]);
        $display("   6\t%d", uut.uut_data_mem.mem[6]);
        $display("   7\t%d", uut.uut_data_mem.mem[7]);
        
        // Display instruction memory
        $display("\nInstruction Memory:");
        $display("PC\tInstruction\tOpcode\tOp1\tOp2\tRes\tDescription");
        $display("=============================================================================");
        $display(" 0\t%b\t%s\t%d\t%d\t%d\tADD data[0] + data[1] -> data[2]", 
                 uut.uut_instr_mem.mem[0], (uut.uut_instr_mem.mem[0][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[0][3:1], uut.uut_instr_mem.mem[0][6:4], uut.uut_instr_mem.mem[0][9:7]);
        $display(" 1\t%b\t%s\t%d\t%d\t%d\tADD data[2] + data[1] -> data[3]",
                 uut.uut_instr_mem.mem[1], (uut.uut_instr_mem.mem[1][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[1][3:1], uut.uut_instr_mem.mem[1][6:4], uut.uut_instr_mem.mem[1][9:7]);
        $display(" 2\t%b\t%s\t%d\t%d\t%d\tNOT ~data[2] -> data[4]",
                 uut.uut_instr_mem.mem[2], (uut.uut_instr_mem.mem[2][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[2][3:1], uut.uut_instr_mem.mem[2][6:4], uut.uut_instr_mem.mem[2][9:7]);
        $display(" 3\t%b\t%s\t%d\t%d\t%d\tADD data[3] + data[4] -> data[5]",
                 uut.uut_instr_mem.mem[3], (uut.uut_instr_mem.mem[3][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[3][3:1], uut.uut_instr_mem.mem[3][6:4], uut.uut_instr_mem.mem[3][9:7]);
        $display(" 4\t%b\t%s\t%d\t%d\t%d\tNOT ~data[5] -> data[6]",
                 uut.uut_instr_mem.mem[4], (uut.uut_instr_mem.mem[4][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[4][3:1], uut.uut_instr_mem.mem[4][6:4], uut.uut_instr_mem.mem[4][9:7]);
        $display(" 5\t%b\t%s\t%d\t%d\t%d\tADD data[0] + data[0] -> data[7]",
                 uut.uut_instr_mem.mem[5], (uut.uut_instr_mem.mem[5][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[5][3:1], uut.uut_instr_mem.mem[5][6:4], uut.uut_instr_mem.mem[5][9:7]);
        $display(" 6\t%b\t%s\t%d\t%d\t%d\tADD data[7] + data[7] -> data[7]",
                 uut.uut_instr_mem.mem[6], (uut.uut_instr_mem.mem[6][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[6][3:1], uut.uut_instr_mem.mem[6][6:4], uut.uut_instr_mem.mem[6][9:7]);
        $display(" 7\t%b\t%s\t%d\t%d\t%d\tADD data[0] + data[0] -> data[0]",
                 uut.uut_instr_mem.mem[7], (uut.uut_instr_mem.mem[7][0] ? "NOT" : "ADD"),
                 uut.uut_instr_mem.mem[7][3:1], uut.uut_instr_mem.mem[7][6:4], uut.uut_instr_mem.mem[7][9:7]);
        
        // Start CPU execution
        $display("\n=== Starting CPU Execution ===\n");
        start = 1;
        #20;
        start = 0;
        
        // Wait for execution to complete
        wait(done);
        
        // Display final data memory
        $display("\n\n=== Execution Complete ===");
        $display("\nFinal Data Memory:");
        $display("Address\tValue\tExpected\tStatus");
        $display("---------------------------------------");
        
        // Verify results
        $display("   0\t%d\t10\t\t%s", uut.uut_data_mem.mem[0], (uut.uut_data_mem.mem[0] == 10) ? "PASS" : "FAIL"); // 5+5=10 (instr 7)
        $display("   1\t%d\t3\t\t%s", uut.uut_data_mem.mem[1], (uut.uut_data_mem.mem[1] == 3) ? "PASS" : "FAIL");
        $display("   2\t%d\t8\t\t%s", uut.uut_data_mem.mem[2], (uut.uut_data_mem.mem[2] == 8) ? "PASS" : "FAIL");  // 5+3=8
        $display("   3\t%d\t11\t\t%s", uut.uut_data_mem.mem[3], (uut.uut_data_mem.mem[3] == 11) ? "PASS" : "FAIL"); // 8+3=11
        $display("   4\t%d\t247\t\t%s", uut.uut_data_mem.mem[4], (uut.uut_data_mem.mem[4] == 247) ? "PASS" : "FAIL"); // ~8=247
        $display("   5\t%d\t2\t\t%s", uut.uut_data_mem.mem[5], (uut.uut_data_mem.mem[5] == 2) ? "PASS" : "FAIL");  // (11+247)%256=2
        $display("   6\t%d\t253\t\t%s", uut.uut_data_mem.mem[6], (uut.uut_data_mem.mem[6] == 253) ? "PASS" : "FAIL"); // ~2=253
        $display("   7\t%d\t20\t\t%s", uut.uut_data_mem.mem[7], (uut.uut_data_mem.mem[7] == 20) ? "PASS" : "FAIL"); // 10+10=20 (instr 6)
        
        // Summary
        $display("\n=== Test Summary ===");
        if (uut.uut_data_mem.mem[0] == 10 && 
            uut.uut_data_mem.mem[1] == 3 && 
            uut.uut_data_mem.mem[2] == 8 && 
            uut.uut_data_mem.mem[3] == 11 && 
            uut.uut_data_mem.mem[4] == 247 && 
            uut.uut_data_mem.mem[5] == 2 && 
            uut.uut_data_mem.mem[6] == 253 && 
            uut.uut_data_mem.mem[7] == 20) begin
            $display("ALL TESTS PASSED!");
        end else begin
            $display("SOME TESTS FAILED!");
        end
        
        // Wait a bit and finish
        #100;
        $display("\nSimulation completed at time %0t ns", $time);
        $finish;
    end
    
    // Monitor state changes
    always @(posedge clk) begin
        if (uut.uut_cpu.state != 0 && rstn) begin  // Don't print IDLE state or during reset
            $display("%0t\t%s\t%d\t%s\t%d\t%d\t%d\t%d",
                     $time,
                     get_state_name(uut.uut_cpu.state),
                     uut.uut_cpu.pc,
                     (uut.uut_cpu.opCode ? "NOT" : "ADD"),
                     uut.uut_cpu.op1,
                     uut.uut_cpu.op2,
                     uut.uut_cpu.res,
                     uut.uut_cpu.result);
        end
    end
    
    // Function to convert state encoding to string
    function [79:0] get_state_name;
        input [2:0] state;
        begin
            case (state)
                3'd0: get_state_name = "IDLE      ";
                3'd1: get_state_name = "FETCH     ";
                3'd2: get_state_name = "DEC       ";
                3'd3: get_state_name = "LOAD_OP   ";
                3'd4: get_state_name = "LOAD_WAIT ";
                3'd5: get_state_name = "EXEC      ";
                3'd6: get_state_name = "WRITE_BACK";
                default: get_state_name = "UNKNOWN   ";
            endcase
        end
    endfunction
    
    // Timeout watchdog
    initial begin
        #50000;
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule
