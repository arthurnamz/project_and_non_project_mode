`timescale 1ns / 1ps

module top_level_wrapper_tb;

    parameter DATA_WIDTH = 32;
    parameter VECTOR_WIDTH = 4;
    parameter VECTOR_ELEMENT_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    parameter MEM_SIZE = 32;
    parameter RESULT_WIDTH = 2*VECTOR_ELEMENT_WIDTH;
    parameter PERIOD = 10;
    parameter TEST_COUNT = 12;

    // Clock and Reset
    reg clk = 0;
    reg rst_n;
    
    reg start_processing;
    
    reg write_en1;
    reg [ADDR_WIDTH-1:0]write_address1;
    reg [DATA_WIDTH-1:0]data_in1;

    reg write_en2;
    reg [ADDR_WIDTH-1:0]write_address2;
    reg [DATA_WIDTH-1:0]data_in2;

    reg read_en3;
    reg [ADDR_WIDTH-1:0]read_address3;
    wire [DATA_WIDTH-1:0] data_out3;
    
    

    integer i;

    // Instantiate the top-level wrapper
    top_level_wrapper #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .VECTOR_ELEMENT_WIDTH(VECTOR_ELEMENT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(MEM_SIZE),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) u_top_level_wrapper (
        .clk(clk),
        .rst_n(rst_n),
        .start_processing(start_processing),
        .write_en1(write_en1),
        .write_address1(write_address1),
        .data_in1(data_in1),
        .write_en2(write_en2),
        .write_address2(write_address2),
        .data_in2(data_in2),
        .read_en3(read_en3),
        .read_address3(read_address3),
        .data_out3(data_out3)
    );

    always #(PERIOD/2) clk = ~clk;

    reg [DATA_WIDTH-1:0] golden_mem3 [0:MEM_SIZE-1];
    reg [DATA_WIDTH-1:0] expected_result;
    
    function [RESULT_WIDTH-1:0] calculate_expected_dot_product;
        input [DATA_WIDTH-1:0] vector_a;
        input [DATA_WIDTH-1:0] vector_b;
        reg [VECTOR_ELEMENT_WIDTH-1:0] a0, a1, a2, a3;
        reg [VECTOR_ELEMENT_WIDTH-1:0] b0, b1, b2, b3;
        reg [RESULT_WIDTH-1:0] result;
        begin
            a0 = vector_a[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            a1 = vector_a[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            a2 = vector_a[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            a3 = vector_a[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            b0 = vector_b[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            b1 = vector_b[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            b2 = vector_b[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            b3 = vector_b[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH];
            result = (a0 * b0) + (a1 * b1) + (a2 * b2) + (a3 * b3);
            calculate_expected_dot_product = result;
        end
    endfunction

    //check if the data_out3 is correct
    always @(posedge clk) begin
        if (read_en3) begin
            if (data_out3 !== golden_mem3[read_address3]) begin
                $error("Time=%0t FAIL", $time);
            end else begin
                $display("Time=%0t PASS", $time);
            end
        end
    end

    initial begin
        rst_n = 0;
        start_processing = 0;
        write_en1 = 0;
        write_address1 = 0;
        data_in1 = 0;
        write_en2 = 0;
        write_address2 = 0;
        data_in2 = 0;
        read_en3 = 0;
        read_address3 = 0;
        read_address3 = 0;
        
        #20 rst_n = 1;
        
        
        for (i = 0; i < TEST_COUNT; i = i + 1) begin
            @(posedge clk);
            write_en1 = 1;
            write_address1 = i;
            data_in1 = {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i};
            @(posedge clk);
            write_en1 = 0;
            
            
            @(posedge clk);
            write_en2 = 1;
            write_address2 = i;
            data_in2 = {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i}; 
            @(posedge clk);
            write_en2 = 0;
        end
        
        #20;
        
        @(posedge clk);
        start_processing = 1;
        
        #20;
         
        for (i = 0; i < TEST_COUNT; i = i + 1) begin
           repeat(2) @(posedge clk);      
            read_en3 = 1;
            read_address3 = i;
            @(posedge clk);
            read_en3 = 0;
                       
           
            expected_result = calculate_expected_dot_product(
                {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i}, 
                {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i}
            );         
            
            golden_mem3[i] = data_out3;
        end
        
        #20;
       
        
        #100 $finish;
    end
    

    
    initial begin
        $monitor($time, " rst_n=%b start_processing=%b write_en1=%b write_address1=%0d data_in1=%0d write_en2=%b write_address2=%0d data_in2=%0d read_en3=%b read_address3=%0d data_out3=%0d", 
                 rst_n, start_processing, write_en1, write_address1, data_in1, write_en2, write_address2, data_in2, read_en3, read_address3, data_out3);
    end

endmodule
