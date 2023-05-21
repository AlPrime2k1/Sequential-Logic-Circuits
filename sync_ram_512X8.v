`define ADDR_WIDTH 9
`define DEPTH 512
`define DATA_WIDTH 8 

module sync_ram_512X8(
            clk,
            rst_n,
            wr_enb,
            wr_addr,
            wr_data,
            rd_enb,
            rd_addr,
            rd_data,
            error_flag);
            
  input clk,rst_n;
  
  output reg error_flag;
  
 //write signals
  input                   wr_enb;
  input [`ADDR_WIDTH-1:0] wr_addr;
  input [`DATA_WIDTH-1:0] wr_data;

 //read signals
  input                        rd_enb;
  input      [`ADDR_WIDTH-1:0] rd_addr;
  output reg [`DATA_WIDTH-1:0] rd_data;


 //internal memory
 reg [`DATA_WIDTH-1:0] ram [0:`DEPTH-1];

 reg [`ADDR_WIDTH:0] i;
 
 //implementation
 always@(posedge clk)
  if (!rst_n) begin
     rd_data <= `DATA_WIDTH'd0;
	 //memory initialisation
     for (i=0;i<`DEPTH;i=i+1) 
         ram[i] <= `DATA_WIDTH'd0;
  end
  else 
  begin
     if(wr_enb && rd_enb)
     begin
        //$display("Simultaneous op not supported ");
        error_flag<=1;
     end
     
     else
     begin
    //write logic
     if (wr_enb)
        ram[wr_addr] <= wr_data;
    //read logic
     if (rd_enb)
        rd_data <= ram[rd_addr];
     end
  end
  
  always@(posedge clk)
  begin
  if(wr_enb && rd_enb)        
        error_flag<=1;
  else
        error_flag<=0;
  end

endmodule

