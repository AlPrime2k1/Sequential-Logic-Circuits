module timer_sec (
			input clk,rst,load,
			input [15:0] time_in,
			output reg time_out);

reg [15:0] count=16'd0;		//temp variable for counting
reg [15:0] sec=16'd0;		//for measuring seconds on 5hz clock
			
always@(posedge clk)
begin
	count=count+1;
		
	
	if (load)					//loading time value in seconds
		sec<=time_in;
	else 							//decrementing the seconds counter
	begin
		
		if (count%5==0 && sec>0)	//5hz clock to second
		begin
			sec=sec-1;
			if (sec==0)					//time up for the timer and output flag is raised and sec value is reset
			begin
				time_out=1;
				sec=16'd0;
			end
		end
		
		if (rst)							//timeout flag is reset when rst signal is applied
		begin
			time_out<=1'b0;
			count<=16'd0;
		end	
	end

end
endmodule