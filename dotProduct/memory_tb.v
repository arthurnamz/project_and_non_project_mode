
`timescale 1ns / 1ps
module memory_tb;

    parameter DATA_WIDTH = 8;                   
    parameter NUMBER_OF_VECTORS = 4; 
    parameter DEPTH = DATA_WIDTH*NUMBER_OF_VECTORS;  
    parameter ADDR_WIDTH = 5;         
    parameter CLK_PERIOD = 4; // Clock period in ns

    reg clk = 0;
    reg rst_n;
    reg wr_en;
    reg [ADDR_WIDTH-1:0] wr_addr;

    reg [DATA_WIDTH-1:0] data_in;
    reg rd_en;
    reg [ADDR_WIDTH-1:0] rd_addr;
    wire [DATA_WIDTH-1:0] rd_data;          

    integer i;
    // write the dut instantiation here
    memory #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_OF_VECTORS(NUMBER_OF_VECTORS),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .data_in(data_in),
        .rd_en(rd_en),
        .rd_addr(rd_addr),
        .rd_data(rd_data)
    );      

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;


    // function for checking the output data against expected data
    task check_output;
        input [DATA_WIDTH-1:0] expected;
        input [DATA_WIDTH-1:0] actual;
        begin
            if (expected !== actual) begin
                $display("Test Failed: Expected %h, Got %h", expected, actual);
            end else begin
                $display("Test Passed: Expected %h, Got %h", expected, actual);
            end
        end
    endtask

    initial begin
       #10 rst_n = 0;
       #10 rst_n = 1;
       wr_en = 0;
       rd_en = 0;
       wr_addr = 0;
       rd_addr = 0;
       data_in = 0;     

         // Write data to memory
         for (i = 0; i < DEPTH; i = i + 1) begin
              #10;
              wr_en = 1;
                data_in = i + 8'hA0; // Example data pattern   
                wr_addr = i[ADDR_WIDTH-1:0];
            end
            #10;
            wr_en = 0;  
            data_in = 0;
            wr_addr = 0;
            #20;
            // Read data from memory and check
            for (i = 0; i < DEPTH; i = i + 1) begin
                #10;
                rd_en = 1;
                rd_addr = i[ADDR_WIDTH-1:0];
                #10;
                check_output(i + 8'hA0, rd_data); // Check against expected data
            end
            #10;
            rd_en = 0;
            rd_addr = 0;
            #100;
            $finish;
    end
endmodule