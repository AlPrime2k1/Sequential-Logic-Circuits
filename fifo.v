`define gap 2
`define width 8
`define depth 8

module fifo(
            input clk,rst,wr_en,rd_en,
            input [`width-1:0] wr_data,
            output reg [`width-1:0] rd_data,
            output reg full,empty,almost_full,almost_empty,half
           );
            
reg [`width-1:0] mem [0:`depth-1];
reg [3:0] rd_pt=0;
reg [3:0] wr_pt=0;
integer i;


always@(posedge clk)
begin
if (rst)
begin
    rd_data<=0;
    rd_pt<=0;
    wr_pt<=0;
    for (i=0;i<`width;i=i+1)
    begin
        mem[i]<=0;
    end
end

else
begin
//////////////////// write op /////
    if(wr_en && !full)
    begin
        mem[wr_pt[2:0]]<=wr_data;
        wr_pt<=wr_pt+1;
    end
             
 //////////////////// read op///   
    if(rd_en && !empty)
    begin
        rd_data<=mem[rd_pt[2:0]];
        mem[rd_pt]<='bz;
        rd_pt<=rd_pt+1;
    end 
         
end
assign full=(wr_pt-rd_pt==`width )?1:0; 
assign empty=(wr_pt==rd_pt)?1:0;
assign almost_full=(wr_pt-rd_pt>=`depth-`gap && !full)?1:0;
assign almost_empty=(wr_pt-rd_pt<=`gap && !empty)?1:0;
assign half=(wr_pt-rd_pt==`depth/2)?1:0;
end
endmodule
