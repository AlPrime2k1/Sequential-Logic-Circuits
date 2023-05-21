module pipo_4bit (
					input clk,rst,
					input [3:0] in,
					output reg [3:0] y);
reg [3:0] temp;
					
always@(posedge clk)
begin

	if (rst)
		y<=4'd0;
	else
		y<=in;
end
endmodule