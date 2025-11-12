`timescale 1ns/1ps

//==============================================================================
// AXI4 Memory-Mapped Burst Slave
//==============================================================================
// Description:
//   AXI4 slave supporting burst read/write transactions with byte-addressable
//   memory backend.
//
// AXI Specification Compliance:
//   - AxBURST signals (AWBURST/ARBURST): Table A3.9
//     * 0b00 = FIXED (same address)
//     * 0b01 = INCR (incrementing, default)
//     * 0b10 = WRAP (simplified as INCR)
//     * 0b11 = RESERVED
//   - AxSIZE signals: bytes per beat = 2^AxSIZE
//     * Supports 1, 2, 4, 8 byte transfers
//   - AxLEN signals: burst length = AxLEN + 1
//     * Max 16 beats in this implementation
//
// Features:
//   ✓ Byte-addressable memory (8-bit words)
//   ✓ Variable burst length (1-16 beats)
//   ✓ Variable transfer size (1-8 bytes per beat)
//   ✓ FIXED and INCR burst types
//   ✓ Proper AXI handshaking with valid/ready
//   ✓ Single response after complete burst
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

    // write address channel
    input [ADDR_WIDTH-1:0] awaddr,
    input awvalid,
    output reg awready,
    input [3:0] awlen,       // Burst length (number of transfers - 1)
    input [2:0] awsize,      // Burst size (bytes per beat = 2^awsize)
    input [1:0] awburst,     // Burst type: 00=FIXED, 01=INCR, 10=WRAP (AXI spec Table A3.9)


    // write data channel
    input [DATA_WIDTH-1:0] wdata,
    input wvalid,
    output reg wready,
    input wlast,
    
    // write response channel
    output reg [1:0] bresp,
    output reg bvalid,
    input bready,

    // read address channel
    input [ADDR_WIDTH-1:0] araddr,
    input arvalid,
    input [3:0] arlen,       // Burst length (number of transfers - 1)
    input [2:0] arsize,      // Burst size (bytes per beat = 2^arsize)
    input [1:0] arburst,     // Burst type: 00=FIXED, 01=INCR, 10=WRAP (AXI spec Table A3.9)
    output reg arready,

    // read data channel
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

// Write transaction registers
reg [ADDR_WIDTH-1:0] waddr;
reg [3:0] burst_len;
reg [3:0] burst_count;
reg [2:0] write_size;
reg [1:0] write_burst_type;
reg [ADDR_WIDTH-1:0] write_addr_increment;

// Read transaction registers
reg [ADDR_WIDTH-1:0] raddr;
reg [3:0] read_burst_len;
reg [3:0] read_burst_count;
reg [2:0] read_size;
reg [1:0] read_burst_type;
reg [ADDR_WIDTH-1:0] read_addr_increment;
// Write FSM states
typedef enum logic [1:0] {
  WR_IDLE  = 2'b00,
  WR_DATA  = 2'b01,
  WR_RESP  = 2'b10
} wr_state_t;

// Read FSM states  
typedef enum logic [1:0] {
  RD_IDLE  = 2'b00,
  RD_WAIT  = 2'b01,
  RD_DATA  = 2'b10
} rd_state_t;

wr_state_t stateWR = WR_IDLE;
rd_state_t stateRD = RD_IDLE;

// Initialize outputs
initial begin
  awready = 1'b0;
  wready = 1'b0;
  bvalid = 1'b0;
  bresp = 2'b00;
  arready = 1'b0;
  rvalid = 1'b0;
  rdata = 'b0;
  rresp = 1'b0;
  rlast = 1'b0;
end

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
  end else begin
    case (stateWR)
      WR_IDLE: begin
        mem_write_en <= 1'b0;
        if (awvalid && awready) begin
          stateWR <= WR_DATA;
          waddr <= awaddr;
          burst_len <= awlen;
          burst_count <= 4'b0;
          
          // Capture burst control signals
          write_size <= awsize;
          write_burst_type <= awburst;
          
          // Calculate address increment based on transfer size
          case (awsize)
            3'b000: write_addr_increment <= 1;  // 1 byte (2^0)
            3'b001: write_addr_increment <= 2;  // 2 bytes (2^1)
            3'b010: write_addr_increment <= 4;  // 4 bytes (2^2)
            3'b011: write_addr_increment <= 8;  // 8 bytes (2^3)
            default: write_addr_increment <= 1;
          endcase
        end
      end
      
      WR_DATA: begin
        if (wvalid && wready) begin
          // Write to memory with CURRENT burst_count before incrementing
          mem_write_en <= 1'b1;
          mem_data_in <= wdata;
          
          // Calculate memory address based on burst type (AXI spec Table A3.9)
          case (write_burst_type)
            2'b00: begin  // FIXED - same address for all beats
              mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0];
            end
            
            2'b01: begin  // INCR - incrementing address (default per AXI spec)
              mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                   ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
            end
            
            2'b10: begin  // WRAP - wrapping burst (simplified implementation)
              // Full WRAP requires boundary calculation; using INCR for simplicity
              mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                   ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
            end
            
            default: begin  // Reserved (0b11) - default to INCR
              mem_write_address <= waddr[MEM_ADDR_WIDTH-1:0] + 
                                   ({{(MEM_ADDR_WIDTH-4){1'b0}}, burst_count} * write_addr_increment[MEM_ADDR_WIDTH-1:0]);
            end
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

// Write FSM - Combinational outputs
// Note: Using explicit sensitivity list instead of @(*) because some simulators
// don't trigger @(*) reliably when enum state variables change
always @(stateWR or awvalid or wvalid or bready) begin
  // Default values
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
      bresp = 2'b00;  // OKAY response
    end
    
    default: begin
      awready = 1'b0;
      wready = 1'b0;
      bvalid = 1'b0;
    end
  endcase
end

// // compute results
// always @(*) begin
//   case (opcode)
//     0: result = op1 + op2;
//     1: result = op1 - op2;
//     2: result = ~op1;
//     3: result = op1 << op2;  
//   endcase
// end

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
    arready <= 1'b1;  // Ready in IDLE state
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
          
          // Capture burst control signals
          read_size <= arsize;
          read_burst_type <= arburst;
          
          // Calculate address increment based on transfer size
          case (arsize)
            3'b000: read_addr_increment <= 1;  // 1 byte (2^0)
            3'b001: read_addr_increment <= 2;  // 2 bytes (2^1)
            3'b010: read_addr_increment <= 4;  // 4 bytes (2^2)
            3'b011: read_addr_increment <= 8;  // 8 bytes (2^3)
            default: read_addr_increment <= 1;
          endcase
          
          // Start first memory read
          mem_read_en <= 1'b1;
          mem_read_address <= araddr[MEM_ADDR_WIDTH-1:0];
        end
      end
      
      RD_WAIT: begin
        // Wait one cycle for memory read to complete
        mem_read_en <= 1'b0;
        rvalid <= 1'b0;
        rlast <= 1'b0;
        stateRD <= RD_DATA;
      end
      
      RD_DATA: begin
        mem_read_en <= 1'b0;
        
        // Memory data is available now
        rvalid <= 1'b1;
        rdata <= mem_data_out;
        rlast <= (read_burst_count == read_burst_len);
        
        if (rready && rvalid) begin
          if (rlast) begin
            // Last beat - go back to IDLE
            stateRD <= RD_IDLE;
            rvalid <= 1'b0;
            rlast <= 1'b0;
            read_burst_count <= 4'b0;
          end else begin
            // More beats to go - calculate next address and start next read
            read_burst_count <= read_burst_count + 1;
            mem_read_en <= 1'b1;
            
            // Calculate next address based on burst type (AXI spec Table A3.9)
            case (read_burst_type)
              2'b00: begin  // FIXED - same address for all beats
                mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0];
              end
              
              2'b01: begin  // INCR - incrementing address (default per AXI spec)
                mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                    (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
              end
              
              2'b10: begin  // WRAP - wrapping burst (simplified implementation)
                // Full WRAP requires boundary calculation; using INCR for simplicity
                mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                    (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
              end
              
              default: begin  // Reserved (0b11) - default to INCR
                mem_read_address <= raddr[MEM_ADDR_WIDTH-1:0] + 
                                    (({{(MEM_ADDR_WIDTH-4){1'b0}}, read_burst_count} + 1) * read_addr_increment[MEM_ADDR_WIDTH-1:0]);
              end
            endcase
            
            stateRD <= RD_WAIT;  // Wait for next memory read
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

// Read FSM - Combinational outputs
// Note: Using explicit sensitivity list instead of @(*) because some simulators
// don't trigger @(*) reliably when enum state variables change
always @(stateRD or arvalid or rready) begin
  // Default values
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
