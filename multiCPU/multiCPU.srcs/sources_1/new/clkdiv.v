`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 23:16:27
// Design Name: 
// Module Name: clkdiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkdiv(clk,clk190,clk3);
    input wire clk;
    output wire clk190;
    output wire clk3;
   
    reg [26:0] c = 0;
    always@ (posedge clk )
    begin
    c<=c+1;
    end
    assign clk190 =c[18];
    assign clk3 =c[25];
endmodule
