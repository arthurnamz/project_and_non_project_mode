`timescale 1ns/1ps

module cpu_tb;
 parameter PERIOD = 4;
 parameter DATA_WIDTH = 8;
 parameter ADDR_WIDTH = 32;
 parameter NUM_BURST_TESTS = 5;
 parameter BYTES_PER_BURST = 4;
 parameter MAX_BURST_LEN = 16;

 reg clk = 0;
 reg rstn;
 
 // AXI Signals
 reg [ADDR_WIDTH-1:0] awaddr;
 reg awvalid;
 wire awready;
 reg [3:0] awlen;
 reg [2:0] awsize;
 reg [1:0] awburst;
 
 reg [DATA_WIDTH-1:0] wdata;
 reg wvalid;
 wire wready;
 reg wlast;
 
 wire [1:0] bresp;
 wire bvalid;
 reg bready;
 
 reg [ADDR_WIDTH-1:0] araddr;
 reg arvalid;
 wire arready;
 reg [3:0] arlen;
 reg [2:0] arsize;
 reg [1:0] arburst;
 
 wire [DATA_WIDTH-1:0] rdata;
 wire rvalid;
 wire rresp;
 reg rready;
 wire rlast;

 cpu #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) DUT(
    .clk(clk), .rstn(rstn),
    .awaddr(awaddr), .awvalid(awvalid), .awready(awready),
    .awlen(awlen), .awsize(awsize), .awburst(awburst),
    .wdata(wdata), .wvalid(wvalid), .wready(wready), .wlast(wlast),
    .bresp(bresp), .bvalid(bvalid), .bready(bready),
    .araddr(araddr), .arvalid(arvalid), .arready(arready),
    .arlen(arlen), .arsize(arsize), .arburst(arburst),
    .rdata(rdata), .rvalid(rvalid), .rresp(rresp), .rready(rready), .rlast(rlast)
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
      
      
      for (i = 0; i <= burst_len; i = i + 1) begin
        wait(rvalid == 1'b1);
        @(posedge clk);
        data_array[i*DATA_WIDTH +: DATA_WIDTH] = rdata;
        
        if (i < burst_len) begin
          wait(rvalid == 1'b0);
        end
      end
      
      wait(rlast == 1'b1);
      @(posedge clk);
      rready = 1'b0;
      repeat(3) @(posedge clk);  
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
  reg [7:0] expected_results [0:NUM_BURST_TESTS-1];
  
  initial begin
    test_data[0] = {8'h00, 8'd0, 8'd3, 8'd5};    
    test_data[1] = {8'h00, 8'd1, 8'd4, 8'd10};   
    test_data[2] = {8'h00, 8'd2, 8'd0, 8'd15};   
    test_data[3] = {8'h00, 8'd3, 8'd3, 8'd2};    
    test_data[4] = {8'h00, 8'd0, 8'd7, 8'd20};   
    
    expected_results[0] = 8'd8;
    expected_results[1] = 8'd6;
    expected_results[2] = 8'd240;
    expected_results[3] = 8'd16;
    expected_results[4] = 8'd27;
    
    test_addr[0] = 32'h00000000;
    test_addr[1] = 32'h00000010;
    test_addr[2] = 32'h00000020;
    test_addr[3] = 32'h00000030;
    test_addr[4] = 32'h00000040;
    
    rstn = 0;
    awaddr = 0; awvalid = 0; awlen = 0; awsize = 0; awburst = 0;
    wdata = 0; wvalid = 0; wlast = 0;
    bready = 0;
    araddr = 0; arvalid = 0; arlen = 0; arsize = 0; arburst = 0;
    rready = 0;
    
    #10 rstn = 1;
    #10;

    $display("\n AXI Burst Write Tests \n");
    $display("Testing: %0d burst write transactions\n", NUM_BURST_TESTS);
    for (test_num = 0; test_num < NUM_BURST_TESTS; test_num = test_num + 1) begin
      $display("[%0t] TEST %0d: Burst Write to 0x%08h (data: op1=%0d, op2=%0d, opcode=%0d)", 
               $time, test_num + 1, 
               test_addr[test_num],
               test_data[test_num][7:0],
               test_data[test_num][15:8],
               test_data[test_num][23:16]);
      
      axi_burst_write(test_addr[test_num], BYTES_PER_BURST - 1, test_data[test_num]);
      
      if (bresp == 2'b00) begin
        $display("[%0t] Write completed successfully (BRESP=OKAY)\n", $time);
      end else begin
        $display("[%0t] Write failed (BRESP=0x%01h)\n", $time, bresp);
      end
      
      #20;
    end
    
    $display("\n  Single Read Verification \n");
    
    for (test_num = 0; test_num < NUM_BURST_TESTS; test_num = test_num + 1) begin
      $display("[%0t] Reading from address 0x%08h:", $time, test_addr[test_num]);
      for (byte_num = 0; byte_num < BYTES_PER_BURST; byte_num = byte_num + 1) begin
        axi_single_read(test_addr[test_num] + byte_num, read_data);
        if (byte_num == 3) begin
          expected = expected_results[test_num];
          if (read_data == expected) begin
            $display("  [%0t] Byte %0d: %0d  PASS", $time, byte_num, read_data);
          end else begin
            $display("  [%0t] Byte %0d: %0d (expected %0d) FAIL", $time, byte_num, read_data, expected);
          end
        end else begin
          expected = test_data[test_num][byte_num*8 +: 8];
          if (read_data == expected) begin
            $display("  [%0t] Byte %0d: %0d  PASS", 
                     $time, byte_num, read_data);
          end else begin
            $display("  [%0t] Byte %0d: %0d (expected %0d) FAIL", $time, byte_num, read_data, expected);
          end
        end
      end
      $display("");
    end
    
    $display("\n  Burst Read Verification \n");
    
    for (test_num = 0; test_num < NUM_BURST_TESTS; test_num = test_num + 1) begin
      $display("[%0t] Burst Read from 0x%08h (%0d bytes)", $time, test_addr[test_num], BYTES_PER_BURST);
      axi_burst_read(test_addr[test_num], BYTES_PER_BURST - 1, burst_read_data);
      
      for (byte_num = 0; byte_num < BYTES_PER_BURST; byte_num = byte_num + 1) begin
        read_byte = burst_read_data[byte_num*8 +: 8];
        
        if (byte_num == 3) begin
          expected_byte = expected_results[test_num];
        end else begin
          expected_byte = test_data[test_num][byte_num*8 +: 8];
        end
        
        if (read_byte == expected_byte) begin
          $display("  Byte %0d: %0d ", byte_num, read_byte);
        end else begin
          $display("  Byte %0d: %0d (expected %0d)", byte_num, read_byte, expected_byte);
        end
      end
      $display("");
    end
    
    #100;
    $display("\n  Simulation Complete \n");
    $finish;
  end

endmodule
