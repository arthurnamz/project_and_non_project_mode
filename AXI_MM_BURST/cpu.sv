`timescale 1ns/1ps

//==============================================================================
// AXI4 Slave with Integrated ALU
//==============================================================================
// Features:
//   - Byte-addressable memory (8-bit words)
//   - Burst read/write support (1-16 beats)
//   - FIXED and INCR burst types
//   - Integrated ALU computes during write (op1, op2, opcode → result)
//   - Data format: Byte0=op1, Byte1=op2, Byte2=opcode, Byte3=result
//==============================================================================

module cpu
#( 
  parameter ADDR_WIDTH  = 32,
  parameter DATA_WIDTH  = 8,
  parameter MEM_DATA_WIDTH = 8,
  parameter MEM_ADDR_WIDTH = 10,
  parameter MEM_SIZE = 1024
)
( 
   input clk,
   input rstn,
   
   // AXI Write Address Channel
   input [ADDR_WIDTH-1:0] awaddr,
   input awvalid,
   output reg awready,
   input [3:0] awlen,
   input [2:0] awsize,
   input [1:0] awburst,
   
   // AXI Write Data Channel
   input [DATA_WIDTH-1:0] wdata,
   input wvalid,
   output reg wready,
   input wlast,
   
   // AXI Write Response Channel
   output reg [1:0] bresp,
   output reg bvalid,
   input bready,
   
   // AXI Read Address Channel
   input [ADDR_WIDTH-1:0] araddr,
   input arvalid,
   input [3:0] arlen,
   input [2:0] arsize,
   input [1:0] arburst,
   output reg arready,
   
   // AXI Read Data Channel
   output reg [DATA_WIDTH-1:0] rdata,
   output reg rvalid,
   output reg rresp,
   input rready,
   output reg rlast
);

// Memory interface signals
reg mem_write_en;
reg [MEM_ADDR_WIDTH-1:0] mem_write_address;
reg [MEM_DATA_WIDTH-1:0] mem_data_in;
reg mem_read_en;
reg [MEM_ADDR_WIDTH-1:0] mem_read_address;
wire [MEM_DATA_WIDTH-1:0] mem_data_out;

// ALU interface signals
reg [DATA_WIDTH-1:0] alu_op1;
reg [DATA_WIDTH-1:0] alu_op2;
reg [DATA_WIDTH-1:0] alu_opcode;
wire [DATA_WIDTH-1:0] alu_result;

// Memory instantiation
memory #(
    .DATA_WIDTH(MEM_DATA_WIDTH), 
    .ADDR_WIDTH(MEM_ADDR_WIDTH),
    .MEM_SIZE(MEM_SIZE)
) u_memory (
    .clk(clk),
    .rst_n(rstn),
    
    // write interface
    .write_en(mem_write_en),
    .write_address(mem_write_address),
    .data_in(mem_data_in),
    
    // read interface
    .read_en(mem_read_en),
    .read_address(mem_read_address),
    .data_out(mem_data_out)
);

// ALU instantiation
alu #(
    .DATA_WIDTH(DATA_WIDTH)
) u_alu (
    .op1(alu_op1),
    .op2(alu_op2),
    .opcode(alu_opcode),
    .result(alu_result)
);

// Write FSM registers
reg [ADDR_WIDTH-1:0] waddr;
reg [3:0] burst_len, burst_count;
reg [2:0] write_size;
reg [1:0] write_burst_type;
reg [ADDR_WIDTH-1:0] write_addr_increment;

// Read FSM registers
reg [ADDR_WIDTH-1:0] raddr;
reg [3:0] read_burst_len, read_burst_count;
reg [2:0] read_size;
reg [1:0] read_burst_type;
reg [ADDR_WIDTH-1:0] read_addr_increment;

// ALU operands and result
reg [DATA_WIDTH-1:0] op1, op2, opcode, result;

// FSM States
typedef enum logic [1:0] {
  WR_IDLE = 2'b00, WR_DATA = 2'b01, WR_RESP = 2'b10
} wr_state_t;

typedef enum logic [1:0] {
  RD_IDLE = 2'b00, RD_WAIT = 2'b01, RD_DATA = 2'b10
} rd_state_t;

wr_state_t stateWR = WR_IDLE;
rd_state_t stateRD = RD_IDLE;


// Write FSM - Sequential logic
always @(posedge clk) begin
  if (~rstn) begin
    stateWR <= WR_IDLE;
    burst_count <= 4'b0;
    waddr <= 'b0;
    burst_len <= 'b0;
    write_size <= 'b0;
    write_burst_type <= 'b0;
    mem_write_en <= 1'b0;
    mem_write_address <= 'b0;
    mem_data_in <= 'b0;
    op1 <= 'b0;
    op2 <= 'b0;
    opcode <= 'b0;
    result <= 'b0;
    alu_op1 <= 'b0;
    alu_op2 <= 'b0;
    alu_opcode <= 'b0;
  end else begin
    case (stateWR)
      WR_IDLE: begin
        mem_write_en <= 1'b0;
        if (awvalid && awready) begin
          stateWR <= WR_DATA;
          waddr <= awaddr;
          burst_len <= awlen;
          burst_count <= 4'b0;
          
          write_size <= awsize;
          write_burst_type <= awburst;
          
          case (awsize)
            3'b000: write_addr_increment <= 1;
            3'b001: write_addr_increment <= 2;
            3'b010: write_addr_increment <= 4;
            3'b011: write_addr_increment <= 8;
            default: write_addr_increment <= 1;
          endcase
        end
      end
      
      WR_DATA: begin
        if (wvalid && wready) begin
          mem_write_en <= 1'b1;
          
          // Capture operands and compute result
          case (burst_count)
            4'd0: begin
              op1 <= wdata;
              alu_op1 <= wdata;
              mem_data_in <= wdata;
            end
            4'd1: begin
              op2 <= wdata;
              alu_op2 <= wdata;
              mem_data_in <= wdata;
            end
            4'd2: begin
              opcode <= wdata;
              alu_opcode <= wdata;
              mem_data_in <= wdata;
            end
            4'd3: begin
              result <= alu_result;
              mem_data_in <= alu_result;
            end
            default: mem_data_in <= wdata;
          endcase
          
          // Calculate memory address based on burst type
          case (write_burst_type)
            2'b00: mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0];
            2'b01: mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                        ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
            2'b10: mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                        ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
            default: mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                          ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
          endcase
          
          burst_count <= burst_count + 1;
          if (wlast) begin
            stateWR <= WR_RESP;
          end
        end else begin
          mem_write_en <= 1'b0;
        end
      end
      
      WR_RESP: begin
        mem_write_en <= 1'b0;
        if (bready && bvalid) begin
          stateWR <= WR_IDLE;
        end
      end
    endcase
  end 
end 

// Write FSM - Outputs
always @(stateWR or awvalid or wvalid or bready) begin
  awready = 1'b0;
  wready = 1'b0;
  bvalid = 1'b0;
  bresp = 2'b00;
  
  case (stateWR)
    WR_IDLE: begin
      awready = 1'b1;
      wready = 1'b0;
      bvalid = 1'b0;
    end
    WR_DATA: begin
      awready = 1'b0;
      wready = 1'b1;
    end
    WR_RESP: begin
      awready = 1'b0;
      wready = 1'b0;
      bvalid = 1'b1;
      bresp = 2'b00;
    end
    default: begin
      awready = 1'b0;
      wready = 1'b0;
      bvalid = 1'b0;
    end
  endcase
end

// Read FSM - Sequential logic
always @(posedge clk) begin
  if (~rstn) begin
    stateRD <= RD_IDLE;
    raddr <= 'b0;
    read_burst_len <= 'b0;
    read_burst_count <= 'b0;
    read_size <= 'b0;
    read_burst_type <= 'b0;
    mem_read_en <= 1'b0;
    mem_read_address <= 'b0;
    rvalid <= 1'b0;
    rdata <= 'b0;
    arready <= 1'b1;
    rresp <= 2'b00;
    rlast <= 1'b0;
  end else begin
    case (stateRD)
      RD_IDLE: begin
        rvalid <= 1'b0;
        rlast <= 1'b0;
        mem_read_en <= 1'b0;
        
        if (arvalid && arready) begin
          stateRD <= RD_WAIT;  // Go to wait state for memory latency
          raddr <= araddr;
          read_burst_len <= arlen;
          read_burst_count <= 4'b0;
          
          read_size <= arsize;
          read_burst_type <= arburst;
          
          case (arsize)
            3'b000: read_addr_increment <= 1;
            3'b001: read_addr_increment <= 2;
            3'b010: read_addr_increment <= 4;
            3'b011: read_addr_increment <= 8;
            default: read_addr_increment <= 1;
          endcase
          
          mem_read_en <= 1'b1;
          mem_read_address <= araddr[MEM_ADDR_WIDTH-1:0];
        end
      end
      
      RD_WAIT: begin
        mem_read_en <= 1'b0;
        rvalid <= 1'b0;
        rlast <= 1'b0;
        stateRD <= RD_DATA;
      end
      
      RD_DATA: begin
        mem_read_en <= 1'b0;
        rvalid <= 1'b1;
        rdata <= mem_data_out;
        rlast <= (read_burst_count == read_burst_len);
        
        if (rready && rvalid) begin
          if (rlast) begin
            stateRD <= RD_IDLE;
            rvalid <= 1'b0;
            rlast <= 1'b0;
            read_burst_count <= 4'b0;
          end else begin
            read_burst_count <= read_burst_count + 1;
            mem_read_en <= 1'b1;
            
            case (read_burst_type)
              2'b00: mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0];
              2'b01: mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                         (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
              2'b10: mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                         (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
              default: mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                           (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
            endcase
            
            stateRD <= RD_WAIT;
            rvalid <= 1'b0;
          end
        end
      end
      
      default: begin
        stateRD <= RD_IDLE;
        rvalid <= 1'b0;
        rlast <= 1'b0;
      end
    endcase
  end
end

// Read FSM - Outputs
always @(stateRD or arvalid or rready) begin
  arready = 1'b0;
  rresp = 2'b00;
  
  case (stateRD)
    RD_IDLE: begin
      arready = 1'b1;
      rresp = 2'b00;
    end
    RD_WAIT, RD_DATA: begin
      arready = 1'b0;
      rresp = 2'b00;
    end
    default: begin
      arready = 1'b0;
      rresp = 2'b00;
    end
  endcase
end

endmodule
