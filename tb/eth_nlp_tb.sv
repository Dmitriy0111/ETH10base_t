/*
*  File            :   eth_nlp_tb.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2018.05.18
*  Language        :   SystemVerilog
*  Description     :   This is ethernet nlp testbench
*  Copyright(c)    :   2018 - 2019 Vlasov D.V.
*/

module eth_nlp_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    bit     [0  : 0]    clk;
    bit     [0  : 0]    resetn;
    logic   [0  : 0]    tx_nlp;
    logic   [0  : 0]    go;
    logic   [31 : 0]    c_out;

    eth_nlp 
    eth_nlp_0
    (
        .clk    ( clk       ),
        .resetn ( resetn    ),
        .tx_nlp ( tx_nlp    ),
        .go     ( go        ),
        .c_out  ( c_out     )
    );

    initial
        forever
            #(T/2) clk = ~ clk;
    
    initial
    begin
        resetn = '0;
        repeat(rst_delay) @(posedge clk);
        resetn = '1;
    end

endmodule : eth_nlp_tb
