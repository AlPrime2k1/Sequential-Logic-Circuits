`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 21.02.2022 01:10:54
// Design Name: PARALLEL IN PARALLEL OUT BIDERCTIONAL SHIFT REGISTER
// Module Name: PIPO_bidirectional

// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PIPO_bidirectional(
    input [3:0] d,
    input [1:0] ctrl,
    input clear,
    input clk,
    input xl,
    input xr,
    output [3:0] q
    );
    wire [3:0] s;
    mux4x1 m0 (ctrl[1],ctrl[0],q[0],xl,q[1],d[0],s[0]);
    mux4x1 m1 (ctrl[1],ctrl[0],q[1],q[0],q[2],d[1],s[1]);
    mux4x1 m2 (ctrl[1],ctrl[0],q[2],q[1],q[3],d[2],s[2]);
    mux4x1 m3 (ctrl[1],ctrl[0],q[3],q[2],xr,d[3],s[3]);
    
    DFF_clr d0 (s[0],clk,clear,q[0]);
    DFF_clr d1 (s[1],clk,clear,q[1]);
    DFF_clr d2 (s[2],clk,clear,q[2]);
    DFF_clr d3 (s[3],clk,clear,q[3]);
    
endmodule
