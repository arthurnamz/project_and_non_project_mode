`timescale 1ns / 1ps

// Testbench for Pipelined Dot Product Module
// Tests the complete dot product computation with various test vectors

module dotProduct_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter VECTOR_WIDTH = 4;
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH;
    parameter ADDR_WIDTH = 5;
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);
    parameter CLK_PERIOD = 10; // 10ns clock period

    // Test vectors
    reg [DATA_WIDTH-1:0] vector_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] vector_b [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] expected_result;

    // Testbench signals
    reg clk = 0;
    reg rst_n;
    reg [DATA_WIDTH-1:0] data_from_mem1;
    reg [DATA_WIDTH-1:0] data_from_mem2;
    reg data_valid;
    wire [RESULT_WIDTH-1:0] dot_product_result;
    wire result_valid;
    wire processing_done;

    // Test control
    integer test_case;
    integer element_count;
    reg test_complete;

    // DUT instantiation
    dotProduct #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_from_mem1(data_from_mem1),
        .data_from_mem2(data_from_mem2),
        .data_valid(data_valid),
        .dot_product_result(dot_product_result),
        .result_valid(result_valid),
        .processing_done(processing_done)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    // Task to calculate expected dot product
    task calculate_expected;
        input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
        input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
        output [RESULT_WIDTH-1:0] result;
        integer i;
        reg [RESULT_WIDTH-1:0] temp_result;
        begin
            temp_result = 0;
            for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
                temp_result = temp_result + (vec_a[i] * vec_b[i]);
            end
            result = temp_result;
        end
    endtask

    // Task to feed vector data to the dot product module
    task feed_vector;
        input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
        input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
        integer i;
        begin
            $display("Feeding vector data...");
            for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
                @(posedge clk);
                data_from_mem1 <= vec_a[i];
                data_from_mem2 <= vec_b[i];
                data_valid <= 1'b1;
                $display("  Element %0d: A=%0d, B=%0d, Product=%0d", 
                         i, vec_a[i], vec_b[i], vec_a[i] * vec_b[i]);
                @(posedge clk);
                data_valid <= 1'b0;
            end
            $display("Vector feeding complete.");
        end
    endtask

    // Task to wait for result
    task wait_for_result;
        output [RESULT_WIDTH-1:0] result;
        begin
            $display("Waiting for dot product result...");
            wait(result_valid);
            @(posedge clk);
            result = dot_product_result;
            $display("Result received: %0d", result);
        end
    endtask

    // Main test sequence
    initial begin
        $display("==========================================");
        $display("Starting Pipelined Dot Product Testbench");
        $display("==========================================");
        
        // Initialize signals
        rst_n = 0;
        data_from_mem1 = 0;
        data_from_mem2 = 0;
        data_valid = 0;
        test_case = 0;
        test_complete = 0;

        // Reset
        #(CLK_PERIOD * 2);
        rst_n = 1;
        #(CLK_PERIOD * 2);

        // Test Case 1: Simple vectors [1,2,3,4] and [1,1,1,1]
        test_case = 1;
        $display("\n--- Test Case %0d ---", test_case);
        vector_a[0] = 8'd1; vector_a[1] = 8'd2; vector_a[2] = 8'd3; vector_a[3] = 8'd4;
        vector_b[0] = 8'd1; vector_b[1] = 8'd1; vector_b[2] = 8'd1; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        feed_vector(vector_a, vector_b);
        
        // Wait for pipeline to complete
        #(CLK_PERIOD * VECTOR_WIDTH * 2);
        wait_for_result(dot_product_result);
        
        if (dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dot_product_result);
        end

        // Test Case 2: Vectors [2,4,6,8] and [1,2,3,4]
        test_case = 2;
        $display("\n--- Test Case %0d ---", test_case);
        vector_a[0] = 8'd2; vector_a[1] = 8'd4; vector_a[2] = 8'd6; vector_a[3] = 8'd8;
        vector_b[0] = 8'd1; vector_b[1] = 8'd2; vector_b[2] = 8'd3; vector_b[3] = 8'd4;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        feed_vector(vector_a, vector_b);
        
        #(CLK_PERIOD * VECTOR_WIDTH * 2);
        wait_for_result(dot_product_result);
        
        if (dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dot_product_result);
        end

        // Test Case 3: Vectors with zeros [0,5,0,3] and [2,0,4,1]
        test_case = 3;
        $display("\n--- Test Case %0d ---", test_case);
        vector_a[0] = 8'd0; vector_a[1] = 8'd5; vector_a[2] = 8'd0; vector_a[3] = 8'd3;
        vector_b[0] = 8'd2; vector_b[1] = 8'd0; vector_b[2] = 8'd4; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        feed_vector(vector_a, vector_b);
        
        #(CLK_PERIOD * VECTOR_WIDTH * 2);
        wait_for_result(dot_product_result);
        
        if (dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dot_product_result);
        end

        // Test Case 4: Maximum values [255,255,255,255] and [1,1,1,1]
        test_case = 4;
        $display("\n--- Test Case %0d ---", test_case);
        vector_a[0] = 8'd255; vector_a[1] = 8'd255; vector_a[2] = 8'd255; vector_a[3] = 8'd255;
        vector_b[0] = 8'd1; vector_b[1] = 8'd1; vector_b[2] = 8'd1; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        feed_vector(vector_a, vector_b);
        
        #(CLK_PERIOD * VECTOR_WIDTH * 2);
        wait_for_result(dot_product_result);
        
        if (dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dot_product_result);
        end

        // Test Case 5: Negative-like values (using high values to simulate negative behavior)
        test_case = 5;
        $display("\n--- Test Case %0d ---", test_case);
        vector_a[0] = 8'd200; vector_a[1] = 8'd150; vector_a[2] = 8'd100; vector_a[3] = 8'd50;
        vector_b[0] = 8'd10; vector_b[1] = 8'd20; vector_b[2] = 8'd30; vector_b[3] = 8'd40;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        feed_vector(vector_a, vector_b);
        
        #(CLK_PERIOD * VECTOR_WIDTH * 2);
        wait_for_result(dot_product_result);
        
        if (dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dot_product_result);
        end

        test_complete = 1;
        $display("\n==========================================");
        $display("All tests completed!");
        $display("==========================================");
        #(CLK_PERIOD * 10);
        $finish;
    end

    // Monitor for debugging
    initial begin
        $monitor("Time=%0t: data_valid=%b, data_a=%0d, data_b=%0d, result_valid=%b, result=%0d", 
                 $time, data_valid, data_from_mem1, data_from_mem2, result_valid, dot_product_result);
    end

    // Timeout protection
    initial begin
        #(CLK_PERIOD * 1000); // 10us timeout
        if (!test_complete) begin
            $display("ERROR: Testbench timed out!");
            $finish;
        end
    end

endmodule
