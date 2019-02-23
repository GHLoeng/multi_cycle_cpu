`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 20:16:37
// Design Name: 
// Module Name: DR
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


module DR(clk,in,out);
    input clk;
    input [31:0] in;
    output reg [31:0] out;
    always@ (posedge clk) begin
        out<=in;
    end
endmodule
