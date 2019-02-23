`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 23:59:16
// Design Name: 
// Module Name: multiCPU
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


module multiCPU(clk,Reset,keyin,SW,a_to_g,pos);
    input clk,keyin,Reset;
    input [1:0] SW;
    output [6:0] a_to_g;
    output [3:0] pos;
    wire keyout;
    wire [31:0] curPC,NextPC,ReadData1,ReadData2,result,DB,states;
    wire [4:0] rs,rt;
    CPU_top P1 (.clk(clk),.keyin(keyin),.Reset(Reset),.keyout(keyout),.curPC(curPC),.NextPC(NextPC),.rs(rs),.ReadData1(ReadData1),.rt(rt),.ReadData2(ReadData2),.result(result),.DB(DB),.states(states));//DB
    
    LED_top P2(.clk(clk),.SW(SW),.curPC(curPC),.NextPC(NextPC),.rs(rs),.ReadData1(ReadData1),.rt(rt),.ReadData2(ReadData2),.result(result),.DB(DB),.a_to_g(a_to_g),.pos(pos));
endmodule
