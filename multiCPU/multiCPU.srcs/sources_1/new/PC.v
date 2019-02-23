`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/15 13:00:06
// Design Name: 
// Module Name: PC
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


module PC(Reset,clk,PCWre,NextPC,curPC);
    input Reset;
    input clk;
    input PCWre;
    input [31:0] NextPC;
    output reg [31:0] curPC;
    
    initial begin 
        curPC <= 0;
    end
    always@ (posedge clk or negedge Reset) begin
    if (Reset == 0)
        curPC <= 0;
    else begin
        if (PCWre == 1)
            curPC <= NextPC;
        else
            curPC <= curPC;
        end
    end
endmodule
