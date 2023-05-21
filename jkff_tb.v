module jkff_tb ();
wire q;
reg clk,rst,j,k;

JKFF_using_DFF jk1(clk,rst,j,k,q);

initial 
begin
	clk=0;
	forever 
	#5 clk=~clk;
end

initial 
begin
	rst=1; #10
	rst=~rst; #5;
end

initial 
begin	
	j=1;k=0; #30
	j=0;k=0; #30
	j=0;k=1; #30
	j=1;k=1; #40
	$finish;
end


endmodule