`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 21.02.2022 19:59:52
// Design Name: 4 BIT ASYNCHRONOUS COUNTER
// Module Name: counter_4bit_asyn

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter_4bit_asyn(
    input wire clk,
    output reg [3:0] count
    );
    initial count= 4'b0;
    
    always@(negedge clk)
    count[0]<=~count[0];
    
    
    always@(negedge count[0])
    count[1]<=~count[1];
    
    
    always@(negedge count[1])
    count[2]<=~count[2];
    
    
    always@(negedge count[2])
    count[3]<=~count[3];
    
endmodule
