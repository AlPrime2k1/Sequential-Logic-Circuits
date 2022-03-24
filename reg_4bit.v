`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST 
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 20:10:54
// Design Name: 4 BIT REGISTER
// Module Name: reg_4bit

// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_4bit(
    input [3:0] d,
    input clk,
    output reg [3:0] q
    );
    always@(posedge clk)
    begin
        q=d;
    end
endmodule
