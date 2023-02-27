`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2023 14:39:52
// Design Name: 
// Module Name: timeshared_clockedge_alt_approach
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
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
