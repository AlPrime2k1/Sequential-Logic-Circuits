`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 12.02.2023 14:40:59
// Design Name: DIVIDE BY 2
// Module Name: divideby2 
// Description: This design uses frequency division circuit to divide the clock signal such that different operations can be performed on aternative clock edges.
//              Expected behaviour is that on every odd posedge, data1 is transferred to output and on every even posedge, data2 is transferred to output.
// Revision 0.01 - File Created
// Additional Comments: This circuit is used to give different outputs at alternate active edge of clock.
//////////////////////////////////////////////////////////////////////////////////


module divideby2(
 input clk,
 input data1,data2,
 input reset,
 output reg clk_out,
 output reg out
    );

wire clk;

initial begin
 clk_out = 0;
 end
 always @(posedge clk or negedge reset) begin
 if (!reset) 
 begin
  clk_out <= 0;
 end 
 else 
 begin
  clk_out <= ~clk_out;
 end
 end
 
 always@(posedge clk_out)
 out<=data1;
 
 always@(negedge clk_out)
 out<=data2;
 

endmodule
    

