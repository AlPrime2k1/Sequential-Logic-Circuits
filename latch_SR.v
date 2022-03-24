`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 02:52:00
// Design Name: SR LATCH
// Module Name: latch_SR
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module latch_SR(
    input s,
    input r,
    output q,
    output qbar
    );
    nor (q,qbar,s);
    nor (qbar,q,s);
    
endmodule
