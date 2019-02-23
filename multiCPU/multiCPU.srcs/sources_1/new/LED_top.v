`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 14:24:28
// Design Name: 
// Module Name: LED_top
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


module LED_top(clk,SW,curPC,NextPC,rs,ReadData1,rt,ReadData2,result,DB,a_to_g,pos);
    input clk;
    input [1:0] SW;
    input [31:0] curPC;
    input [31:0] NextPC;
    input [4:0] rs;
    input [31:0] ReadData1;
    input [4:0] rt;
    input [31:0] ReadData2;
    input [31:0] result;
    input [31:0] DB;
    output [6:0] a_to_g;
    output [3:0] pos;
    
    wire clk190,clk3;
    wire [15:0] x;
    clkdiv L1 (.clk(clk),.clk190(clk190),.clk3(clk3));
    SW_in L2 (.clk3(clk3),.SW(SW),.curPC(curPC),.NextPC(NextPC),.rs(rs),.ReadData1(ReadData1)
    ,.rt(rt),.ReadData2(ReadData2),.result(result),.DB(DB),.x(x));
    seg7 L3 (.x(x),.clk190(clk190),.a_to_g(a_to_g),.pos(pos));  
endmodule

