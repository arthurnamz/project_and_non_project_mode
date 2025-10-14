
module skew(
	input clk,
	input d,
	input c,
	output reg q1,
	output reg q2,
	output reg q3
);

	wire clk_delayed;
	assign clk_delayed = clk & c;

	always @(posedge clk)  q1 <= d;


	always @(posedge clk_delayed) q2 <= d;
	always @(posedge clk_delayed) q3 <= q2 ^ c;

endmodule

