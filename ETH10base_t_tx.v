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
wire go;
wire Txn_nlp;
wire Txp_nlp;
wire Txn_TxD;
wire Txp_TxD;
wire Tx_w;

wire [15:0] flp_data;
wire [4:0]  sel_field    = 5'b10000;     //Selector field
wire [7:0]  tech_field   = 8'b0000010;   //Technology ability field
wire        fault_field  = 1'b0;         //remote fault
wire        ack_field    = 1'b1;         //acknowledgement
wire        n_page_field = 1'b0;         //next page

assign flp_data = {n_page_field,ack_field,fault_field,tech_field,sel_field};

eth_pll eth_pll_0
(
    .inclk0 (   clk     ),
    .c0     (   clk_20m )
);

//assign clk_20m = clk;

assign Txp_nlp = Tx_nlp == 1'b1 ? 1'b1 : 1'b0 ;
assign Txn_nlp = Tx_nlp == 1'b1 ? 1'b0 : 1'b0 ;

assign Txp_TxD = Tx_w ?   eth_data_s : 1'b0 ;
assign Txn_TxD = Tx_w ? ~ eth_data_s : 1'b0 ;

assign Txn = Txn_nlp | Txn_TxD ;
assign Txp = Txp_nlp | Txp_TxD ;

assign Led_Tx = ~ ( Tx_w ) ;

flp flp_0
    (
        .clk      ( clk_20m   ),
        .go       ( go        ),
        .Tx       ( Tx_nlp    ),
        .flp_data ( flp_data  )
    );

eth_frame eth_frame_0
(
    .transmit   ( go            ),
    .clk        ( clk_20m       ),
    .rst_n      ( rst_n         ),
    .eth_data_s ( eth_data_s    ),
    .Tx_w       ( Tx_w          )
);

endmodule
