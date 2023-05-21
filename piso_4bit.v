module piso_4bit (
					input clk,load,
					input [3:0] in,
					output reg y);
reg [3:0] temp;
					
always@(posedge clk)
begin

	if (load)
		temp<=in;
	else
	begin
		
		y<=temp[3];
		temp<=temp<<1;
	end

end
endmodule