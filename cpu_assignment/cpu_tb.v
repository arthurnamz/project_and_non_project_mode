// Testbench for Simple CPU
`timescale 1ns/1ps

module cpu_tb;

    // Parameters
    parameter DATA_WIDTH = 10;
    parameter MEM_DEPTH = 8;
    parameter ADDR_WIDTH = 3;

    // Testbench signals
    reg clk;
    reg rstn;
    reg start;
    wire done;
    
    // Instantiate the CPU Top Module
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
    
    // Clock generation (50 MHz, 20ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Initialize memories with test data
    initial begin
        // Wait a bit for reset
        #5;
        
        // Initialize Data Memory
       dut_data_mem.memory[0] = 8'd5;
       dut_data_mem.memory[1] = 8'd3;
       dut_data_mem.memory[2] = 8'd0;
       dut_data_mem.memory[3] = 8'd0;
       dut_data_mem.memory[4] = 8'd0;
       dut_data_mem.memory[5] = 8'd0;
       dut_data_mem.memory[6] = 8'd0;
       dut_data_mem.memory[7] = 8'd0;

       dut_instr_mem.memory[0] = 10'b0100010000;
        
       dut_instr_mem.memory[1] = 10'b0110010100;
        
       dut_instr_mem.memory[2] = 10'b1000000101;
        
       dut_instr_mem.memory[3] = 10'b1011000110;
        
       dut_instr_mem.memory[4] = 10'b1100001011;
        
       dut_instr_mem.memory[5] = 10'b1110000000;
        
        dut_instr_mem.memory[6] = 10'b1111111110;
        
        dut_instr_mem.memory[7] = 10'b0000000000;
    end
    
    initial begin
        rstn = 0;
        start = 0;
        #25;
        
        rstn = 1;
        #20;
        
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
        
        $display("\n=== Starting CPU Execution ===\n");
        start = 1;
        #20;
        start = 0;
        
        wait(done);
        
        $display("\n\n=== Execution Complete ===");
        $display("\nFinal Data Memory:");
        $display("Address\tValue\tExpected\tStatus");
        $display("---------------------------------------");
        
        // Verify results
        $display("   0\t%d\t5\t\t%s", uut.uut_data_mem.mem[0], (uut.uut_data_mem.mem[0] == 5) ? "PASS" : "FAIL");
        $display("   1\t%d\t3\t\t%s", uut.uut_data_mem.mem[1], (uut.uut_data_mem.mem[1] == 3) ? "PASS" : "FAIL");
        $display("   2\t%d\t8\t\t%s", uut.uut_data_mem.mem[2], (uut.uut_data_mem.mem[2] == 8) ? "PASS" : "FAIL");  // 5+3=8
        $display("   3\t%d\t11\t\t%s", uut.uut_data_mem.mem[3], (uut.uut_data_mem.mem[3] == 11) ? "PASS" : "FAIL"); // 8+3=11
        $display("   4\t%d\t247\t\t%s", uut.uut_data_mem.mem[4], (uut.uut_data_mem.mem[4] == 247) ? "PASS" : "FAIL"); // ~8=247
        $display("   5\t%d\t2\t\t%s", uut.uut_data_mem.mem[5], (uut.uut_data_mem.mem[5] == 2) ? "PASS" : "FAIL");  // (11+247)%256=2
        $display("   6\t%d\t253\t\t%s", uut.uut_data_mem.mem[6], (uut.uut_data_mem.mem[6] == 253) ? "PASS" : "FAIL"); // ~2=253
        $display("   7\t%d\t10\t\t%s", uut.uut_data_mem.mem[7], (uut.uut_data_mem.mem[7] == 10) ? "PASS" : "FAIL"); // 5+5=10
        
        // Summary
        $display("\n=== Test Summary ===");
        if (uut.uut_data_mem.mem[2] == 8 && 
            uut.uut_data_mem.mem[3] == 11 && 
            uut.uut_data_mem.mem[4] == 247 && 
            uut.uut_data_mem.mem[5] == 2 && 
            uut.uut_data_mem.mem[6] == 253 && 
            uut.uut_data_mem.mem[7] == 10) begin
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
                3'd0: get_state_name = "IDLE     ";
                3'd1: get_state_name = "FETCH    ";
                3'd2: get_state_name = "DEC      ";
                3'd3: get_state_name = "LOAD_OP  ";
                3'd4: get_state_name = "EXEC     ";
                3'd5: get_state_name = "WRITE_BACK";
                default: get_state_name = "UNKNOWN  ";
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
