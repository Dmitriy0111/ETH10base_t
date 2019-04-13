
module ETH10base_t_tx_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    logic   [0 : 0]     Led_Tx;
    bit     [0 : 0]     clk;
    bit     [0 : 0]     resetn;
    logic   [0 : 0]     Txp;
    logic   [0 : 0]     Txn;

    ETH10base_t_tx 
    ETH10base_t_tx_0
    (
        .clk    ( clk       ),
        .Led_Tx ( Led_Tx    ),
        .Txp    ( Txp       ),
        .Txn    ( Txn       ),
        .resetn ( resetn    )
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

endmodule : ETH10base_t_tx_tb
