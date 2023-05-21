module loadable_counter_5bit (
		input clk,rst,load,
		input [4:0] data_in,
		output  reg [4:0]count);			//5 bit loadable up counter 
		
//parameter max_count=4'b1111,
parameter	 min_count=5'b0000;
			 
always@(posedge clk)
begin
	if (rst)
		count<=min_count;
	else
	begin
		if(load)			//load=1 data loading
		begin
			count<=data_in;
		end
		
		else			// normal UP counter 
		begin
			count<=(count<32)?count+1'b1:min_count;
		end
	end
end
endmodule