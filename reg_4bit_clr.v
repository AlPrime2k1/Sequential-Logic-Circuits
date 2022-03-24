`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 20:31:42
// Design Name: 4 BIT REGISTER WITH CLEAR
// Module Name: reg_4bit_clr

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_4bit_clr(
    input [3:0] d,
    input clk,
    input load,
    input clear,
    output reg [3:0] q
    );
    always@(posedge clk)
    begin
        if (clear == 1)
            assign q= 4'b0000;
         else
            begin
                if (load == 0)
                    assign q = q;
                else
                    assign q=d;    
            end   
    end
    
endmodule
