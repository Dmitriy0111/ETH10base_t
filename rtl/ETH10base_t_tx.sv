module ETH10base_t_tx
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     resetn,
    output  logic   [0 : 0]     Txp,
    output  logic   [0 : 0]     Txn,
    output  logic   [0 : 0]     Led_Tx
);

    logic   [0  : 0]    clk_20m;
    logic   [0  : 0]    eth_data_s;
    logic   [0  : 0]    Tx_nlp;
    logic   [0  : 0]    go;
    logic   [0  : 0]    Txn_nlp;
    logic   [0  : 0]    Txp_nlp;
    logic   [0  : 0]    Txn_TxD;
    logic   [0  : 0]    Txp_TxD;
    logic   [0  : 0]    Tx_w;

    logic   [15 : 0]    flp_data;
    logic   [4  : 0]    sel_field;      //Selector field
    logic   [7  : 0]    tech_field;     //Technology ability field
    logic   [0  : 0]    fault_field;    //remote fault
    logic   [0  : 0]    ack_field;      //acknowledgement
    logic   [0  : 0]    n_page_field;   //next page

    assign flp_data = {n_page_field,ack_field,fault_field,tech_field,sel_field};

    assign Txp_nlp = Tx_nlp == '1 ? '1 : '0;
    assign Txn_nlp = Tx_nlp == '1 ? '0 : '0;

    assign Txp_TxD = Tx_w ?   eth_data_s : '0;
    assign Txn_TxD = Tx_w ? ~ eth_data_s : '0;

    assign Txn = Txn_nlp | Txn_TxD;
    assign Txp = Txp_nlp | Txp_TxD;

    assign Led_Tx = ~ ( Tx_w );

    assign sel_field    = 5'b10000;     //Selector field
    assign tech_field   = 8'b0000010;   //Technology ability field
    assign fault_field  = 1'b0;         //remote fault
    assign ack_field    = 1'b1;         //acknowledgement
    assign n_page_field = 1'b0;         //next page

    eth_pll eth_pll_0
    (
        .inclk0     ( clk           ),
        .c0         ( clk_20m       )
    );
    // creating one flp
    flp 
    flp_0
    (
        .clk        ( clk_20m       ),
        .resetn     ( resetn        )
        .go         ( go            ),
        .Tx         ( Tx_nlp        ),
        .flp_data   ( flp_data      )
    );
    // creating one ethernet frame
    eth_frame 
    eth_frame_0
    (
        .transmit   ( go            ),
        .clk        ( clk_20m       ),
        .resetn     ( resetn        ),
        .eth_data_s ( eth_data_s    ),
        .Tx_w       ( Tx_w          )
    );

endmodule : ETH10base_t_tx
