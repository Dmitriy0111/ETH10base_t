/*
*  File            :   eth_nlp.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2018.05.18
*  Language        :   SystemVerilog
*  Description     :   This is ethernet nlp module
*  Copyright(c)    :   2018 - 2019 Vlasov D.V.
*/

module eth_nlp 
(
    input   logic   [0  : 0]    clk,
    input   logic   [0  : 0]    resetn,
    output  logic   [0  : 0]    go,
    output  logic   [0  : 0]    tx_nlp,
    output  logic   [31 : 0]    c_out
);

    logic   [31 : 0]    counter;

    assign c_out = counter;

    always_ff @(posedge clk, negedge resetn) 
        if( !resetn )
        begin
            counter <= '0;
            go <= '0;
            tx_nlp <= '0;
        end
        else
        begin
            counter <= counter + 1'b1 ;
            if ( counter == 0 )
                tx_nlp <= 1'b1 ;
            if ( counter == 8)
            begin
                tx_nlp <= 1'b0 ;
            end 
            if (counter == 1440000)
            begin
                counter <= 32'h00000 ;
            end
        end

endmodule : eth_nlp
