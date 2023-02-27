`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 25.02.2023 14:39:52
// Design Name: TIMESHARED_CLOCK
// Module Name: timeshared_clockedge_alt_approach
// Description: This design uses continuosly incremented count variable to divide the clock posedge into odd and even such that different operations can be performed on aternative clock edges.
//              Expected behaviour is that on every odd posedge, data1 is transferred to output and on every even posedge, data2 is transferred to output.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 12.02.2023 14:40:59
// Design Name: DIVIDE BY 2
// Module Name: divideby2 
// Description: This design uses frequency division circuit to divide the clock signal such that different operations can be performed on aternative clock edges.
//              Expected behaviour is that on every odd posedge, data2 is transferred to output and on every even posedge, data1 is transferred to output.
// Revision 0.01 - File Created
// Additional Comments: This circuit is used to give different outputs at alternate active edge of clock.
//////////////////////////////////////////////////////////////////////////////////


module timeshared_clockedge_alt_approach(
    input clk,
    input data1,
    input data2,
    output reg [3:0] count,
    input rst,
    output reg out
    );
    
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
