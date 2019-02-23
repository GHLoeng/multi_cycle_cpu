`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 23:45:58
// Design Name: 
// Module Name: SW_in
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


module SW_in(clk3,SW,curPC,NextPC,rs,ReadData1,rt,ReadData2,result,DB,x);
    input clk3;
    input [1:0] SW;
    input [31:0] curPC;
    input [31:0] NextPC;
    input [4:0] rs;
    input [31:0] ReadData1;
    input [4:0] rt;
    input [31:0] ReadData2;
    input [31:0] result;
    input [31:0] DB;
    output reg [15:0] x;
    
    
    always@ (posedge clk3) begin
    case (SW)
        0: begin
        x[15:8] = curPC [7:0];
        x[7:0] = NextPC [7:0];
        end
        1: begin
        x[12:8] = rs [4:0];
        x[15:13] = 3'b000;
        x[7:0] = ReadData1 [7:0];
        end
        2: begin
        x[12:8] = rt [4:0];
        x[15:13] = 3'b000;
        x[7:0] = ReadData2 [7:0];
        end
        3: begin
        x[15:8] = result [7:0];
        x[7:0] = DB [7:0];
        end
    endcase
    end
    
endmodule
