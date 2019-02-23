`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 10:21:35
// Design Name: 
// Module Name: SingleCPU
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


module SingleCPU(clk,keyin,Reset,SW,a_to_g,pos);
    input clk;
    input keyin;
    input Reset;
    input [1:0] SW;
    output [6:0] a_to_g;
    output [3:0] pos;
    
    wire [31:0] curPC;
    wire [31:0] NextPC;
    wire [4:0] rs;
    wire [31:0] ReadData1;
    wire [4:0] rt;
    wire [31:0] ReadData2;
    wire [31:0] result;
    wire [31:0] DB;
    CPU_top A1 (.clk(clk),.keyin(keyin),.Reset(Reset),
               //以下提供显示用
               .curPC(curPC),.NextPC(NextPC),.rs(rs),.ReadData1(ReadData1),
               .rt(rt),.ReadData2(ReadData2),.result(result),.DB(DB)
                );
    LED_top A2 (.clk(clk),.SW(SW),.curPC(curPC),.NextPC(NextPC),.rs(rs),
                .ReadData1(ReadData1),.rt(rt),.ReadData2(ReadData2),
                .result(result),.DB(DB),.a_to_g(a_to_g),.pos(pos)
                );
endmodule
