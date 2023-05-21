module factorial_design(	input clk,
									input [31:0] in,
									output reg [31:0] y);
reg [31:0] temp=32'd0;

initial
begin 
	
	y=32'b1;
end	
					
always@(posedge clk)
begin
	if (temp<in)
		begin
			temp=temp+1;
			y=y*temp;
		end
end	
//temp=in;
endmodule