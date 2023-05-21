
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 


module async_ram_16X8(cs,
           we,
		   addr,
		   data,rst);
      
    input we,cs,rst;
    input [`ADDR_WIDTH-1:0] addr;
    inout [`DATA_WIDTH-1:0] data;

    reg [`DATA_WIDTH-1:0] ram [0:`DEPTH];
	 reg [`ADDR_WIDTH-1:0]tempdata;
	 reg [`ADDR_WIDTH-1:0]i;
	 
    always@(cs,we,rst,addr,data)
	 if(rst)
	 begin
		tempdata<=`DATA_WIDTH'd0;
		for (i=0;i<`DEPTH;i=i+1)
			ram[i]<=`DATA_WIDTH'd0;
	 end
	 
	 else
	 begin
		if (cs && we)
          ram[addr]=data;
	 end
	 
      
    assign data = (cs && !we) ? ram[addr] : 8'hzz;
	
endmodule 
