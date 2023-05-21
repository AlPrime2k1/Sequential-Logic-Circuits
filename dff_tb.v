module dff_tb ();
wire q;
reg clk,rst,d;

DFF d1(clk,rst,d,q);
initial 
begin
	clk=0;
	forever 
	#10 clk=~clk;
end

initial 
begin
	d=1; #30
	rst=1; #5
	rst=~rst; #5
	d=0; #10;
	$finish;
end


endmodule