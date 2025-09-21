`timescale 1ns / 1ps

// Testbench for Modified Memory Reader
// Tests the memory reader that provides direct outputs from mem1 and mem2

module mem_reader_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter VECTOR_WIDTH = 4;
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH;
    parameter ADDR_WIDTH = 5;
    parameter CLK_PERIOD = 10;

    // Test vectors
    reg [DATA_WIDTH-1:0] test_vector_a [0:VECTOR_WIDTH-1];
    reg [DATA_WIDTH-1:0] test_vector_b [0:VECTOR_WIDTH-1];

    // Testbench signals
    reg clk = 0;
    reg rst_n;
    reg start_reading;
    wire reading_done;
    wire rd_en_mem1, rd_en_mem2;
    wire [ADDR_WIDTH-1:0] rd_addr_mem1, rd_addr_mem2;
    wire [DATA_WIDTH-1:0] mem1_output;
    wire [DATA_WIDTH-1:0] mem2_output;
    wire data_valid;
    wire [2:0] element_count;

    // Test control
    integer i;
    reg test_complete;

    // DUT instantiation
    mem_reader #(
        .DATA_WIDTH(DATA_WIDTH),
        .VECTOR_WIDTH(VECTOR_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start_reading(start_reading),
        .reading_done(reading_done),
        .rd_en_mem1(rd_en_mem1),
        .rd_en_mem2(rd_en_mem2),
        .rd_addr_mem1(rd_addr_mem1),
        .rd_addr_mem2(rd_addr_mem2),
        .mem1_output(mem1_output),
        .mem2_output(mem2_output),
        .data_valid(data_valid),
        .element_count(element_count)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    // Task to pre-load test data into memories
    task preload_test_data;
        input [DATA_WIDTH-1:0] vec_a [0:VECTOR_WIDTH-1];
        input [DATA_WIDTH-1:0] vec_b [0:VECTOR_WIDTH-1];
        integer i;
        begin
            $display("Pre-loading test data into memories...");
            // Note: In a real scenario, this would be done through the mem_controller
            // For this testbench, we'll simulate the data being already loaded
            for (i = 0; i < VECTOR_WIDTH; i = i + 1) begin
                test_vector_a[i] = vec_a[i];
                test_vector_b[i] = vec_b[i];
                $display("  Vector A[%0d] = %0d, Vector B[%0d] = %0d", i, vec_a[i], i, vec_b[i]);
            end
            $display("Test data pre-loaded.");
        end
    endtask

    // Task to start reading and monitor outputs
    task start_reading_test;
        integer cycle_count;
        begin
            $display("Starting memory reading test...");
            start_reading = 1'b1;
            @(posedge clk);
            start_reading = 1'b0;
            
            cycle_count = 0;
            while (!reading_done && cycle_count < 50) begin
                @(posedge clk);
                cycle_count = cycle_count + 1;
                
                if (data_valid) begin
                    $display("  Cycle %0d: Addr=%0d, Mem1=%0d, Mem2=%0d, Element=%0d", 
                             cycle_count, rd_addr_mem1, mem1_output, mem2_output, element_count);
                end
            end
            
            if (reading_done) begin
                $display("Reading completed successfully.");
            end else begin
                $display("ERROR: Reading timed out!");
            end
        end
    endtask

    // Main test sequence
    initial begin
        $display("==========================================");
        $display("Starting Memory Reader Testbench");
        $display("==========================================");
        
        // Initialize signals
        rst_n = 0;
        start_reading = 0;
        test_complete = 0;

        // Reset
        #(CLK_PERIOD * 2);
        rst_n = 1;
        #(CLK_PERIOD * 2);

        // Test Case 1: Simple vectors
        $display("\n--- Test Case 1: Simple Vectors ---");
        test_vector_a[0] = 8'd1; test_vector_a[1] = 8'd2; test_vector_a[2] = 8'd3; test_vector_a[3] = 8'd4;
        test_vector_b[0] = 8'd5; test_vector_b[1] = 8'd6; test_vector_b[2] = 8'd7; test_vector_b[3] = 8'd8;
        preload_test_data(test_vector_a, test_vector_b);
        start_reading_test;

        #(CLK_PERIOD * 5);

        // Test Case 2: Progressive vectors
        $display("\n--- Test Case 2: Progressive Vectors ---");
        test_vector_a[0] = 8'd10; test_vector_a[1] = 8'd20; test_vector_a[2] = 8'd30; test_vector_a[3] = 8'd40;
        test_vector_b[0] = 8'd2; test_vector_b[1] = 8'd4; test_vector_b[2] = 8'd6; test_vector_b[3] = 8'd8;
        preload_test_data(test_vector_a, test_vector_b);
        start_reading_test;

        #(CLK_PERIOD * 5);

        // Test Case 3: Vectors with zeros
        $display("\n--- Test Case 3: Vectors with Zeros ---");
        test_vector_a[0] = 8'd0; test_vector_a[1] = 8'd15; test_vector_a[2] = 8'd0; test_vector_a[3] = 8'd25;
        test_vector_b[0] = 8'd3; test_vector_b[1] = 8'd0; test_vector_b[2] = 8'd7; test_vector_b[3] = 8'd0;
        preload_test_data(test_vector_a, test_vector_b);
        start_reading_test;

        test_complete = 1;
        $display("\n==========================================");
        $display("All memory reader tests completed!");
        $display("==========================================");
        #(CLK_PERIOD * 10);
        $finish;
    end

    // Monitor for debugging
    initial begin
        $monitor("Time=%0t: start_reading=%b, data_valid=%b, rd_addr=%0d, mem1_out=%0d, mem2_out=%0d, element=%0d, reading_done=%b", 
                 $time, start_reading, data_valid, rd_addr_mem1, mem1_output, mem2_output, element_count, reading_done);
    end

    // Timeout protection
    initial begin
        #(CLK_PERIOD * 500); // 5us timeout
        if (!test_complete) begin
            $display("ERROR: Testbench timed out!");
            $finish;
        end
    end

endmodule
