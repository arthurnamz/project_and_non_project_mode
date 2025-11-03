`timescale 1ns/1ps


module cpu
#( 
  parameter ADDR_WIDTH  = 32,
  parameter DATA_WIDTH  = 8
)
( 
   input clk,
   input rstn,

    // write address channel
    input [ADDR_WIDTH-1:0] awaddr,
    input awvalid,
    output reg awready,

    // write data channel
    input [DATA_WIDTH-1:0] wdata,
    input wvalid,
    output reg wready,

    // write response channel
    output reg [1:0] bresp,
    output reg bvalid,
    input bready,

    // read address channel
    input [ADDR_WIDTH-1:0] araddr,
    input arvalid,
    output reg arready,

    // read data channel
    output reg [DATA_WIDTH-1:0] rdata,
    output reg rvalid,
    output reg rresp,
    input rready


);
reg [ADDR_WIDTH-1:0] waddr;
reg [ADDR_WIDTH-1:0] raddr;
reg [DATA_WIDTH-1:0] tmp_data;

reg [DATA_WIDTH-1:0] op1;
reg [DATA_WIDTH-1:0] op2;
reg [DATA_WIDTH-1:0] opcode;
reg [DATA_WIDTH-1:0] result;
typedef enum {IDLE, WR_DATA, WR_RESP, RD_ADDR, RD_DATA} state_t;
state_t state;

// control flow
always @(posedge clk ) begin
  if (~rstn) begin
    state <= IDLE;
  end else begin
    case (state)
      IDLE: begin
        if (awvalid) begin
          state <= WR_DATA;
        end
      end
    
      WR_DATA: begin
        if (wvalid) begin
          state <= WR_RESP;
        end
      end
      WR_RESP: begin
        if (bready) begin
          state <= IDLE;
        end
      end
      RD_ADDR: begin
        if (rready) begin
          state <= RD_DATA;
        end
      end
      RD_DATA: begin
        if (rvalid) begin
          state <= RD_RESP;
        end
      end
      default: begin
        state <= IDLE;
      end
    endcase

  end 
end 

// data flow
always @(*) begin
  case (state)
    IDLE: begin
      wready = 1'b0;
      awready = 1'b1;
      bvalid = 1'b0;
      waddr = awaddr;
      raddr = araddr;
      
    end

    WR_DATA: begin
      wready = 1'b1;
      awready = 1'b0;
      tmp_data = wdata;
    end
    WR_RESP: begin
      wready = 1'b0;
      bvalid = 1'b1;
       
      if (waddr == 0) begin
        op1 = tmp_data;
        bresp = 2'b00;
      end
        else if (waddr == 1) begin
          op2 = tmp_data;
          bresp = 2'b00;
        end
        else if (waddr == 2) begin
          opcode = tmp_data;
          bresp = 2'b00;
        end
        else begin
          bresp = 2'b01;
        end
  end
  endcase
end
endmodule