module up_down_counter_4bit (
		input clk,rst,direction,
		output  reg [3:0]count);
		
parameter max_count=4'b1111,
			 min_count=4'b0000;
			 
always@(posedge clk)
begin
	if (rst)
		count<=1'b0;
	else
	begin
		if(direction)								//direction=1 is UP counter
		begin
			count<=(count<16)?count+1'b1:min_count;
		end
		else if(~direction)						// direction=0 is DOWN counter
		begin
			count <= (count>0)?count-1'b1:max_count;
		end
	end
end
endmodule