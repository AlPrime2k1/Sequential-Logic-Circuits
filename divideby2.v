`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2023 14:40:59
// Design Name: 
// Module Name: divideby2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: This circuit is used to give different outputs at alternate active edge of clock.
// Here on even edges data1 is given to output while on odd edges data2 is given to output.
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
 if (!reset) begin
 clk_out <= 0;
 end else begin
 clk_out <= ~clk_out;
 end
 end
 
 always@(posedge clk_out)
 out<=data1;
 
 always@(negedge clk_out)
 out<=data2;
 

endmodule
    

