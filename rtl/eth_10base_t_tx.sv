/*
*  File            :   eth_10base_t_tx.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2018.05.18
*  Language        :   SystemVerilog
*  Description     :   This is ethernet 10base-t transmitter module
*  Copyright(c)    :   2018 - 2019 Vlasov D.V.
*/

module eth_10base_t_tx
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     resetn,
    output  logic   [0 : 0]     tx_p,
    output  logic   [0 : 0]     tx_n,
    output  logic   [0 : 0]     led_tx,
    output  logic   [0 : 0]     mem_rd,
    input   logic   [7 : 0]     eth_in,
    output  logic   [0 : 0]     t_complete,
    input   logic   [0 : 0]     b_end
);

    logic   [0  : 0]    eth_data_s;
    logic   [0  : 0]    tx_nlp;
    logic   [0  : 0]    go;
    logic   [0  : 0]    tx_n_nlp;
    logic   [0  : 0]    tx_p_nlp;
    logic   [0  : 0]    tx_n_txd;
    logic   [0  : 0]    tx_p_txd;
    logic   [0  : 0]    tx_w;
    logic   [31 : 0]    c_out;

    assign tx_n_nlp = tx_nlp == 1'b1 ? 1'b0 : 1'b0;
    assign tx_p_nlp = tx_nlp == 1'b1 ? 1'b1 : 1'b0;

    assign tx_n_txd = tx_w ? ~ eth_data_s : 1'b0;
    assign tx_p_txd = tx_w ?   eth_data_s : 1'b0;

    assign tx_n = tx_n_nlp | tx_n_txd;
    assign tx_p = tx_p_nlp | tx_p_txd;

    assign led_tx = ~ ( tx_w );

    eth_nlp 
    eth_nlp_0
    (
        .clk        ( clk           ),
        .resetn     ( resetn        ),
        .go         ( go            ),
        .tx_nlp     ( tx_nlp        ),
        .c_out      ( c_out         )
    );

    eth_frame 
    eth_frame_0
    (
        .transmit   ( go            ),
        .clk        ( clk           ),
        .resetn     ( resetn        ),
        .eth_data_s ( eth_data_s    ),
        .tx_w       ( tx_w          ),
        .mem_rd     ( mem_rd        ),
        .eth_in     ( eth_in        ),
        .t_complete ( t_complete    ),
        .b_end      ( b_end         )
    );

endmodule : eth_10base_t_tx
