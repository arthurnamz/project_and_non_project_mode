
`timescale 1ns/1ps



module mem_controller_tb;

function integer clog2;
  input integer value; integer i;
  begin
    clog2 = 0;
    for (i = value - 1; i > 0; i = i >> 1) clog2 = clog2 + 1;
  end
endfunction
  localparam PERIOD       = 4;
  localparam DATA_WIDTH   = 8;
  localparam VETOR_WIDTH  = 4;
  localparam DEPTH        = VETOR_WIDTH * DATA_WIDTH;
  localparam ADDR_WIDTH   = clog2(DEPTH);

  reg clk = 0;
  reg rst_n;

  // write-side
  reg                    start;
  reg                    in_valid;
  reg  [DATA_WIDTH-1:0]  data_a, data_b;
  wire                   busy, done;

  // read ports
  reg                    rd_en_a, rd_en_b;
  reg  [ADDR_WIDTH-1:0]  rd_addr_a, rd_addr_b;
  wire [DATA_WIDTH-1:0]  dout_a, dout_b;

  // DUT
  mem_controller #(
    .DATA_WIDTH (DATA_WIDTH),
    .VETOR_WIDTH(VETOR_WIDTH)
  ) u_dut (
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .in_valid(in_valid),
    .data_a(data_a),
    .data_b(data_b),
    .busy(busy),
    .done(done),
    .rd_en_a(rd_en_a),
    .rd_addr_a(rd_addr_a),
    .dout_a(dout_a),
    .rd_en_b(rd_en_b),
    .rd_addr_b(rd_addr_b),
    .dout_b(dout_b)
  );

  // clock
  always #(PERIOD/2) clk = ~clk;

  // stimulus — numeric delays only
  initial begin
    rst_n=0; start=0; in_valid=0; data_a=0; data_b=0;
    rd_en_a=0; rd_en_b=0; rd_addr_a=8'b0; rd_addr_b=8'b0;


    #100 rst_n=1;

    #10 start=1;
   
       // WRITE 0
    in_valid=1; data_a=8'd10; data_b=8'd200;
    #4  in_valid=0;

    // gap
    #4;

    // WRITE 1
    in_valid=1; data_a=8'd20; data_b=8'd150;
    #4  in_valid=0;

    // WRITE 2
    in_valid=1; data_a=8'd30; data_b=8'd100;
    #4  in_valid=0;
    #4  start=0;

    // READ addr 0
    rd_en_a=1; rd_en_b=1;
    rd_addr_a=0; rd_addr_b=0;
    @(posedge clk); #2; // sync read latency
    $display("%0t READ[0]  A=%0d (0x%0h)  B=%0d (0x%0h)", $time, dout_a, dout_a, dout_b, dout_b);

    // READ addr 1
    rd_addr_a=1; rd_addr_b=1;
    @(posedge clk); #2;
    $display("%0t READ[1]  A=%0d (0x%0h)  B=%0d (0x%0h)", $time, dout_a, dout_a, dout_b, dout_b);

    // READ addr 2
    rd_addr_a=2; rd_addr_b=2;
    @(posedge clk); #2;
    $display("%0t READ[2]  A=%0d (0x%0h)  B=%0d (0x%0h)", $time, dout_a, dout_a, dout_b, dout_b);

    #300 $finish;
  end

  initial begin
    $monitor($time,
      " rst_n=%b start=%b in_valid=%b busy=%b done=%b | rdA=%b addrA=%0d doutA=%0d | rdB=%b addrB=%0d doutB=%0d",
      rst_n, start, in_valid, busy, done, rd_en_a, rd_addr_a, dout_a, rd_en_b, rd_addr_b, dout_b
    );
  end
endmodule



// // tb/mem_controller_tb.v
// `timescale 1ns/1ps

// // local clog2 for TB params


// module mem_controller_tb;
//     function integer clog2;
//     input integer value; integer i;
//     begin
//         clog2 = 0;
//         for (i = value - 1; i > 0; i = i >> 1) clog2 = clog2 + 1;
//     end
//     endfunction
//   localparam PERIOD       = 4;
//   localparam DATA_WIDTH   = 8;
//   localparam VETOR_WIDTH  = 4;
//   localparam DEPTH        = VETOR_WIDTH * DATA_WIDTH;
//   localparam ADDR_WIDTH   = clog2(DEPTH);

