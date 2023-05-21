
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

module sync_ram_tb ();

reg clk,rst,we;
reg [`ADDR_WIDTH-1:0] addr;
wire [`DATA_WIDTH-1:0] data;

reg [`DATA_WIDTH-1:0] tempdata;

sync_ram_16X8 dut (clk,rst,we,addr,data);

assign data = (we)? tempdata:8'hzz;

task reset();													//reset task
begin
	@(negedge clk) rst=1'b1;
	@(negedge clk) rst=1'b0;
end
endtask

task clock();													//clocking task
begin
	clk=1'b1;
	forever #10 clk=~clk;
end
endtask

task write(
			input [`DATA_WIDTH-1:0] wdata,
			input [`ADDR_WIDTH-1:0] waddr);							//write task
begin

@(negedge clk)
we=1'b1;
addr= waddr;
tempdata=wdata;
end
endtask

task read(input [`ADDR_WIDTH-1:0] raddr );						//read task
begin
	@(negedge clk)begin 
	we=1'b0;
	addr=raddr;
	end
end
endtask

initial begin
clock();
end

initial begin
reset(); 

repeat(4) @(negedge clk) write({$random},{$random}); 		//random read write op


repeat(2) @(negedge clk) read({$random}); 					


repeat(4) @(negedge clk) write({$random},{$random}); 			

repeat(2) @(negedge clk) read({$random});

reset();
repeat(4) @(negedge clk) write({$random},{$random}); 

#200 $finish;
end

endmodule