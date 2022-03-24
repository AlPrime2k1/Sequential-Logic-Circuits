`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 20:15:54
// Design Name: 4 BIT REGISTER USING 2 TO 1 MUX AND DFF
// Module Name: reg_4bit_str

// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_4bit_str(
    input [3:0] d,
    input clk,
    input load,
    output wire [3:0] q
    );
    wire [3:0] w1; 
    mux2x1dataflow m0 (load,q[o],d[0],w1[0]);
    mux2x1dataflow m1 (load,q[1],d[1],w1[1]);
    mux2x1dataflow m2 (load,q[2],d[2],w1[2]);
    mux2x1dataflow m3 (load,q[3],d[3],w1[3]);
    
    DFF d0 (w1[0],clk,q[0]);
    DFF d1 (w1[1],clk,q[1]);
    DFF d2 (w1[2],clk,q[2]);
    DFF d3 (w1[3],clk,q[3]);
    
endmodule
