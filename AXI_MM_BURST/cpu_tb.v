`timescale 1ns/1ps

module cpu_tb;
 parameter PERIOD = 4;
 parameter DATA_WIDTH = 8;
 parameter ADDR_WIDTH = 32;
 
 // Test configuration parameters - CHANGE THESE TO SCALE TESTS!
 parameter NUM_BURST_TESTS = 5;      // Number of burst write tests (try 5, 10, 100!)
 parameter BYTES_PER_BURST = 4;      // Number of bytes per burst (4=32-bit, 8=64-bit)
 parameter MAX_BURST_LEN = 16;       // Maximum burst length supported

 reg clk = 0;
 reg rstn;

// write address channel
 reg [ADDR_WIDTH-1:0] awaddr;
 reg awvalid;
 wire awready;
 reg [3:0] awlen;     // Burst length
 reg [2:0] awsize;    // Burst size
 reg [1:0] awburst;   // Burst type

// write data channel
 reg [DATA_WIDTH-1:0] wdata;
 reg wvalid;
 wire wready;
 reg wlast;           // Last transfer in burst

// write response channel
 wire [1:0] bresp;
 wire bvalid;
 reg bready;

// read address channel
 reg [ADDR_WIDTH-1:0] araddr;
 reg arvalid;
 wire arready;
 reg [3:0] arlen;
 reg [2:0] arsize;
 reg [1:0] arburst;

// read data channel
 wire [DATA_WIDTH-1:0] rdata;
 wire rvalid;
 wire rresp;
 reg rready;
 wire rlast;

 cpu #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) DUT(
    .clk(clk),
    .rstn(rstn),

    // write address channel
    .awaddr(awaddr),
    .awvalid(awvalid),
    .awready(awready),
    .awlen(awlen),
    .awsize(awsize),
    .awburst(awburst),

    // write data channel
    .wdata(wdata),
    .wvalid(wvalid),
    .wready(wready),
    .wlast(wlast),

    // write response channel
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),

    // read address channel
    .araddr(araddr),
    .arvalid(arvalid),
    .arready(arready),
    .arlen(arlen),
    .arsize(arsize),
    .arburst(arburst),

    // read data channel
    .rdata(rdata),
    .rvalid(rvalid),
    .rresp(rresp),
    .rready(rready),
    .rlast(rlast)
  );

  always #(PERIOD/2) clk = ~clk;

  // Task: AXI Burst Write
  task axi_burst_write;
    input [ADDR_WIDTH-1:0] addr;
    input [3:0] burst_len;  // Number of transfers minus 1
    input [DATA_WIDTH*MAX_BURST_LEN-1:0] data_array;
    integer i;
    begin
      // Address phase
      @(posedge clk);
      awaddr = addr;
      awvalid = 1'b1;
      awlen = burst_len;
      awsize = 3'b000;  // 1 byte per transfer
      awburst = 2'b01;  // INCR
      wait(awready == 1'b1);
      @(posedge clk);
      awvalid = 1'b0;
      
      // Data phase - loop through all beats
      for (i = 0; i <= burst_len; i = i + 1) begin
        wdata = data_array[i*DATA_WIDTH +: DATA_WIDTH];
        wvalid = 1'b1;
        wlast = (i == burst_len) ? 1'b1 : 1'b0;
        wait(wready == 1'b1);
        @(posedge clk);
      end
      wvalid = 1'b0;
      wlast = 1'b0;
      
      // Response phase
      bready = 1'b1;
      wait(bvalid == 1'b1);
      @(posedge clk);
      bready = 1'b0;
    end
  endtask
  
  // Task: AXI Single Read
  task axi_single_read;
    input [ADDR_WIDTH-1:0] addr;
    output [DATA_WIDTH-1:0] data_out;
    begin
      @(posedge clk);
      araddr = addr;
      arvalid = 1'b1;
      arlen = 4'd0;     // Single beat
      arsize = 3'b000;
      arburst = 2'b01;
      rready = 1'b1;
      wait(arready == 1'b1);
      @(posedge clk);
      arvalid = 1'b0;
      wait(rvalid == 1'b1);
      @(posedge clk);
      data_out = rdata;
      wait(rlast == 1'b1);
      @(posedge clk);
      rready = 1'b0;
      repeat(3) @(posedge clk);  // Delay between transactions
    end
  endtask
  
  // Task: AXI Burst Read
  task axi_burst_read;
    input [ADDR_WIDTH-1:0] addr;
    input [3:0] burst_len;
    output [DATA_WIDTH*MAX_BURST_LEN-1:0] data_array;
    integer i;
    begin
      // Address phase
      @(posedge clk);
      araddr = addr;
      arvalid = 1'b1;
      arlen = burst_len;
      arsize = 3'b000;
      arburst = 2'b01;
      rready = 1'b1;
      wait(arready == 1'b1);
      @(posedge clk);
      arvalid = 1'b0;
      
      // Data phase - loop through all beats
      for (i = 0; i <= burst_len; i = i + 1) begin
        // Wait for rvalid to go high (new data available)
        wait(rvalid == 1'b1);
        // Sample data on clock edge when rvalid is high
        @(posedge clk);
        data_array[i*DATA_WIDTH +: DATA_WIDTH] = rdata;
        
        // If not the last beat, wait for rvalid to go low before next beat
        if (i < burst_len) begin
          wait(rvalid == 1'b0);
        end
      end
      
      // Wait for last signal and complete
      wait(rlast == 1'b1);
      @(posedge clk);
      rready = 1'b0;
      repeat(3) @(posedge clk);  // Delay between transactions
    end
  endtask

  // Test data storage
  reg [DATA_WIDTH-1:0] read_data;
  reg [DATA_WIDTH*MAX_BURST_LEN-1:0] burst_read_data;
  integer test_num, byte_num;
  reg [7:0] expected, read_byte, expected_byte;

  // Test data arrays
  reg [31:0] test_data [0:NUM_BURST_TESTS-1];
  reg [ADDR_WIDTH-1:0] test_addr [0:NUM_BURST_TESTS-1];
  
  initial begin
    // Initialize test data - easily add more by incrementing NUM_BURST_TESTS!
    test_data[0] = 32'hDEADBEEF;
    test_data[1] = 32'h12345678;
    // Uncomment below and set NUM_BURST_TESTS=5 for more tests:
    test_data[2] = 32'hCAFEBABE;
    test_data[3] = 32'hABCD1234;
    test_data[4] = 32'h55AA55AA;
    
    test_addr[0] = 32'h00000000;
    test_addr[1] = 32'h00000010;
    // Uncomment below and set NUM_BURST_TESTS=5 for more tests:
    test_addr[2] = 32'h00000020;
    test_addr[3] = 32'h00000030;
    test_addr[4] = 32'h00000040;
    
    // Initialize signals
    rstn = 0;
    awaddr = 0; awvalid = 0; awlen = 0; awsize = 0; awburst = 0;
    wdata = 0; wvalid = 0; wlast = 0;
    bready = 0;
    araddr = 0; arvalid = 0; arlen = 0; arsize = 0; arburst = 0;
    rready = 0;
    
    #10 rstn = 1;
    #10;

    $display("\n========================================");
    $display("=== AXI Burst Transfer Tests ===");
    $display("========================================");
    $display("Configuration:");
    $display("  - Number of burst tests: %0d", NUM_BURST_TESTS);
    $display("  - Bytes per burst: %0d", BYTES_PER_BURST);
    $display("========================================\n");
    
    // ==========================================
    // Test Loop: Burst Writes
    // ==========================================
    for (test_num = 0; test_num < NUM_BURST_TESTS; test_num = test_num + 1) begin
      $display("[%0t] TEST %0d: Burst Write 0x%08h to address 0x%08h", 
               $time, test_num + 1, test_data[test_num], test_addr[test_num]);
      
      axi_burst_write(test_addr[test_num], BYTES_PER_BURST - 1, test_data[test_num]);
      
      if (bresp == 2'b00) begin
        $display("[%0t] SUCCESS: Burst write completed (BRESP=OKAY)\n", $time);
      end else begin
        $display("[%0t] ERROR: Burst write failed (BRESP=0x%01h)\n", $time, bresp);
      end
      
      #20;
    end
    
    $display("========================================");
    $display("=== Reading Back Data ===");
    $display("========================================\n");
    
    // ==========================================
    // Test Loop: Read back each burst's data
    // ==========================================
    for (test_num = 0; test_num < NUM_BURST_TESTS; test_num = test_num + 1) begin
      $display("[%0t] Reading back burst %0d from address 0x%08h:", 
               $time, test_num + 1, test_addr[test_num]);
      
      // Read each byte of the burst
      for (byte_num = 0; byte_num < BYTES_PER_BURST; byte_num = byte_num + 1) begin
        axi_single_read(test_addr[test_num] + byte_num, read_data);
        
        // Extract expected byte from test_data
        expected = test_data[test_num][byte_num*8 +: 8];
        
        if (read_data == expected) begin
          $display("  [%0t] Byte %0d: 0x%02h (expected 0x%02h) ✓ PASS", 
                   $time, byte_num, read_data, expected);
        end else begin
          $display("  [%0t] Byte %0d: 0x%02h (expected 0x%02h) ✗ FAIL", 
                   $time, byte_num, read_data, expected);
        end
      end
      $display("");
    end
    
    $display("========================================");
    $display("=== Bonus: Burst Read Test ===");
    $display("========================================\n");
    
    // ==========================================
    // Burst Read: Read all 4 bytes in one burst
    // ==========================================
    $display("[%0t] Burst Read 4 bytes from address 0x00000000", $time);
    axi_burst_read(32'h00000000, BYTES_PER_BURST - 1, burst_read_data);
    
    $display("Burst read data:");
    for (byte_num = 0; byte_num < BYTES_PER_BURST; byte_num = byte_num + 1) begin
      read_byte = burst_read_data[byte_num*8 +: 8];
      expected_byte = test_data[0][byte_num*8 +: 8];
      
      if (read_byte == expected_byte) begin
        $display("  Byte %0d: 0x%02h ✓", byte_num, read_byte);
      end else begin
        $display("  Byte %0d: 0x%02h (expected 0x%02h) ✗", byte_num, read_byte, expected_byte);
      end
    end
    
    #100;
    
    $display("\n========================================");
    $display("=== All Tests Completed ===");
    $display("========================================\n");
    $finish;
  end

endmodule
