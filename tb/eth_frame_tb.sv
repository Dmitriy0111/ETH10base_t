
module eth_frame_tb ();

    timeunit            1ns;
    timeprecision       1ns;

    localparam          T = 10,
                        rst_delay = 7;

    logic   [0 : 0]     transmit;
    bit     [0 : 0]     clk;
    bit     [0 : 0]     resetn;
    logic   [0 : 0]     eth_data_s;

    eth_frame 
    eth_frame_0
    (
        .transmit   ( transmit      ),
        .clk        ( clk           ),
        .resetn     ( resetn        ),
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
        @(posedge clk);
        transmit = '1;
        #20
        transmit = '0;
    end

endmodule : eth_frame_tb
