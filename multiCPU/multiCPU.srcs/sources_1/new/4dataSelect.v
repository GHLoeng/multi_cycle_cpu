`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/16 23:42:07
// Design Name: 
// Module Name: 4dataSelect
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


module data4Select(PCSrc,curPC,extendImmediate,ReadData1,addr,NextPC);
    input [1:0] PCSrc;
    input [31:0] curPC;
    input [31:0] extendImmediate;
    input [31:0] ReadData1;
    input [27:0] addr;
    output reg [31:0] NextPC;
    
    
    
    reg [31:0] PC4 ;
   
    always@ (*) begin
    PC4[31:0] <= curPC[31:0] + 4;
        case (PCSrc)
            0:
            NextPC=PC4;
            1:
            NextPC=PC4+(extendImmediate<<2);
            2:
            NextPC=ReadData1;
            3: begin
            NextPC[31:28] = PC4[31:28];
            NextPC[27:0] = addr [27:0];
            end
        endcase
     end
    
endmodule
