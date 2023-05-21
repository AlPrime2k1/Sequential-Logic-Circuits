module DFF (
	input	clk,rst,d,
	output reg q);

always@(posedge clk)
begin 

	if (rst)
		q = 0;
	else 
		q = d;

end
endmodule