module up_counter_4bit_tb ();
wire [3:0] count;
reg clk,rst;

up_counter_4bit c1 (clk,rst,count);

initial begin
clk=1'b0;
forever 
#5 clk= ~clk;
end

initial begin

@(negedge clk)
rst=1'b1;
@(posedge clk)
rst=1'b0;

#200 $finish;


end

endmodule