`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 14:08:17
// Design Name: 
// Module Name: Instruction
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


module Instruction(DataOut,Opcode,rs,rt,rd,sa,immediate,addr);
    input [31:0] DataOut;
    output [5:0] Opcode;
    output [4:0] rs;
    output [4:0] rt;
    output [4:0] rd;
    output [31:0] sa;
    output [15:0] immediate;
    output [27:0] addr;
    
    
    
    assign Opcode [5:0] = DataOut[31:26];
    assign rs [4:0] = DataOut [25:21];
    assign rt [4:0] = DataOut [20:16];
    assign rd [4:0] = DataOut [15:11];
    assign sa [4:0] = DataOut [10:6];
    assign sa [31:5] = 0;
    assign immediate [15:0] = DataOut [15:0];
    assign addr = DataOut [25:0];
    
endmodule
