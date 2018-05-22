`timescale 1ns/1ns

module ETH10base_t_tx_tb ();

wire    Led_Tx ;
reg     clk ;
wire    Txp ;
wire    Txn ;
reg     rst_n ;


ETH10base_t_tx ETH10base_t_tx_0
(
    .clk    (   clk     ),
    .Led_Tx (   Led_Tx  ),
    .Txp    (   Txp     ),
    .Txn    (   Txn     ),
    .rst_n  (   rst_n   )
);

always @(*) #25 clk <= ~ clk ;

initial
begin
    clk <= 1'b0 ;
    rst_n <= 1'b0 ;
    #20;
    rst_n <= 1'b1 ;
end

endmodule
