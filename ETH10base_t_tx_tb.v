`timescale 1ns/1ns

module ETH10base_t_tx_tb ();

wire TxData;
reg	clk;
reg TxDataMem [99:0];
wire Txp;
wire Txn;
reg rst_n;

integer i;
assign TxData = TxDataMem[i];

ETH10base_t_tx ETH10base_t_tx_0
(
	.clk(clk),
	.TxData(TxData),
	.Txp(Txp),
	.Txn   (Txn),
	.rst_n(rst_n)
);

always @(*)	#50 clk<=~clk;


initial
begin
	clk<=1'b0;
	rst_n<=1'b0;
	#20;
	rst_n<=1'b1;
end

initial
begin
	$readmemh("/home/vlasovdv0111/ETH10base_t/TxDataMem.hex",TxDataMem);
end

endmodule
