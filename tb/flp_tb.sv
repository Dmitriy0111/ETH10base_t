
module flp_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    bit     [0 : 0]     clk;
    bit     [0 : 0]     resetn;
    logic   [0 : 0]     Txp;
    logic   [0 : 0]     Txn;

    flp 
    flp_0
    (
        .clk    ( clk   ),
        .Txp    ( Txp   ),
        .Txn    ( Txn   )
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

endmodule : flp_tb