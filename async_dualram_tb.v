`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

module async_dualram_tb ();
wire [`DATA_WIDTH-1:0] rd_data;
reg cs,rst,wr_enb,rd_enb;
reg [`ADDR_WIDTH-1:0] wr_addr;
reg [`DATA_WIDTH-1:0] wr_data;
reg [`ADDR_WIDTH-1:0] rd_addr;

async_dualram_16X8 dut(cs,rst,wr_enb,wr_addr,wr_data,rd_enb,rd_addr,rd_data);

task reset();													//reset task
begin
	//@(negedge clk)
		 rst=1'b1;
	//@(negedge clk) 
	#10 rst=1'b0;
end
endtask


task delay(input integer i);								//delay
begin
#i ;
end
endtask

task write(input [`DATA_WIDTH-1:0] wri_data,
			  input [`ADDR_WIDTH-1:0] wri_addr);							//write task
begin
//@(negedge clk)
wr_enb=1'b1;
wr_addr= wri_addr;
wr_data=wri_data;
end
endtask

task read (input[`ADDR_WIDTH-1:0] r_addr);								//read task
				
begin
	rd_enb=1'b1;
	rd_addr=r_addr;
end		
endtask

//////////////stimulus///////////////
initial begin
cs=1;
reset();
#10
repeat(5) #20 write({$random},{$random}); 		//write op

#10 wr_enb=0; wr_data=0;

repeat(5) #20 read({$random});						//read op

#10 rd_enb=0;


repeat (6)											//simultaneous read write op
fork 
write({$random},{$random}); 
read({$random});
join
#5 wr_enb=0;
#5 rd_enb=0;

delay(40); $finish;
end

endmodule