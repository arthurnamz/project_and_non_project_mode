`timescale 1ns / 1ps

module top_level_wrapper_tb;

    parameter DATA_WIDTH = 32;
    parameter VECTOR_WIDTH = 4;
    parameter VECTOR_ELEMENT_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    parameter MEM_SIZE = 32;
    parameter RESULT_WIDTH = 2*VECTOR_ELEMENT_WIDTH;
    parameter PERIOD = 10;
    parameter TEST_COUNT = 40;

    // Clock and Reset
    reg clk = 0;
    reg rst_n;
    
    reg start_processing;
    
    reg mem1_write_en;
    reg [ADDR_WIDTH-1:0]mem1_write_address;
    reg [DATA_WIDTH-1:0]mem1_data_in;

    reg mem2_write_en;
    reg [ADDR_WIDTH-1:0]mem2_write_address;
    reg [DATA_WIDTH-1:0]mem2_data_in;

    reg mem3_read_en;
    reg [ADDR_WIDTH-1:0]mem3_read_address;
    wire [DATA_WIDTH-1:0] mem3_data_out;
    wire fsm_ready;
    reg [VECTOR_ELEMENT_WIDTH-1:0] element_a, element_b, element_c, element_d;
    

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
        .mem1_write_en(mem1_write_en),
        .mem1_write_address(mem1_write_address),
        .mem1_data_in(mem1_data_in),
        .mem2_write_en(mem2_write_en),
        .mem2_write_address(mem2_write_address),
        .mem2_data_in(mem2_data_in),
        .mem3_read_en(mem3_read_en),
        .mem3_read_address(mem3_read_address),
        .mem3_data_out(mem3_data_out),
        .fsm_ready(fsm_ready)
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
            // Extract elements in descending order to match dotProduct module
            a0 = vector_a[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 31:24
            a1 = vector_a[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 23:16
            a2 = vector_a[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 15:8
            a3 = vector_a[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 7:0
            b0 = vector_b[3*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 31:24
            b1 = vector_b[2*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 23:16
            b2 = vector_b[1*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 15:8
            b3 = vector_b[0*VECTOR_ELEMENT_WIDTH +: VECTOR_ELEMENT_WIDTH]; // bits 7:0
            result = (a0 * b0) + (a1 * b1) + (a2 * b2) + (a3 * b3);
            calculate_expected_dot_product = result;
        end
    endfunction

    //check if the data_out3 is correct
    always @(posedge clk) begin
        if (mem3_read_en) begin
            if (mem3_data_out !== golden_mem3[mem3_read_address]) begin
                $error("Time=%0t FAIL", $time);
            end else begin
                $display("Time=%0t PASS", $time);
            end
        end
    end

    always @(posedge clk) begin
        element_a <= 8'd1+i;
        element_b <= 8'd2+i;
        element_c <= 8'd3+i;
        element_d <= 8'd4+i;
    end

    initial begin
        rst_n = 0;
        start_processing = 0;
        mem1_write_en = 0;
        mem1_write_address = 0;
        mem1_data_in = 0;
        mem2_write_en = 0;
        mem2_write_address = 0;
        mem2_data_in = 0;
        mem3_read_en = 0;
        mem3_read_address = 0;
        
        #20 rst_n = 1;

        
        
        for (i = 0; i < TEST_COUNT; i = i + 1) begin

            wait (fsm_ready == 1'b1);
            @(posedge clk);
            mem1_write_en = 1;
            mem1_write_address = i;
            mem1_data_in = {element_a, element_b, element_c, element_d};
            mem2_write_en = 1;
            mem2_write_address = i;
            mem2_data_in = {element_a, element_b, element_c, element_d}; 
            @(posedge clk);
            mem1_write_en = 0;
            mem2_write_en = 0;
            
        end
        
        // #20;
        
        @(posedge clk);
        start_processing = 1;
        
        // Wait for all processing to complete  
        #500;  // Increased wait time for all 12 dot products to process through FIFOs
        
        start_processing = 0;  // Stop processing before reading
        #20;
         
        // Read from mem3 starting at address 1 (because mem_writer starts at 1)
        for (i = 0; i < TEST_COUNT; i = i + 1) begin
            @(posedge clk);
            mem3_read_en = 1;
            mem3_read_address = i + 1;  // Read from addresses 1 to 12
            
            @(posedge clk);  // Wait one cycle for read data
            
            expected_result = calculate_expected_dot_product(
                {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i}, 
                {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i}
            );         
            
            golden_mem3[i] = mem3_data_out;
            $display("Read mem3[%0d] = %0d, expected = %0d", i+1, mem3_data_out, expected_result);
        end
        
        mem3_read_en = 0;
        
        #20;
       
        
        #50 $finish;
    end
    

    
    initial begin
        $monitor($time, " rst_n=%b start_processing=%b mem1_write_en=%b mem1_write_address=%0d mem1_data_in=%0d mem2_write_en=%b mem2_write_address=%0d mem2_data_in=%0d mem3_read_en=%b mem3_read_address=%0d mem3_data_out=%0d", 
                 rst_n, start_processing, mem1_write_en, mem1_write_address, mem1_data_in, mem2_write_en, mem2_write_address, mem2_data_in, mem3_read_en, mem3_read_address, mem3_data_out, fsm_ready   );
    end

endmodule
