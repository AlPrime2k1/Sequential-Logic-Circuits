module random_odd_range_test (
				input clk,
				output reg [6:0] a,temp);
parameter underflow=7'd33, overflow=7'd66;
				
always@(posedge clk)
begin

	temp <= ({$random}%32)+34;		//generating positive values from 0 to 31 and then adding 34
	if(temp <= underflow || temp >= overflow)
			$display("Not within range");
	else if (temp %2 != 0)
			a<= temp;
end
endmodule
				
				
/*				
				
module random_odd_range_test (
				input clk,
				output reg [6:0] a,temp);
				
always@(posedge clk)
begin

	temp <= ({$random}%32)+34;				//generating positive values from 0 to 31 and then adding 34
	if(temp <=33 || temp >65)
			$display("FALSE");
	else if (temp %2 != 0)
			a<= temp;
end
endmodule



*/
	
				
				
				
				