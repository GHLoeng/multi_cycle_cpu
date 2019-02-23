`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 14:38:37
// Design Name: 
// Module Name: data2Select_32bit
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


module data2Select(control,A,B,result);
    input control;
    input [31:0] A;
    input [31:0] B;
    output [31:0] result;
    
    
    assign result = (control == 0)? A:B;
endmodule
