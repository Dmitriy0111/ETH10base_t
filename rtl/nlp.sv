module nlp 
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     resetn,
    output  logic   [0 : 0]     go,
    output  logic   [0 : 0]     Tx
);

    logic   [31 : 0]    counter;

    always @(posedge clk, negedge resetn) 
        if( !resetn )
        begin
            counter <= '0;
            go <= '0;
            Tx <= '0;
        end
        begin
            counter <= counter + 1'b1;
            if ( counter == 160000*2 )
                Tx <= '1;
            if ( counter == 160000*2 + 1*2)
            begin
                Tx <= '0;
            end 
            if (counter == 160000*2+5*2+5*2+30000)
            begin
                go <= '1;
            end
            if (counter == 160000*2+5*2+5*2+5*2+30000)
            begin
                counter <= '0;
                go <= '0;
            end
        end

endmodule
