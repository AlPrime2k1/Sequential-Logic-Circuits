
`define width 8
`define depth 8

module fifo_tb();

reg clk,rst,wr_en,rd_en;
reg [`width-1:0] wr_data;
wire [`width-1:0] rd_data;
wire full,empty,almost_full,almost_empty,half;

fifo dut(clk,rst,wr_en,rd_en,wr_data,rd_data,full,empty,almost_full,almost_empty,half);

//////////// reference model ////////
reg [`width-1:0] ram [0:`depth-1];
reg exp_full,exp_empty,exp_half,exp_al_half,exp_al_full,exp_al_empty;
reg [`width-1:0] exp_rd_data;
reg [3:0] r_pt=0;
reg [3:0] w_pt=0;
integer j;

//////////// initialise counter for self check ////
integer data_out_count=0;
integer empty_count=1;
integer full_count=1;
integer almost_full_count=1;
integer almost_empty_count=1;
integer half_count=1;
integer count=1;

/////////// reset task //////////////
task reset();
begin
@(negedge clk);
rst=1'b1;
@(negedge clk);
rst=1'b0;
end
endtask

//////////// write task //////////////

task write(input [`width-1:0] data);
begin
@(negedge clk)
wr_en=1'b1;
wr_data=data;
end
endtask

//////////// read task /////////

task read();
begin
@(negedge clk)
rd_en=1'b1;

end
endtask

//////////// reset check ///////
task reset_check();
begin : rst_chk
reg [7:0] exp_rd_data;
write({$random});
reset();
exp_rd_data<=0;
@(negedge clk)
if(rd_data== exp_rd_data)
    $display("Reset check passed");
else
    $display("Reset check failed"); 

end
endtask

///////////////////// refernce model logic //////////
initial 
begin
forever@(posedge clk)
begin
    if(rst)
    begin
        exp_rd_data<=0;
        r_pt<=0;
        w_pt<=0;
        for (j=0;j<`width;j=j+1)
        begin
            ram[j]<=0;
        end
    end
    
    else
    begin
        if(wr_en && !exp_full)
        begin
            ram[w_pt[2:0]]<=wr_data;
            w_pt<=w_pt+1;
        end
    
        if(rd_en && !exp_empty)
        begin
            exp_rd_data<=ram[r_pt[2:0]];
            ram[r_pt]<='bz;
            r_pt<=r_pt+1;
        end 
    end
end
end

always@(posedge clk)
begin

fork 
begin
if  (rd_data!==0 && rd_data!==8'dx)
begin
    if(exp_rd_data==rd_data)
        //data_out_count<=data_out_count+1;         // expected data out value 
        $display("DATA OUT is good");
    else
        $display("DATA OUT IS FAULTY");
end

//$display("DATA OUT count=%d time=%t",data_out_count,$time);
end

//$display("DATA OUT CORRECT COUNT=%d",data_out_count);

begin
if(exp_empty===empty)
    //empty_count<=empty_count+1;                   // expected empty flag 
    $display("EMPTY is good");
else
    $display("EMPTY FAILED");
end

begin
if(exp_full===full)
    //full_count<=full_count+1;                     // expected full flag 
    $display("Full is good");
else
    $display("FULL FAILED");
end

begin
if(exp_al_full===almost_full)
    //almost_full_count<=almost_full_count+1;       // expected almost full flag 
    $display("ALMOST FULL is good");
else
    $display("ALMOST FULL FAILED");
end

begin
if(exp_al_empty===almost_empty)
    //almost_empty_count<=almost_empty_count+1;       // expected almost empty flag 
    $display("ALMOST EMPTY is good");
else
    $display("ALMOST EMPTY FAILED");
end

begin
if(exp_half===half)
    //half_count<=half_count+1;                   // expected half flag 
    $display("HALF is good");
else
    $display("HALF FAILED");
end

join

end
//////////////////////////// flag logic /////////////
always@(posedge clk)
begin
assign exp_full=(w_pt-r_pt==`width )?1:0; 
assign exp_empty=(w_pt==r_pt)?1:0;
assign exp_al_full=(w_pt-r_pt>=`depth-`gap && !full)?1:0;
assign exp_al_empty=(w_pt-r_pt<=`gap && !empty)?1:0;
assign exp_half=(w_pt-r_pt==`depth/2)?1:0;
end

/////////// clock /////////////////

initial begin
clk=1'b1;
forever #5 clk=~clk;
end

///////////// stimulus ////////////

initial begin

reset();
repeat(8)
write({$random});

repeat(8) 
read();

reset();
fork
begin repeat(4) write({$random}); end
begin repeat(4) read(); end
join
reset_check();
@(negedge clk) $finish;
end
endmodule
