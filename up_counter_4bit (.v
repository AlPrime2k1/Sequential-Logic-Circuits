module up_counter_4bit (
		input clk,rst,
		output  reg [3:0]count);
		
always@(posedge clk)
begin
	if (rst)
		count<=1'b0;
	else
	begin
		if(count<16)
		begin
			count<=count+1;
		end
		else
		begin
			count<=4'b0;
		end
	end
end
endmodule