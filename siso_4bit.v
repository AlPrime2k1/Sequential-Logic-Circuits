module siso_4bit (
					input clk,rst,in,
					output reg y);
reg [3:0] temp;
					
always@(posedge clk)
begin

	if (rst)
		temp<=4'd0;
	else
		temp<=temp<<1;
		
	temp[0]<=in;
	y=temp[3];
	

end
endmodule