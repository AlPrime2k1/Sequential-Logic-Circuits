
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

module dualport_fileop ();
wire [`DATA_WIDTH-1:0] rd_data;
reg clk,rst,wr_enb,rd_enb;
reg [`ADDR_WIDTH-1:0] wr_addr;
reg [`DATA_WIDTH-1:0] wr_data;
reg [`ADDR_WIDTH-1:0] rd_addr;
integer rd,i,j;

sync_dualram_16X8 dut(clk,rst,wr_enb,wr_addr,wr_data,rd_enb,rd_addr,rd_data);

//mem for fileop

 reg [3:0] waddr [0:15];
 reg [3:0] raddr [0:15];
 reg [7:0] wdata [0:15];


task reset();																	//reset task
begin
	@(negedge clk) rst=1'b1;
	@(negedge clk) rst=1'b0;
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

$readmemb("/home/kirti/Desktop/Design/value/readaddr_data.txt",raddr);

 $readmemb("/home/kirti/Desktop/Design/value/writeaddr_data.txt",waddr);

 $readmemh("/home/kirti/Desktop/Design/value/writedata_data.txt",wdata);
 
 rd= $fopen ("/home/kirti/Desktop/Design/value/rd_data.txt");

 
reset();

repeat(8)								//write op
begin
i={$random}%16 ;#5
write(wdata[i],waddr[i]);
end

wr_enb=0;

@(negedge clk)

repeat(8)								//read op
begin
j={$random}%16 ;#5
read(raddr[j]);
end

reset();


#10 repeat(10)								//simultaneous read write op
begin
i={$random}%16 ;
j={$random}%16; #5
write(wdata[i],waddr[i]);
read(raddr[j]);
end

#5 $fclose(rd);
#20 $finish;
end

initial begin
	$fmonitor(rd,"Time=%t\tWrite_en=%d\t Write_addr=%b\t Write_data=%h\t Read_en=%d\tRead_addr=%b\t Read_data=%h",$time,wr_enb,wr_addr,wr_data,rd_enb,rd_addr,rd_data);
end

endmodule