
module skew2(
	input clk,
	input d,
	input c,
	output reg q1,
	output reg q2,
	output reg q3
);

	wire clk_delayed;
	always @(posedge clk) q1 <= d;

	always @(posedge clk_delayed) q2 <= d;
	always @(posedge clk_delayed) q3 <=q2 ^ c;

	BUFGCE BUFGCE_inst (
		.O(clk_delayed),
		.CE(c),
		.I(clk)
);
endmodule
