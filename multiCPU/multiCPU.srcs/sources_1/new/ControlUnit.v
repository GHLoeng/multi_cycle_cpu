`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/15 10:36:22
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(clk,reset,Opcode,zero,sign,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,
                   RegWre,InsMemRw,WrRegDSrc,RD,WR,IRWre,RegDst,ExtSel,PCSrc,ALUOp,state);
    input clk,reset;
    input [5:0] Opcode;
    input zero;
    input sign;
    output reg PCWre;
    output reg ALUSrcA;
    output reg ALUSrcB;
    output reg DBDataSrc;
    output reg RegWre;
    output reg InsMemRw;
    output reg WrRegDSrc;
    output reg RD;
    output reg WR;
    output reg IRWre;
    output reg [1:0] RegDst;
    output reg ExtSel;
    output reg [1:0] PCSrc;
    output reg [2:0] ALUOp;
    output reg [2:0] state;
    initial begin
        state<=0;
        InsMemRw<=1;
        PCWre<=0;
        RegWre<=0;
        RD<=1;
        WR<=1;
        IRWre<=1;
    end
    always@ (Opcode or state) begin
    if ((Opcode == 6'b111010 && state == 1) || state == 3)
         RegWre = 1;
    else
        RegWre = 0;
    if  ((state == 1 && (Opcode == 6'b111000 || Opcode == 6'b111010 || Opcode == 6'b111001))
        ||(state == 2 && (Opcode == 6'b110100 || Opcode == 6'b110101 || Opcode == 6'b110110))
        ||(state == 4 && Opcode == 6'b110000) || state == 3)
        PCWre = 1;
    else
        PCWre = 0; 
    end
    always@ (posedge clk or negedge reset) begin
        InsMemRw <= 1;
    //reset -> state =0 PCWre RegWre RD WR IRWre
        if (reset == 0)begin
            state<=0;
            //PCWre<=0;
            //RegWre<=0;
            RD<=1;
            WR<=1;
            IRWre<=1;
            end
        else begin//state慢一拍，每次时钟刷新state与操作
        case (state)
            0:begin//001
                state<=1;
                //PCWre<=0;
                IRWre<=0;
                RD<=1;
                WR<=1;
                //RegWre<=0;
            end
            1:begin//000or010
            if (Opcode == 6'b111000 || Opcode == 6'b111010 || Opcode == 6'b111001 || Opcode == 6'b111111) begin//j jal jr halt
                 state<=0;
                 //RegWre<=0;
                 RD<=1;
                 WR<=1;
                 IRWre<=1; /*
                 if (Opcode == 6'b111111)
                    PCWre<=0;
                 else 
                    PCWre<=1; */
                 end
             else begin
                 state<=2;
                 //PCWre<=0;
                 //RegWre<=0;
                 RD<=1;
                 WR<=1;
                 IRWre<=0; 
                 end
             end
             2:begin//000or011or100
             if (Opcode == 6'b110100 || Opcode == 6'b110101 || Opcode == 6'b110110) begin//beq bne bgtz
                 state<=0;
                 //PCWre<=1;
                 //RegWre<=0;
                 RD<=1;
                 WR<=1;
                 IRWre<=1;
                 end
             else if (Opcode == 6'b110000)begin//sw
                 state<=4;
                 //PCWre<=0;
                 //RegWre<=0;
                 RD<=1;
                 WR<=0;
                 IRWre<=0;
                 end
             else if (Opcode == 6'b110001)begin//lw
                     state<=4;
                     //PCWre<=0;
                     //RegWre<=0;
                     RD<=0;
                     WR<=1;
                     IRWre<=0;
                     end  
              else begin
                  state<=3;
                  //PCWre<=0;
                 // RegWre<=1;
                  RD<=1;
                  WR<=1;
                  IRWre<=0;
                  end                            
             end
             3:begin //000
                state<=0;
                //PCWre<=1;
                //RegWre<=0;
                RD<=1;
                WR<=1;
                IRWre<=1;             
             end
             4:begin //000or011
             if (Opcode == 6'b110000) begin //sw
                state<=0;
                //PCWre<=1;
                //RegWre<=0;
                RD<=1;
                WR<=1;
                IRWre<=1; 
                end    
             else begin//lw
                state<=3;
                //PCWre<=0;
                //RegWre<=1;
                RD<=1;
                WR<=1;
                IRWre<=0;
                end                      
             end
        endcase
        end
    end
    
    always@ (Opcode or sign or zero) begin
    ALUSrcA = (Opcode == 6'b011000)? 1:0;
    ALUSrcB = (Opcode == 6'b000010 || Opcode == 6'b010010 || Opcode == 6'b100111 || Opcode == 6'b110000 || Opcode == 6'b110001)? 1:0;
    DBDataSrc = (Opcode == 6'b110001)? 1:0;
    WrRegDSrc = (Opcode == 6'b111010)? 0:1;
     ExtSel = (Opcode == 6'b010010)? 0:1;
     PCSrc[0] = ((Opcode == 6'b110101 && zero==0) || (Opcode == 6'b110100 && zero==1) 
        || (Opcode == 6'b110110 && zero==0 && sign==0) || Opcode == 6'b111000 || Opcode == 6'b111010)? 1:0;
    PCSrc[1] = (Opcode == 6'b111000 || Opcode == 6'b111010 || Opcode == 6'b111001)? 1:0;
    RegDst[0] = (Opcode == 6'b000010 || Opcode == 6'b010010 || Opcode == 6'b100111 || Opcode == 6'b110001)? 1:0; 
    RegDst[1] = (Opcode == 6'b000010 || Opcode == 6'b010010 || Opcode == 6'b100111 || Opcode == 6'b110001 || Opcode == 6'b111010)? 0:1;
     ALUOp[0] = (Opcode == 6'b000001 || Opcode == 6'b010000 || Opcode == 6'b010010 || Opcode == 6'b100110 
        || Opcode == 6'b100111 || Opcode == 6'b110100 || Opcode == 6'b110101 || Opcode == 6'b110110)? 1:0;
     ALUOp[1] = (Opcode == 6'b010001 || Opcode == 6'b100110 || Opcode == 6'b100111)? 1:0;
     ALUOp[2] = (Opcode == 6'b010000 || Opcode == 6'b010001 || Opcode == 6'b010010 || Opcode == 6'b011000)? 1:0;
    end
endmodule

