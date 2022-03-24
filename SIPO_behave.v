`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 21.02.2022 01:32:55
// Design Name: SERIAL IN PARALLEL OUT SHIFT REGISTER
// Module Name: SIPO_behave

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SIPO_behave(
    input d,
    input load,
    input clk,
    output [3:0] q
    );
    reg [3:0] temp;
    always@(posedge clk)
    begin
        if (load == 0)
            temp=temp;
        else
            temp={temp[2:0],d};    
    end
    assign q=temp;
endmodule
