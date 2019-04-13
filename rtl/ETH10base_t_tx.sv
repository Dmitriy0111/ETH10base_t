module ETH10base_t_tx
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     resetn,
    output  logic   [0 : 0]     Txp,
    output  logic   [0 : 0]     Txn,
    output  logic   [0 : 0]     Led_Tx
);

    logic   [0 : 0]     clk_20m;
    logic   [0 : 0]     eth_data_s;
    logic   [0 : 0]     Tx_nlp;
    logic   [0 : 0]     go;
    logic   [0 : 0]     Txn_nlp;
    logic   [0 : 0]     Txp_nlp;
    logic   [0 : 0]     Txn_TxD;
    logic   [0 : 0]     Txp_TxD;
    logic   [0 : 0]     Tx_w;

    assign Txp_nlp = Tx_nlp == 1'b1 ? 1'b1 : 1'b0;
    assign Txn_nlp = Tx_nlp == 1'b1 ? 1'b0 : 1'b0;

    assign Txp_TxD = Tx_w ?   eth_data_s : 1'b0;
    assign Txn_TxD = Tx_w ? ~ eth_data_s : 1'b0;

    assign Txn = Txn_nlp | Txn_TxD;
    assign Txp = Txp_nlp | Txp_TxD;

    assign Led_Tx = ~ ( Tx_w );

    eth_pll 
    eth_pll_0
    (
        .inclk0     ( clk           ),
        .c0         ( clk_20m       )
    );

    nlp 
    nlp_0
    (
        .clk        ( clk_20m       ),
        .resetn     ( resetn        )
        .go         ( go            ),
        .Tx         ( Tx_nlp        )
    );

    eth_frame eth_frame_0
    (
        .transmit   ( go            ),
        .clk        ( clk_20m       ),
        .resetn     ( resetn        ),
        .eth_data_s ( eth_data_s    ),
        .Tx_w       ( Tx_w          )
    );

endmodule
