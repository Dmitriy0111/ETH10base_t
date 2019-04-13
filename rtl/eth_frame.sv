module eth_frame
(
    input   logic   [0 : 0]     transmit,
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     resetn,
    output  logic   [0 : 0]     eth_data_s,
    output  logic   [0 : 0]     Tx_w
);

    localparam eth_frame_length = 'd128;
    localparam aw               = $clog2(eth_frame_length);         // address width
    localparam addr_max         = {$clog2(eth_frame_length){1'b1}};
    localparam addr_zero        = {$clog2(eth_frame_length){1'b0}};
    
    localparam WAIS_s      = 2'b00,
               BROADCAST_s = 2'b01,
               TP_IDLE_s   = 2'b10;

    logic   [7    : 0]  eth_data    [eth_frame_length-1 : 0];
    logic   [7    : 0]  eth_data_reg;
    logic   [aw-1 : 0]  addr;
    logic   [1    : 0]  state;
    logic   [2    : 0]  count;
    logic   [0    : 0]  manch;
    logic   [0    : 0]  Tx;
    logic   [0    : 0]  Tx_idle;

    assign Tx_w = Tx | Tx_idle;
    assign eth_data_s = ( ~ ( manch ^ eth_data_reg[count] ) ) | Tx_idle;

    always @(posedge clk or negedge resetn) 
    begin
        if( ! resetn )
            begin
                state   <= WAIS_s;
                addr    <= addr_zero ;
                Tx_idle <= '0;
                Tx      <= '0;
                manch   <= '0;
                count   <= '0;
                eth_data_reg <= '0;
            end
        else
            case( state )
                WAIS_s:
                begin
                    Tx      <= 1'b0;
                    manch   <= 1'b0;
    					 Tx_idle <= 1'b0;
                    if( transmit == 1'b1 )
                    begin
                        state        <= BROADCAST_s;
                        eth_data_reg <= eth_data[0];
                        Tx           <=1'b1;
                    end
                end
                BROADCAST_s:
                begin
                    count <= count + manch;
                    manch <= ~ manch;
                    if( (count == 3'h7) && ( manch ) )
                    begin
                        addr         <= addr + 1'b1;
                        eth_data_reg <= eth_data[addr + 1'b1];
                    end
                    if( (addr == addr_max) && (count == 3'h7) )
                    begin
                        addr    <= addr_zero;
                        count   <= 3'd0;
                        state   <= TP_IDLE_s;
                        Tx_idle <= 1'b1;
                        Tx      <= 1'b0;
    						  eth_data_reg <= 8'b0;
                    end
                end
                TP_IDLE_s:
                begin
                    count <= count + 1'b1;
                    if( count == 3'h5 )
                    begin
                        Tx_idle <= 1'b0;
                        count   <= 3'd0;
                        state   <= WAIS_s;
                    end
                end
            endcase
    end

    initial
    begin
        $readmemh("../eth_frame.hex",eth_data);
    end

endmodule
