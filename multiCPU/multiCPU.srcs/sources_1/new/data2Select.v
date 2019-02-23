`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 08:51:38
// Design Name: 
// Module Name: data2Select
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


module data3Select(control,B,C,result);
    input [1:0]control;
    input [4:0] B;
    input [4:0] C;
    output reg [4:0] result;
    
    always@ (*) begin
        case(control)
            0:
            result=5'b11111;
            1:
            result=B;
            2:
            result=C;
        endcase
    end
endmodule
