module digi_clock_5hz (
				input clk,rst,
				output reg [7:0] sec,min,hour);
				
reg [15:0] count=16'd0;		
reg [7:0] tempsec=8'd0;
reg [7:0] tempmin=8'd0;
reg [7:0] temphour=8'd0;	
always@(posedge clk)
begin

	if (rst)
	begin
		tempsec<=7'd0;
		tempmin<=7'd0;
		temphour<=7'd0;
		count<=7'd0;
	end
	
	else
	begin
		count= count+1;
		
		if (count%5==0)			//5hz clock 
		begin
			tempsec=tempsec+1;
			//count=0;
		end
		
		if (count%30==0)
		begin
			tempmin=tempmin+1;
			//tempsec=0;
		end
		
		if (count%180==0)
		begin
			temphour=temphour+1;
			//tempmin=0;
		end
		/**/
	end

end


always@(posedge clk)
begin

		sec=tempsec;
		min=tempmin;
		hour=temphour;

end 
endmodule