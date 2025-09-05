
`timescale 1ns/1ps

module seven_segment_display #(
  parameter  DATA_WIDTH   = 3,
  parameter  RESULT_WIDTH = 7
)(
  input  wire [DATA_WIDTH-1:0]   dataIN,   
  output reg  [RESULT_WIDTH-1:0] dataOUT    
);

    always @(*) begin
        case (dataIN)
            3'b000: dataOUT = 7'b1000000; // 0
            3'b001: dataOUT = 7'b1111001; // 1
            3'b010: dataOUT = 7'b0100100; // 2
            3'b011: dataOUT = 7'b0110000; // 3
            3'b100: dataOUT = 7'b0011001; // 4
            3'b101: dataOUT = 7'b0010010; // 5
            3'b110: dataOUT = 7'b0000010; // 6
            3'b111: dataOUT = 7'b1111000; // 7
            default: dataOUT = 7'b1111111; // Blank
        endcase
    end
endmodule