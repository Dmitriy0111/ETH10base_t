module flp
(
    input               clk,
    output  reg         go,
    output  reg         Tx,
    input       [15:0]  flp_data
);

reg [19:0]      counter ;
reg [3:0]       pointer ;
reg [11:0]      flp_counter ;
reg             clk_data ;


always @(posedge clk) 
begin
    if( counter < 42500 )
        flp_counter <= flp_counter  + 1'b1 ;
    if( counter == 42600 )
        go <= 1'b1 ;
    if( counter == 42604 )
        go <= 1'b0 ;
    if( flp_counter == 1240 )
    begin
        if( clk_data == 1'b0 )
            Tx <= 1'b1;
        else
            Tx <= flp_data [pointer] ;
    end
    if( flp_counter == 1243 )
    begin
        flp_counter <= 1'b0 ;
        clk_data <= ~ clk_data ;
        if( clk_data == 1'b1 )
            pointer <= pointer + 1'b1 ; 
        Tx <= 1'b0 ;
    end
    counter <= counter + 1'b1 ;
    if( counter == 360000 )
    begin
        counter <= 0 ;
        pointer <= 0 ;
        flp_counter <=0 ;
    end
end

initial
begin
    clk_data    = 1'b0 ;
    flp_counter = 0 ;
    pointer     = 0 ;
    counter     = 0 ;
    Tx          = 1'b0 ;
end

endmodule
