`timescale 1ns/1ns

module nlp_tb ();

	reg 		clk;
	wire		Txp;
	wire		Txn;

	nlp nlp_0
	(
		.clk(clk),
		.Txp(Txp),
		.Txn(Txn)
	);
always @(*)	#10 clk<=~clk;

initial
begin
	clk<=1'b0;
end

endmodule // nlp_tb
