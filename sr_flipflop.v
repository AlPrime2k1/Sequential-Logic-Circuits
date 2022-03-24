`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 20.02.2022 03:21:17
// Design Name: SR FLIP FLOP

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sr_flipflop(s,r,clk,q,qbar);
    input wire s,r,clk;
    output reg q,qbar;
    
   always@(posedge clk)
   begin
    if (s ==1 & r == 0)
    begin
        q<=1;
        qbar<=0;
    end
    else if (s ==0 & r==1)
    begin
          q<=0;
          qbar<=1;
    end       
    else if (s ==0 & r==0)
    begin
          q<=q;
          qbar<=qbar;
    end
   end 
endmodule
