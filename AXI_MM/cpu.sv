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
state_t stateWR;
state_t stateRD;

// control flow
always @(posedge clk ) begin
  if (~rstn) begin
    stateWR <= IDLE;
  end else begin
    case (stateWR)
      IDLE: begin
        if (awvalid) begin
          stateWR <= WR_DATA;
        end
      end
    
      WR_DATA: begin
        if (wvalid) begin
          stateWR <= WR_RESP;
        end
      end
      WR_RESP: begin
        if (bready) begin
          stateWR <= IDLE;
        end
      end
    endcase

  end 
end 

// data flow
always @(*) begin
  case (stateWR)
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

// compute results
always @(*) begin
  case (opcode)
    0: result = op1 + op2;
    1: result = op1 - op2;
    2: result = ~op1;
    3: result = op1 << op2;  
  endcase
end

// read data FSM
always @(posedge clk) begin
  if (~rstn) begin
    stateRD <= IDLE;
  end else begin
    case (stateRD)
      IDLE: begin
        if (arvalid ) begin
          stateRD <= RD_DATA;
        end
      end
      RD_DATA: begin
        if (rready) begin
          stateRD <= IDLE;
        end
      end
    endcase
  end
end

always @(*) begin
  case (stateRD)
    IDLE: begin
      raddr = araddr;
      arready = 1'b1;
      rvalid = 1'b0;
      rresp = 2'b00;
    end
    RD_DATA: begin
      arready = 1'b0;
      rvalid = 1'b1;
         if (raddr == 0) begin
          rdata = op1;
         end else if (raddr == 1) begin
            rdata = op2;  
         end else if (raddr == 2) begin
          rdata = opcode;
         end else if (raddr == 3) begin
            rdata = result;
         end else begin
          rdata = 'bx;
            rresp = 2'b01;
         end
    end
  endcase
end
endmodule