module loadable_counter_5bit_tb ();
wire [4:0] count;
reg clk,rst,load;
reg [4:0] data_in;

loadable_counter_5bit c1(clk,rst,load,data_in,count);

initial begin				//for clock 
clk=1'b0;
forever 
#5 clk= ~clk;
end

initial begin				//for reset
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end

initial						//for signal
begin
#25 
@(negedge clk) begin load = 1'b1;	data_in= 5'b11011; end		//load signal and data value active

#30 @(negedge clk)
load =1'b0;

#50 @(negedge clk) begin
load=1'b1;
data_in=5'b11111;
end

#10 load=1'b0;

#100 $finish;


end

endmodule