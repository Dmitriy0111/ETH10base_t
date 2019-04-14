/*
*  File            :   eth_frame_tb.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2018.05.18
*  Language        :   SystemVerilog
*  Description     :   This is ethernet frame testbench
*  Copyright(c)    :   2018 - 2019 Vlasov D.V.
*/

module eth_frame_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    bit     [0 : 0]     clk;
    bit     [0 : 0]     resetn;
    logic   [0 : 0]     transmit;
    logic   [0 : 0]     eth_data_s;
    logic   [0 : 0]     tx_w;

    eth_frame 
    eth_frame_0
    (
        .clk        ( clk           ),
        .resetn     ( resetn        ),
        .transmit   ( transmit      ),
        .tx_w       ( tx_w          ),
        .eth_data_s ( eth_data_s    )
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

    initial
    begin
        transmit = '0;
        repeat(rst_delay + 20) @(posedge clk);
        transmit = '1;
        #20
        transmit = '0;
    end

endmodule : eth_frame_tb
