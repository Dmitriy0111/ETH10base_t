module eth_frame
(
	input 		 transmit,
	input		 clk,
	input		 rst_n,
	output		 eth_data_s,
	input		 enable,
	output reg 	 Tx,
	output reg   Tx_idle
);

localparam eth_frame_length = 'd128;
localparam addr_max 		= {$clog2(eth_frame_length){1'b1}};
localparam addr_zero		= {$clog2(eth_frame_length){1'b0}};

reg	[7:0]	eth_data 	[eth_frame_length-1:0];
reg	[7:0]	eth_data_reg;
reg	[$clog2(eth_frame_length)-1:0]	addr;
reg	[1:0]	state;
reg [2:0]	count;
assign eth_data_s = eth_data_reg[3'h7-count];

localparam 	WAIS_S		= 2'b00 ,
			BROADCAST_S	= 2'b01 ,
			TP_IDLE		= 2'b10;

always @(posedge clk or negedge rst_n) 
begin
	if( ~ rst_n )
		begin
			state <= WAIS_S ;
			addr  <= addr_zero  ;
			Tx_idle <= 1'b0;
			Tx<=1'b0;
		end
	else
		if (enable)
		case( state )
		WAIS_S:
			begin
				Tx<=1'b0;
				if( transmit == 1'b1 )
				begin
					state <= BROADCAST_S ;
					//eth_data_s <= eth_data[0][3'h7];
					eth_data_reg <= eth_data[0];
					Tx<=1'b1;
				end
			end
		BROADCAST_S:
			begin
				count <= count + 1'b1;

				//eth_data_s <= eth_data[addr][3'h7-count] ;
				if( count == 3'h7 )
				begin
					addr <= addr + 1'b1 ;
					eth_data_reg <= eth_data[addr];
				end
				if( addr == addr_max )
				begin
					addr <= addr_zero;
					count <= 3'd0 ;
					state <= TP_IDLE;
					Tx_idle <= 1'b1;
					Tx<=1'b0;
				end
			end
		TP_IDLE:
			begin
				count <= count + 1'b1;
				//eth_data_s <= eth_data[addr][3'h7-count] ;
				if( count == 3'h2 )
				begin
					Tx_idle <= 1'b0;
					count <= 3'd0 ;
					state <= WAIS_S;
				end
			end
		endcase
end

initial
begin
	state = WAIS_S ;
	addr = addr_zero ;
	count = 3'd0 ;
	eth_data_reg = 8'h00;
	Tx = 1'b0;
	Tx_idle = 1'b0;
	//eth_data_s = 1'b0;
	$readmemh("/home/vlasovdv0111/ETH10base_t/eth_frame.hex",eth_data);
end

endmodule
