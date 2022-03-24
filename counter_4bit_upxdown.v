`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST 
// Engineer: KIRTI KUMAR
// 
// Create Date: 21.02.2022 20:19:12
// Design Name: 4 BIT UP/DOWN COUNTER
// Module Name: counter_4bit_upxdown

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// DIR=0 FOR UP , DIR=1 FOR DOWN
//////////////////////////////////////////////////////////////////////////////////


module counter_4bit_upxdown( clk,reset,dir,count);
   input clk,reset,dir;
   output reg [3:0] count=0;
    
    always@(posedge (clk) or posedge(reset))
    begin
        if (reset==1)
            count<=0;
        else
            if (dir==0)
                if (count==15)
                    count<=0;
                else
                    count<=count+1;
            else
                if (count==0)
                    count<=15;
                else
                    count<=count-1;                                 
    end
endmodule
