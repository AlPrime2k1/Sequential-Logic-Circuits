`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 21.02.2022 20:39:53
// Design Name: 4 BIT JOHNSON COUNTER
// Module Name: johnsoncounter_4bit

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module johnsoncounter_4bit(
    input clk,
    input reset,
    output reg [3:0] count
    );
    reg [3:0] temp;
    always@(posedge clk or reset)
    begin
        if (reset==1)
            temp=4'b0000;
        else
        begin
            temp ={~temp[0],temp[3:1]};
        end    
        assign count= temp;
    
    end
    
endmodule
