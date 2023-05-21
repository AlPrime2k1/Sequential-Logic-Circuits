module timeshared_clockedge_alt_approach(
    input clk,
    input data1,
    input data2,
    output reg [3:0] count,
    input rst,
    output reg out
    );
/*
This design is supposed to transfer different single bit values on alternative clock edges.
Here data2 is transferred to output OUT on every odd posedge 
while data1 is transferred on every even posedge.
*/   
initial count =0;
 
always@(posedge clk)
begin
    
    count=count+1;
    
    if(count%2==0)
        out<=data1;
    else if(count%2!=0)
        out<=data2;
end    
endmodule