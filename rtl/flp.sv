module flp
(
    input   logic   [0  : 0]    clk,
    input   logic   [0  : 0]    resetn,
    output  logic   [0  : 0]    go,
    output  logic   [0  : 0]    Tx,
    input   logic   [15 : 0]    flp_data
);

    logic   [19 : 0]    counter;
    logic   [3  : 0]    pointer;
    logic   [11 : 0]    flp_counter;
    logic   [0  : 0]    clk_data;


    always @(posedge clk, negedge resetn) 
        if( !resetn )
        begin
            clk_data    = '0;
            flp_counter = '0;
            pointer     = '0;
            counter     = '0;
            Tx          = '0;
        end
        begin
            if( counter < 42500 )
                flp_counter <= flp_counter  + 1'b1;
            if( counter == 42600 )
                go <= '1;
            if( counter == 42604 )
                go <= '0;
            if( flp_counter == 1240 )
            begin
                if( clk_data == 1'b0 )
                    Tx <= '1;
                else
                    Tx <= flp_data [pointer];
            end
            if( flp_counter == 1243 )
            begin
                flp_counter <= '0;
                clk_data <= ~ clk_data;
                if( clk_data == 1'b1 )
                    pointer <= pointer + 1'b1; 
                Tx <= '0;
            end
            counter <= counter + 1'b1;
            if( counter == 360000 )
            begin
                counter <= '0;
                pointer <= '0;
                flp_counter <= '0;
            end
        end

endmodule : flp
