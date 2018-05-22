module ETH10base_t_tx
(
    input   clk,
    input   rst_n,
    output  Txp,
    output  Txn,
    output  Led_Tx
);

wire clk_20m;
wire eth_data_s;
wire Tx_nlp;
wire Tx_frame;
wire Tx_idle;
wire go;
wire Txn_nlp;
wire Txp_nlp;
wire Txn_TxD;
wire Txp_TxD;
wire eth_data_s_manch;
wire TxD;

eth_pll eth_pll_0
(
    .inclk0 (   clk     ),
    .c0     (   clk_20m )
);

//assign clk_20m = clk;

assign eth_data_s_manch = eth_data_s ;

assign Txp_nlp = Tx_nlp == 1'b1 ? 1'b1 : 1'b0 ;
assign Txn_nlp = Tx_nlp == 1'b1 ? 1'b0 : 1'b0 ;

assign Txp_TxD = ( Tx_frame | Tx_idle ) ?   eth_data_s_manch : 1'b0 ;
assign Txn_TxD = ( Tx_frame | Tx_idle ) ? ~ eth_data_s_manch : 1'b0 ;

assign Txn = Txn_nlp | Txn_TxD ;
assign Txp = Txp_nlp | Txp_TxD ;

assign Led_Tx = ~ ( Tx_frame | Tx_idle ) ;

nlp nlp_0
    (
        .clk    ( clk_20m   ),
        .go     ( go        ),
        .Tx     ( Tx_nlp    )
    );

eth_frame eth_frame_0
(
    .transmit   ( go            ),
    .clk        ( clk_20m       ),
    .rst_n      ( rst_n         ),
    .eth_data_s ( eth_data_s    ),
    .Tx         ( Tx_frame      ),
    .Tx_idle    ( Tx_idle       ),
    .TxD        ( TxD           )
);

endmodule
