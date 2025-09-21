`timescale 1ns / 1ps

// Integrated Testbench for Complete Dot Product System
// Tests the integration of memory controllers and pipelined dot product module

module integrated_dotProduct_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter VECTOR_WIDTH = 4;
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH;
    parameter ADDR_WIDTH = 5;
    parameter RESULT_WIDTH = 2*DATA_WIDTH + $clog2(VECTOR_WIDTH);
    parameter CLK_PERIOD = 10;

    // Test vectors
    reg [DATA_WIDTH-1:0] vector_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] vector_b [0:VECTOR_WIDTH-1];
    reg [RESULT_WIDTH-1:0] expected_result;

    // System signals
    reg clk = 0;
    reg rst_n;
    
    // Memory controller write interface
    reg mem_start;
    reg mem_in_valid;
    reg [DATA_WIDTH-1:0] mem_data_a;
    reg [DATA_WIDTH-1:0] mem_data_b;
    wire mem_busy;
    wire mem_done;
    
    // Memory controller read interface
    reg mem_rd_en_a, mem_rd_en_b;
    reg [ADDR_WIDTH-1:0] mem_rd_addr_a, mem_rd_addr_b;
    wire [DATA_WIDTH-1:0] mem_dout_a, mem_dout_b;
    
    // Memory read controller interface
    reg read_start;
    wire read_rd_en_mem1, read_rd_en_mem2;
    wire [ADDR_WIDTH-1:0] read_rd_addr_mem1, read_rd_addr_mem2;
    wire [DATA_WIDTH-1:0] read_data_from_mem1, read_data_from_mem2;
    wire [DATA_WIDTH-1:0] read_data_out1, read_data_out2;
    wire read_done;
    
    // Dot product interface
    wire [DATA_WIDTH-1:0] dp_data_from_mem1;
    wire [DATA_WIDTH-1:0] dp_data_from_mem2;
    wire dp_data_valid;
    wire [RESULT_WIDTH-1:0] dp_dot_product_result;
    wire dp_result_valid;
    wire dp_processing_done;

    // Test control
    integer test_case;
    reg test_complete;

    // clog2 function
    function integer clog2;
        input integer value; 
        integer i;
        begin
            clog2 = 0;
            for (i = value - 1; i > 0; i = i >> 1) clog2 = clog2 + 1;
        end
    endfunction

    // Memory controller (write interface)
    mem_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .VETOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) mem_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .start(mem_start),
        .in_valid(mem_in_valid),
        .data_a(mem_data_a),
        .data_b(mem_data_b),
        .busy(mem_busy),
        .done(mem_done),
        .rd_en_a(mem_rd_en_a),
        .rd_addr_a(mem_rd_addr_a),
        .dout_a(mem_dout_a),
        .rd_en_b(mem_rd_en_b),
        .rd_addr_b(mem_rd_addr_b),
        .dout_b(mem_dout_b)
    );

    // Memory read controller
    memoryReadController #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUMBER_OF_VECTORS(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) read_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .start(read_start),
        .rd_en_mem1(read_rd_en_mem1),
        .rd_en_mem2(read_rd_en_mem2),
        .rd_addr_mem1(read_rd_addr_mem1),
        .rd_addr_mem2(read_rd_addr_mem2),
        .data_from_mem1(read_data_from_mem1),
        .data_from_mem2(read_data_from_mem2),
        .data_out1(read_data_out1),
        .data_out2(read_data_out2),
        .done(read_done)
    );

    // Dot product module
    dotProduct #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RESULT_WIDTH(RESULT_WIDTH)
    ) dp_module (
        .clk(clk),
        .rst_n(rst_n),
        .data_from_mem1(dp_data_from_mem1),
        .data_from_mem2(dp_data_from_mem2),
        .data_valid(dp_data_valid),
        .dot_product_result(dp_dot_product_result),
        .result_valid(dp_result_valid),
        .processing_done(dp_processing_done)
    );

    // Connect memory read controller to dot product module
    assign dp_data_from_mem1 = read_data_out1;
    assign dp_data_from_mem2 = read_data_out2;
    assign dp_data_valid = read_rd_en_mem1 && read_rd_en_mem2;

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

    // Task to write vectors to memory
    task write_vectors_to_memory;
        input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
        input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
        integer i;
        begin
            $display("Writing vectors to memory...");
            mem_start = 1'b1;
            mem_in_valid = 1'b0;
            @(posedge clk);
            
            for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
                @(posedge clk);
                mem_in_valid = 1'b1;
                mem_data_a = vec_a[i];
                mem_data_b = vec_b[i];
                $display("  Writing element %0d: A=%0d, B=%0d", i, vec_a[i], vec_b[i]);
                @(posedge clk);
                mem_in_valid = 1'b0;
            end
            
            mem_start = 1'b0;
            
            // Wait for write to complete
            wait(mem_done);
            @(posedge clk);
            $display("Memory write complete.");
        end
    endtask

    // Task to read vectors from memory and compute dot product
    task read_and_compute;
        output [RESULT_WIDTH-1:0] result;
        begin
            $display("Starting memory read and dot product computation...");
            read_start = 1'b1;
            @(posedge clk);
            read_start = 1'b0;
            
            // Wait for computation to complete
            wait(dp_result_valid);
            @(posedge clk);
            result = dp_dot_product_result;
            $display("Dot product computation complete. Result: %0d", result);
        end
    endtask

    // Main test sequence
    initial begin
        $display("===============================================");
        $display("Starting Integrated Dot Product System Test");
        $display("===============================================");
        
        // Initialize signals
        rst_n = 0;
        mem_start = 0;
        mem_in_valid = 0;
        mem_data_a = 0;
        mem_data_b = 0;
        mem_rd_en_a = 0;
        mem_rd_en_b = 0;
        mem_rd_addr_a = 0;
        mem_rd_addr_b = 0;
        read_start = 0;
        test_case = 0;
        test_complete = 0;

        // Reset
        #(CLK_PERIOD * 3);
        rst_n = 1;
        #(CLK_PERIOD * 3);

        // Test Case 1: Simple vectors [1,2,3,4] and [1,1,1,1]
        test_case = 1;
        $display("\n--- Test Case %0d: Simple Vectors ---", test_case);
        vector_a[0] = 8'd1; vector_a[1] = 8'd2; vector_a[2] = 8'd3; vector_a[3] = 8'd4;
        vector_b[0] = 8'd1; vector_b[1] = 8'd1; vector_b[2] = 8'd1; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        
        write_vectors_to_memory(vector_a, vector_b);
        read_and_compute(dp_dot_product_result);
        
        if (dp_dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dp_dot_product_result);
        end

        #(CLK_PERIOD * 5);

        // Test Case 2: Vectors [2,4,6,8] and [1,2,3,4]
        test_case = 2;
        $display("\n--- Test Case %0d: Progressive Vectors ---", test_case);
        vector_a[0] = 8'd2; vector_a[1] = 8'd4; vector_a[2] = 8'd6; vector_a[3] = 8'd8;
        vector_b[0] = 8'd1; vector_b[1] = 8'd2; vector_b[2] = 8'd3; vector_b[3] = 8'd4;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        
        write_vectors_to_memory(vector_a, vector_b);
        read_and_compute(dp_dot_product_result);
        
        if (dp_dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dp_dot_product_result);
        end

        #(CLK_PERIOD * 5);

        // Test Case 3: Vectors with zeros [0,5,0,3] and [2,0,4,1]
        test_case = 3;
        $display("\n--- Test Case %0d: Vectors with Zeros ---", test_case);
        vector_a[0] = 8'd0; vector_a[1] = 8'd5; vector_a[2] = 8'd0; vector_a[3] = 8'd3;
        vector_b[0] = 8'd2; vector_b[1] = 8'd0; vector_b[2] = 8'd4; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        
        write_vectors_to_memory(vector_a, vector_b);
        read_and_compute(dp_dot_product_result);
        
        if (dp_dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dp_dot_product_result);
        end

        #(CLK_PERIOD * 5);

        // Test Case 4: Maximum values [255,255,255,255] and [1,1,1,1]
        test_case = 4;
        $display("\n--- Test Case %0d: Maximum Values ---", test_case);
        vector_a[0] = 8'd255; vector_a[1] = 8'd255; vector_a[2] = 8'd255; vector_a[3] = 8'd255;
        vector_b[0] = 8'd1; vector_b[1] = 8'd1; vector_b[2] = 8'd1; vector_b[3] = 8'd1;
        calculate_expected(vector_a, vector_b, expected_result);
        $display("Expected result: %0d", expected_result);
        
        write_vectors_to_memory(vector_a, vector_b);
        read_and_compute(dp_dot_product_result);
        
        if (dp_dot_product_result == expected_result) begin
            $display("✓ Test Case %0d PASSED", test_case);
        end else begin
            $display("✗ Test Case %0d FAILED: Expected %0d, Got %0d", 
                     test_case, expected_result, dp_dot_product_result);
        end

        test_complete = 1;
        $display("\n===============================================");
        $display("All integrated tests completed!");
        $display("===============================================");
        #(CLK_PERIOD * 10);
        $finish;
    end

    // Monitor for debugging
    initial begin
        $monitor("Time=%0t: mem_busy=%b, mem_done=%b, read_done=%b, dp_result_valid=%b, dp_result=%0d", 
                 $time, mem_busy, mem_done, read_done, dp_result_valid, dp_dot_product_result);
    end

    // Timeout protection
    initial begin
        #(CLK_PERIOD * 2000); // 20us timeout
        if (!test_complete) begin
            $display("ERROR: Integrated testbench timed out!");
            $finish;
        end
    end

endmodule
