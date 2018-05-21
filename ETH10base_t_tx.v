module ETH10base_t_tx
(
	input	clk,
	input 	rst_n,
	output	Txp,
	output	Txn,
	output 	Led_Tx
);

wire clk_10m;
wire eth_data_s;
//reg	TxClock;
reg clkDiv;
wire Tx_nlp;
wire Tx_frame;
wire Tx_idle;
wire go;
wire Txn_nlp;
wire Txp_nlp;
wire Txn_idle;
wire Txp_idle;
wire Txn_frame;
wire Txp_frame;
wire eth_data_s_manch;

eth_pll eth_pll_0
(
	.inclk0(clk),
	.c0(clk_10m)
);

//assign clk_10m = clk;
assign eth_data_s_manch = clk^eth_data_s;

assign Txp_nlp = Tx_nlp == 1'b1 ? 1'b1 : 1'b0 ;
assign Txn_nlp = Tx_nlp == 1'b1 ? 1'b0 : 1'b0 ;

assign Txp_idle = Tx_idle == 1'b1 ? 1'b1 : 1'b0 ;
assign Txn_idle = Tx_idle == 1'b1 ? 1'b0 : 1'b0 ;

assign Txp_frame = Tx_frame == 1'b1 ? eth_data_s_manch : 1'b0 ;
assign Txn_frame = Tx_frame == 1'b1 ? ~eth_data_s_manch : 1'b0 ;

assign Txn = Txn_frame | Txn_nlp | Txn_idle;
assign Txp = Txp_frame | Txp_nlp | Txp_idle;

assign Led_Tx = ~ (Tx_frame | Tx_idle);

always @(posedge clk) begin
	clkDiv<=~clkDiv;
end

nlp nlp_0
	(
		.clk(clk_10m),
		.go(go),
		.Tx(Tx_nlp)
	);

eth_frame eth_frame_0
(
	.transmit(go),
	.clk(clk_10m),
	.rst_n(rst_n),
	.eth_data_s(eth_data_s),
	.enable(1'b1),
	.Tx        (Tx_frame),
	.Tx_idle(Tx_idle)
);

initial
begin
	clkDiv = 1'b0;
end

/*always @(posedge clk) 
begin : Transmit
		 TxClock <= ~TxClock;
end

initial
begin
	TxClock=0;
end
*/
endmodule
