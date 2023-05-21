module async_ram_tb ();

      
parameter ADDR_WIDTH = 4,
          DATA_WIDTH = 8,
          DEPTH = 16;	
			 
reg cs,we,rst;
reg [ADDR_WIDTH-1:0] addr;
wire [DATA_WIDTH-1:0] data;

reg [DATA_WIDTH-1:0] tempdata;

async_ram_16X8 dut(cs,we,addr,data);
 
assign data =(we)? tempdata:8'hzz;

task delay(input integer i);								//delay task
begin
#i;
end
endtask

task reset();													//reset task
begin
				 rst=1'b1;
	delay(20); rst=1'b0;
end
endtask
/*
task clock();													//clocking task
begin
	clk=1'b1;
	forever delay(10); clk=~clk;
end
endtask */


task write(
			input [DATA_WIDTH-1:0] wdata,
			input [ADDR_WIDTH-1:0] waddr);							//write task
begin

delay(20);
we=1'b1;
delay(5);
addr= waddr;
tempdata=wdata;
end
endtask

task read(input [ADDR_WIDTH-1:0] raddr );						//read task
begin
	delay(20); 
	we=1'b0;
	addr=raddr;
	
end
endtask
/*
initial begin
clock();
end
*/
initial begin
cs=1'b1;

reset(); 
delay(10);

we=1'b1;
delay(10);
repeat(8) begin delay(10); write({$random},{$random}); end
delay(20);

we=0;
delay(10);
repeat(6) read({$random});

delay(20);
we=1'b1;
write({$random},{$random});
delay(10); 
reset();
delay(10);
$finish;
end

endmodule