`timescale 1ns/1ns

module eth_frame_tb ();

reg      transmit;
reg      clk;
reg      rst_n;
wire     eth_data_s;

eth_frame eth_frame_0
(
    .transmit   ( transmit      ),
    .clk        ( clk           ),
    .rst_n      ( rst_n         ),
    .eth_data_s ( eth_data_s    )
);

always @(*) #1 clk <= ~ clk ;

initial
begin
    clk <= 1'b0 ;
    rst_n <= 1'b0 ;
    transmit <= 1'b0 ;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    rst_n <= 1'b1 ;
    transmit <= 1'b1 ;
    #10
    transmit <= 1'b0 ;
end

endmodule
