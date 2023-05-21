
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 
module sync_ram_16X8 (clk,
            rst,
            we,
            addr,
            data);

//port direction
  input clk, rst,we;
  input [`ADDR_WIDTH-1:0] addr;
  inout [`DATA_WIDTH-1:0] data;
  //output reg[`DATA_WIDTH-1:0] data_out;

 reg [`DATA_WIDTH-1:0] ram [0:`DEPTH-1];
 //reg [`DATA_WIDTH-1:0] tempdata;
 reg [`ADDR_WIDTH:0] i;

 //implementation
 always@(posedge clk)
 begin
  if (rst) 
  begin
	 //memory initialisation
     for (i=0;i<`DEPTH;i=i+1) 
         ram[i] <= `DATA_WIDTH'd0;
  end
  else
  begin
	if (we)						//write op
		ram[addr]<=data;
  end
 end
 
 assign data= (!we)?ram[addr]:8'hzz;				//read op
endmodule