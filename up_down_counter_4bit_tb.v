module up_down_counter_4bit_tb ();
wire [3:0] count;
reg clk,rst,direction;

up_down_counter_4bit c1 (clk,rst,direction,count);

initial begin
clk=1'b0;
forever 
#5 clk= ~clk;
end

initial begin

@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end

initial
begin
#10 direction = 1'b0;

#20 @(negedge clk)
direction =1'b1;

#20 @(negedge clk)
direction =1'b0;

#200 $finish;


end

endmodule