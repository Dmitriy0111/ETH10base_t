/*
*  File            :   eth_10base_t_tx_tb.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2018.05.18
*  Language        :   SystemVerilog
*  Description     :   This is ethernet 10base-t testbench
*  Copyright(c)    :   2018 - 2019 Vlasov D.V.
*/

module eth_10base_t_tx_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    logic   [0 : 0]     led_tx;
    bit     [0 : 0]     clk;
    bit     [0 : 0]     resetn;
    logic   [0 : 0]     tx_p;
    logic   [0 : 0]     tx_n;


    eth_10base_t_tx 
    eth_10base_t_tx_0
    (
        .clk    ( clk       ),
        .resetn ( resetn    ),
        .led_tx ( led_tx    ),
        .tx_p   ( tx_p      ),
        .tx_n   ( tx_n      )
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

endmodule : eth_10base_t_tx_tb
