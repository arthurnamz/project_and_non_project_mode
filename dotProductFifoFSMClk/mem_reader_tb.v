`timescale 1ns/1ps

module mem_reader_tb;

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;
    parameter MEM_SIZE = 32;
    parameter PERIOD = 10; 
    parameter TEST_COUNT = 4;

    reg clk = 0;
    reg rst_n;
    reg start_reading;   

    // mem1
    wire read_en;
    wire[ADDR_WIDTH-1:0] read_address;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    integer i;

  mem_reader #(
    .DATA_WIDTH  (DATA_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .MEM_SIZE    (MEM_SIZE)
  ) u_mem_reader (
    .clk         (clk),
    .rst_n       (rst_n),
    .start_reading(start_reading),
    .read_en(read_en),
    .read_address(read_address),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #(PERIOD/2) clk = ~clk;

  // Model for mem_reader: data_out should always equal data_in
  reg [DATA_WIDTH-1:0] model_out;

  always @* begin
    model_out = data_in;  // mem_reader just passes data_in to data_out
  end
  //check if the data_out is correct
  always @(posedge clk) begin
    if (read_en) begin
      if (data_out !== model_out) begin
        $error("Time=%0t FAIL: data_out mismatch. Got %0d, Expected %0d", $time, data_out, model_out);
      end else begin
        $display("Time=%0t PASS: data_out correct. Got %0d, Expected %0d", $time, data_out, model_out);
      end
    end
  end
  
  initial begin
    rst_n = 0;
    start_reading = 0;
    data_in = 0;
    
    #10 rst_n = 1;

    for (i = 0; i < TEST_COUNT; i = i + 1) begin
      data_in = {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i};
      #10 start_reading = 1;
      #10;
      #10 start_reading = 0;
      #10;
    end

    #100 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start_reading=%b data_in=%0d read_en=%b read_address=%0d data_out=%0d",
      rst_n, start_reading, data_in, read_en, read_address, data_out);
  end
endmodule  
