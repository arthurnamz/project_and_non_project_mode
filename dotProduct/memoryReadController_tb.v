// write testbench for memoryReadController module here it should be similar to memory_tb.v but adapted for memoryReadController module 
`timescale 1ns / 1ps
module memoryReadController_tb;
    parameter DATA_WIDTH = 8;                   
    parameter NUMBER_OF_VECTORS = 4; 
    parameter DEPTH = DATA_WIDTH*NUMBER_OF_VECTORS;  
    parameter ADDR_WIDTH = 5;         
    parameter CLK_PERIOD = 4; // Clock period in ns

    reg clk = 0;
    reg rst_n;
    reg start;

    wire rd_en_mem1;
    wire rd_en_mem2;
    wire [ADDR_WIDTH-1:0] rd_addr_mem1;
    wire [ADDR_WIDTH-1:0] rd_addr_mem2;

    wire [DATA_WIDTH-1:0] data_from_mem1;          
    wire [DATA_WIDTH-1:0] data_from_mem2;          
    wire [DATA_WIDTH-1:0] data_out1;
    wire [DATA_WIDTH-1:0] data_out2;
    wire done;

    integer i;

    // instantiate the dut here
    memoryReadController #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_OF_VECTORS(NUMBER_OF_VECTORS),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .rd_en_mem1(rd_en_mem1),
        .rd_en_mem2(rd_en_mem2),
        .rd_addr_mem1(rd_addr_mem1),
        .rd_addr_mem2(rd_addr_mem2),
        .data_from_mem1(data_from_mem1),
        .data_from_mem2(data_from_mem2),
        .data_out1(data_out1),
        .data_out2(data_out2),
        .done(done)
    );      

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;
    // function for checking the output data against expected data
    task check_output;
        input [DATA_WIDTH-1:0] expected1;
        input [DATA_WIDTH-1:0] actual1;
        input [DATA_WIDTH-1:0] expected2;
        input [DATA_WIDTH-1:0] actual2;
        begin
            if (expected1 !== actual1) begin
                $display("Test Failed for data_out1: Expected %h, Got %h", expected1, actual1);
            end else begin
                $display("Test Passed for data_out1: Expected %h, Got %h",      expected1, actual1);                    

            end
            if (expected2 !== actual2) begin
                $display("Test Failed for data_out2: Expected %h, Got %h", expected2, actual2);
            end else begin
                $display("Test Passed for data_out2: Expected %h, Got %h", expected2, actual2);                    
            end
        end
    endtask         

    initial begin
       #10 rst_n = 0;
       #10 rst_n = 1;
       start = 0;

       #10 start = 1; // Start the read operation
       #10 start = 0; // Deassert start

       // Wait for the done signal
       wait(done);
       #10;

       // Check the outputs (assuming memory was pre-loaded with known values)
       for (i = 0; i < NUMBER_OF_VECTORS; i = i + 1) begin
           check_output(i, data_out1, i, data_out2); // Assuming memory contains values equal to their addresses
           #10;
       end
    #100;
       $finish;
    end
endmodule
