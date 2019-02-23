`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 22:24:55
// Design Name: 
// Module Name: test
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


module key_debounce(clk,key_in,key_out);
    parameter SAMPLE_TIME = 20;
    input clk;
    input key_in;
    output reg key_out;

    reg [21:0] count_low;
    reg [21:0] count_high;

    initial begin
        key_out <= 0;
    end


    always @(posedge clk)
        if(key_in ==1'b0)
            count_low <= count_low + 1;
        else
            count_low <= 0;

    always @(posedge clk)
        if(key_in ==1'b1)
            count_high <= count_high + 1;
        else
            count_high <= 0;

    always @(posedge clk)
        if(count_high == SAMPLE_TIME)
            key_out<= 1;
        else if(count_low == SAMPLE_TIME)
            key_out <= 0;


endmodule 