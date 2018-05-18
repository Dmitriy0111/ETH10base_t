module ETH10base_t
(
	input	clk,
	output	Txp,
	output	Txn

);
/*	reg	TxData;
always @(posedge clk) begin
	TxData<=~TxData;
end

ETH10base_t_tx ETH10base_t_tx_0
(
	.clk(clk),
	.TxData(TxData),
	.Txp(Txp)
);*/

nlp nlp_0
	(
		.clk(clk),
		.Txp(Txp),
		.Txn(Txn)
	);

endmodule
