`define ADDR_WIDTH 9
`define DEPTH 512
`define DATA_WIDTH 8 

module sync_ram_512X8_tb ();
wire [`DATA_WIDTH-1:0] rd_data;
reg clk,rst,wr_enb,rd_enb;
reg [`ADDR_WIDTH-1:0] wr_addr;
reg [`DATA_WIDTH-1:0] wr_data;
reg [`ADDR_WIDTH-1:0] rd_addr;

sync_ram_512X8 dut(clk,rst,wr_enb,wr_addr,wr_data,rd_enb,rd_addr,rd_data,error_flag);


task reset();													//reset task
begin
	@(negedge clk) rst=1'b0;
	@(negedge clk) rst=1'b1;
end
endtask

task reset_check();
begin
write({$random},9'd55);
wr_enb=0;                                                   // reset check task
reset();
read(9'd55);

@(negedge clk);
if (rd_data==0)
    $display("Reset check passed");
else
    $display("reset is not working");
end
endtask

task write(
			input [`DATA_WIDTH-1:0] wri_data,
			input [`ADDR_WIDTH-1:0] wri_addr);							//write task
begin
@(negedge clk)
wr_enb=1'b1;
wr_addr= wri_addr;
wr_data=wri_data;
end
endtask

task read (input[`ADDR_WIDTH-1:0] r_addr);							//read task
				
begin
    @(negedge clk)
	rd_enb=1'b1;
	rd_addr=r_addr;
end		
endtask
///////////// clock init/////////////
initial begin
clk=1'b0;
forever #5 
clk=~clk;
end

//////////////stimulus///////////////
initial begin
reset();

repeat(5) write({$random},{$random}%15); 		//write op
#10 wr_enb=0;

repeat(5) read({$random}%15);						//read op
#10 rd_enb=0;

reset_check();                                  // reset check 

repeat(4) begin
write({$random},{$random}%15);                  // alt write read op
#10 wr_enb=0;
read({$random}%15);
#10 rd_enb=0;
end

fork 
begin
	repeat (2)write({$random},{$random}%15); 
end
                                                    //simultaneous op 
begin
    repeat(2) read({$random}%15);
end
join
wr_enb=0;
rd_enb=0;



#20 $finish;
end

endmodule