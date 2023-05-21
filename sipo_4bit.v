module sipo_4bit (
					input clk,rst,in,
					output reg [3:0] y);
reg [3:0] temp;
					
always@(posedge clk)
begin

	if (rst)
		temp<=4'd0;
	else
		temp<=temp<<1;
		
	temp[0]<=in;
	y=temp;
	

end
endmodule