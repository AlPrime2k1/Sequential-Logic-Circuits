`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 03:58:24
// Design Name: JK FLIP FLOP
// Module Name: JKFF

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module JKFF(
    input j,
    input k,
    output reg q,
    input clk
    );
    always@(posedge clk)
    begin
       case({j,k})
       2'b00:q=q;
       2'b01:q=0; 
       2'b10:q=1;
       2'b11:q=~q;
       endcase
    end
endmodule
