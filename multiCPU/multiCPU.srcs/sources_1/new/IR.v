`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/08 14:53:17
// Design Name: 
// Module Name: IR
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


module IR(clk,reset,IRWre,DataOut,instruct);
    input clk;
    input reset;
    input IRWre;
    input [31:0] DataOut;
    output reg [31:0] instruct;
    /*initial begin 
    instruct <= 32'h08010008;
    end*/
    always@ (posedge clk or negedge reset) begin
        if (reset==0)
            instruct <= DataOut;
        else if (IRWre)
            instruct <= DataOut;
        else 
            instruct <= instruct;
    end
    
endmodule
