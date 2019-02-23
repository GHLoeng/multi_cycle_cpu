`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 23:33:29
// Design Name: 
// Module Name: seg7
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


module seg7(x,clk190,a_to_g,pos);
    input wire [15:0]x;
    input wire clk190;
    output reg [6:0] a_to_g;
    output reg [3:0] pos;
    
    
    
    reg [1:0] s=0;
    reg [3:0] digit=0;
    
    // Quad 4选1 MUX： mux44
    always @ ( * )
        case (s)
            0: digit = x[3:0];
            1: digit = x[7:4];
            2: digit = x[11:8];
            3: digit = x[15:12];
            default: digit = x[3:0];
        endcase
    // 7段解码器：hex7seg
    always @ ( * ) begin
        case (digit)
            0: a_to_g = 7'b1000000;
            1: a_to_g = 7'b1111001;
            2: a_to_g = 7'b0100100;
            3: a_to_g = 7'b0110000;
            4: a_to_g = 7'b0011001;
            5: a_to_g = 7'b0010010;
            6: a_to_g = 7'b0000010;
            7: a_to_g = 7'b1011000;
            8: a_to_g = 7'b0000000;
            9: a_to_g = 7'b0010000;
            10:a_to_g = 7'b0001000;
            11:a_to_g = 7'b0000011;
            12:a_to_g = 7'b1000110;
            13:a_to_g = 7'b0100001;
            14:a_to_g = 7'b0000110;
            15:a_to_g = 7'b0001110;
            default: a_to_g = 7'b1111111; // 空白
        endcase
        end
    // 数字选择
    always @ ( * )
        begin
            pos = 4'b1111;
            pos[s] = 0; 
        end
    // 2位计数器
   always @ ( posedge clk190 )
         begin 
             s <= s + 1;
             if (s==4)
             s<=0;
         end
endmodule
