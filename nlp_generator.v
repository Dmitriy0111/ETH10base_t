module nlp #( parameter
	clk_freq=50000000
)(
	input 			clk,
	output	reg		 	go,
	output	reg			Tx
);

reg [31:0]  counter;
//reg			Tx;

always @(posedge clk) begin
	counter<=counter+1'b1;
		if ( counter == 160000 )
			Tx<=1'b1;
		if ( counter == 160000 + 1)
		begin
			Tx<=1'b0;
		end	//counter<=32'h00000;
		if (counter == 160000+5+5+30000)
		begin
			go<=1'b1;
		end
		if (counter == 160000+5+5+5+30000)
		begin
			counter<=32'h00000;
			go<=1'b0;
		end
end

initial
begin
	counter=32'b0;
	Tx= 1'b0;
	go = 1'b0;
end

endmodule
