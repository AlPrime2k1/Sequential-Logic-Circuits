module random_range_test (
				input clk,
				output reg [6:0] a);
				
always@(posedge clk)
begin

	a<= ({$random}%32)+34;				//generating positive values from 0 to 31 and then adding 34 to get range from 34 to 65
	if(a<=33 || a>65)
			$display("FALSE");		     
end
endmodule
				
				
				
				
				