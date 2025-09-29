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
    wire read_en1;
    wire[ADDR_WIDTH-1:0] read_address1;
    reg [DATA_WIDTH-1:0] mem1_input;
    wire [DATA_WIDTH-1:0] mem1_output;

    // mem2
    wire read_en2;
    wire[ADDR_WIDTH-1:0] read_address2;
    reg [DATA_WIDTH-1:0] mem2_input;
    wire [DATA_WIDTH-1:0] mem2_output;

    integer i;

  mem_reader #(
    .DATA_WIDTH  (DATA_WIDTH),
    .ADDR_WIDTH  (ADDR_WIDTH),
    .MEM_SIZE    (MEM_SIZE)
  ) u_mem_reader (
    .clk         (clk),
    .rst_n       (rst_n),
    .start_reading(start_reading),
    .read_en1(read_en1),
    .read_address1(read_address1),
    .mem1_input(mem1_input),
    .mem1_output(mem1_output),
    .read_en2(read_en2),
    .read_address2(read_address2),
    .mem2_input(mem2_input),
    .mem2_output(mem2_output)
  );

  always #(PERIOD/2) clk = ~clk;

  reg [DATA_WIDTH-1:0] mem1 [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] mem2 [0:MEM_SIZE-1];
  reg [DATA_WIDTH-1:0] mem1_output_model;
  reg [DATA_WIDTH-1:0] mem2_output_model;

  always @(posedge clk) begin
    if (!rst_n) begin
      mem1[read_address1] <= {DATA_WIDTH{1'b0}};
      mem2[read_address2] <= {DATA_WIDTH{1'b0}};
    end else begin
      if (read_en1) mem1[read_address1] <= mem1_input;
      if (read_en2) mem2[read_address2] <= mem2_input;
    end
  end

  always @(posedge clk) begin
    if (!rst_n) begin
      mem1_output_model <= {DATA_WIDTH{1'b0}};
      mem2_output_model <= {DATA_WIDTH{1'b0}};
    end else begin
      if (read_en1) mem1_output_model <= mem1[read_address1];
      if (read_en2) mem2_output_model <= mem2[read_address2];
    end
  end
  //check if the mem1_output and mem2_output are correct
  always @(posedge clk) begin
    if (read_en1) begin
      if (mem1_output !== mem1_output_model) begin
        $error("Time=%0t FAIL: mem1_output mismatch. Got %0d, Expected %0d", $time, mem1_output, mem1_output_model);
      end else begin
        $display("Time=%0t PASS: mem1_output mismatch. Got %0d, Expected %0d", $time, mem1_output, mem1_output_model);
      end
    end
    if (read_en2) begin
      if (mem2_output !== mem2_output_model) begin
        $error("Time=%0t FAIL: mem2_output mismatch. Got %0d, Expected %0d", $time, mem2_output, mem2_output_model);
      end else begin
        $display("Time=%0t PASS: mem2_output mismatch. Got %0d, Expected %0d", $time, mem2_output, mem2_output_model);
      end
    end
  end
  
  initial begin
    rst_n = 0;
    start_reading = 0;
    mem1_input = 0;
    mem2_input = 0;
    
    #10 rst_n = 1;

    for (i = 0; i < TEST_COUNT; i = i + 1) begin
      mem1_input = {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i};
      mem2_input = {8'd1+i, 8'd2+i, 8'd3+i, 8'd4+i};
      #10 start_reading = 1;
      #10;
      #10 start_reading = 0;
      #10;
    end

    #100 $finish;
  end

  // initial begin
  //   $monitor($time,
  //     " rst_n=%b start_reading=%b mem1_input=%0d mem2_input=%0d read_en1=%b read_address1=%0d mem1_output=%0d read_en2=%b read_address2=%0d mem2_output=%0d",
  //     rst_n, start_reading, mem1_input, mem2_input, read_en1, read_address1, mem1_output, read_en2, read_address2, mem2_output);
  // end
endmodule
  