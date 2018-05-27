module nlp 
(
    input               clk,
    output  reg         go,
    output  reg         Tx
);

reg [31:0]  counter ;

always @(posedge clk) 
begin
    counter <= counter + 1'b1 ;
    if ( counter == 160000*2 )
        Tx <= 1'b1 ;
    if ( counter == 160000*2 + 1*2)
    begin
        Tx <= 1'b0 ;
    end 
    if (counter == 160000*2+5*2+5*2+30000)
    begin
        go <= 1'b1 ;
    end
    if (counter == 160000*2+5*2+5*2+5*2+30000)
    begin
        counter <= 32'h00000 ;
        go <= 1'b0 ;
    end
end

initial
begin
    counter = 32'b0 ;
    Tx      = 1'b0 ;
    go      = 1'b0 ;
end

endmodule
