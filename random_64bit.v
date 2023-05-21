module random_64bit (
				input clk,
				output reg [63:0] a,
				output reg [31:0] temp1,temp2);
//parameter underflow=7'd33, overflow=7'd66;
				
always@(posedge clk)
begin
	temp1<= $random;
	temp2<= $random;
	a<= {temp1,temp2};
	
end
endmodule