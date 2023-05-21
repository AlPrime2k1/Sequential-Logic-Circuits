
`define width 8
`define depth 8


module async_fifo_tb();
    
reg wclk,rclk,rst,wr_en,rd_en;
reg [`width-1:0] wr_data;
wire [`width-1:0] rd_data;
wire full,empty,almost_full,almost_empty,half;

async_fifo dut(wclk,rclk,rst,wr_en,rd_en,wr_data,rd_data,full,empty,almost_full,almost_empty,half);

/////////// reset task //////////////
task reset();
begin
@(negedge wclk,negedge rclk);
rst=1'b1;
#25
@(negedge wclk,negedge rclk);
rst=1'b0;
end
endtask

//////////// write task //////////////

task write(input [`width-1:0] data);
begin
@(negedge wclk)
wr_en=1'b1;
wr_data=data;
@(negedge wclk)
wr_en=1'b0;
end
endtask

//////////// read task /////////

task read();
begin
@(negedge rclk)
rd_en=1'b1;
@(negedge rclk)
rd_en=1'b0;
end
endtask

//////////// reset check ///////
task reset_check();
begin : rst_chk
reg [7:0] exp_rd_data;
write({$random});
reset();
exp_rd_data<=0;
@(negedge rclk)
if(rd_data== exp_rd_data)
    $display("Reset check passed");
else
    $display("Reset check failed"); 

end
endtask


//////////// full check ////
task full_check();
begin
repeat(8) write({$random});
@(negedge wclk)
if (full)
    $display("Full check passed");
else
    $display("Error in full flag");
wr_en=0;   
end
endtask

//////////// underflow check ////
task empty_check();
begin
reset();
read();
@(negedge rclk)
if (empty)
    $display("Empty check passed");
else
    $display("Error in empty flag");
rd_en=0;   
end
endtask

//////////// alt write read check /////
task circular_write_read();
begin
repeat(2) write({$random});             // alternate write and read
@(negedge wclk) wr_en=0;
repeat(2) read();
@(negedge rclk) rd_en=0;

repeat(8) write({$random});             // circular fifo write and read
@(negedge wclk) wr_en=0;
repeat(8) read();
@(negedge rclk) rd_en=0;

@(negedge rclk)
if(wr_data==rd_data)
    $display("Circular write read check passed");
else
    $display("Circular write read check failed");
end
endtask


///////////// almost full check /////
task almost_full_check();
begin
reset();
repeat(6)write({$random});
@(negedge wclk)
if(almost_full)
    $display("Almost full check passed");
else
    $display("Almost full check failed");
end
endtask

///////////// almost empty check /////
task almost_empty_check();
begin
reset();
write({$random});
@(negedge rclk)
if(almost_empty)
    $display("Almost empty check passed");
else
    $display("Almost empty check failed");
end
endtask

/////////// clock /////////////////

initial begin
wclk=1'b1;
rclk=1'b1;
fork
forever #5 wclk=~wclk;
forever #2 rclk=~rclk;
join
end

///////////// stimulus ////////////

initial begin

reset();
full_check(); 
almost_full_check();

reset_check();
circular_write_read();

almost_empty_check();
empty_check();                              


@(negedge wclk) $finish;
end
endmodule