//   reg clk = 0;
//   reg rst_n;

//   // write control
//   reg                    start;
//   reg                    in_valid;
//   reg  [DATA_WIDTH-1:0]  data_a;
//   reg  [DATA_WIDTH-1:0]  data_b;
//   wire                   busy;
//   wire                   done;

//   // read ports
//   reg                    rd_en_a;
//   reg  [ADDR_WIDTH-1:0]  rd_addr_a;
//   wire [DATA_WIDTH-1:0]  dout_a;

//   reg                    rd_en_b;
//   reg  [ADDR_WIDTH-1:0]  rd_addr_b;
//   wire [DATA_WIDTH-1:0]  dout_b;

//   // DUT
//   mem_controller #(
//     .DATA_WIDTH (DATA_WIDTH),
//     .VETOR_WIDTH(VETOR_WIDTH)
//   ) u_dut (
//     .clk(clk),
//     .rst_n(rst_n),
//     .start(start),
//     .in_valid(in_valid),
//     .data_a(data_a),
//     .data_b(data_b),
//     .busy(busy),
//     .done(done),
//     .rd_en_a(rd_en_a),
//     .rd_addr_a(rd_addr_a),
//     .dout_a(dout_a),
//     .rd_en_b(rd_en_b),
//     .rd_addr_b(rd_addr_b),
//     .dout_b(dout_b)
//   );

//   // clock
//   always #(PERIOD/2) clk = ~clk;

//   integer i;

//   // stimulus
//   initial begin
//     // init
//     rst_n = 0;
//     start = 0; in_valid = 0; data_a = 8'b0; data_b = 8'b0;
//     rd_en_a = 0; rd_en_b = 0; rd_addr_a = 8'b0; rd_addr_b = 8'b0;

//     // reset deassert
//     #100 rst_n = 1;

//     // start write burst
//     #10 start = 1; #PERIOD start = 0;

//     // stream DEPTH words (lockstep to both memories)
//     for (i = 0; i < DEPTH; i = i + 1) begin
//       in_valid = 1;
//       data_a   = i[DATA_WIDTH-1:0];         // expected in mem1
//       data_b   = ~i[DATA_WIDTH-1:0];        // expected in mem2
//       #PERIOD;
//     end
//     in_valid = 0;

//     // wait for done pulse
//     @(posedge clk);
//     wait (done);
//     @(posedge clk);

//     // read back & check (sync read: compare next cycle)
//     rd_en_a = 1; rd_en_b = 1;
//     for (i = 0; i < DEPTH; i = i + 1) begin
//       rd_addr_a = i[ADDR_WIDTH-1:0];
//       rd_addr_b = i[ADDR_WIDTH-1:0];
//       @(posedge clk); // data updates in DUT memories here
//       // compare at following half cycle to keep it simple
//       #(PERIOD/2);
//       if (dout_a !== i[DATA_WIDTH-1:0])
//         $error("mem1 mismatch @addr=%0d got=%0d exp=%0d", i, dout_a, i[DATA_WIDTH-1:0]);
//       if (dout_b !== ~i[DATA_WIDTH-1:0])
//         $error("mem2 mismatch @addr=%0d got=%0d exp=%0d", i, dout_b, ~i[DATA_WIDTH-1:0]);
//     end
//     rd_en_a = 0; rd_en_b = 0;

//     #100 $finish;
//   end

//   // simple live monitor like your format
//   initial begin
//     $monitor($time,
//       " rst_n=%b start=%b in_valid=%b busy=%b done=%b | rdA=%b addrA=%0d doutA=%0d | rdB=%b addrB=%0d doutB=%0d",
//       rst_n, start, in_valid, busy, done, rd_en_a, rd_addr_a, dout_a, rd_en_b, rd_addr_b, dout_b
//     );
//     #2000 $finish; // safety
//   end
// endmodule    

