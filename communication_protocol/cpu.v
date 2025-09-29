`timescale 1ns/1ps


module cpu
#( 
  parameter DATA_WIDTH  = 16
)
( 
   input clk,
   input rstn,

   // slave interface
   input axis_tvalid,
   output reg axis_tready,
   input [DATA_WIDTH-1:0] axis_tdata, 

   //master interface
   output reg axim_tvalid,
   input axim_tready,
   output reg [DATA_WIDTH-1:0] axim_tdata

);

parameter IDLE = 0;
parameter FETCH = 1;
parameter DEC = 2;
parameter LOAD_OP = 3;
parameter EXEC = 4;
parameter WRITE_BACK = 5;


reg [2:0] state;

reg [DATA_WIDTH-1:0] axis_tdata_reg;
reg [3:0] opCode;
reg [5:0] opA;
reg [5:0] opB;
reg [DATA_WIDTH-1:0] result;

//always block that controls transitions between states
always@(posedge clk) begin

	if(~rstn) begin
		state <= IDLE;
	end else begin
           case (state)
              IDLE:
		    if(axis_tvalid)
			   state <= FETCH; 

	      FETCH:
		     state <= DEC; 

	      DEC:
		      state <= LOAD_OP;

	      LOAD_OP:
		      state <= EXEC;

	      EXEC:
		      state <= WRITE_BACK;

	      WRITE_BACK:
		       if(axim_tready)
			  state <= IDLE;     

           endcase
        end

end	


//always block that defines what happens in each state
always @(*) begin

	case(state)
		IDLE: begin
                axis_tready = 1'b1;           			
		        axim_tvalid = 0;
                axis_tdata_reg = axis_tdata;
		      end
	        FETCH:begin
                    axis_tready = 0;

	              end
                DEC:  begin
                       opCode = axis_tdata_reg[3:0];
                      end
                LOAD_OP: begin
                           opA = axis_tdata_reg[9:4];
                           opB = axis_tdata_reg[15:10]; 
                         end
               	EXEC: begin
						if(opCode == 0)
							result = opA + opB;
						else
							if(opCode == 1)
								result = opA | opB;
									else
								if(opCode == 2)
									result = opA & opB;
									else
									if(opCode == 3)
									result = opA >> opB;				
                      end
                WRITE_BACK: begin
								axim_tvalid = 1;
								axim_tdata = result;
                            end			
	endcase
end


endmodule

