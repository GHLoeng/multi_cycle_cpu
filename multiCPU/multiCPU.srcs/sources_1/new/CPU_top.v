`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 14:39:42
// Design Name: 
// Module Name: CPU_top
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


module CPU_top(clk,keyin,Reset,keyout,curPC,NextPC,rs,ReadData1,rt,ReadData2,result,DB,states);//DB
        input  clk;
        input  keyin;
        input  Reset;
        //以下提供显示用
        output [31:0] curPC;
        output [31:0] NextPC;
        output [4:0] rs;
        output [31:0] ReadData1;
        output [4:0] rt;
        output [31:0] ReadData2;
        output [31:0] result;
        output [31:0] DB;
        output keyout;
        output  [31:0] states;
    wire [2:0] state;
    wire PCWre,RegWre,ExtSel,ALUSrcA,ALUSrcB,RD,WR,DBDataSrc,sign,zero,WrRegDSrc,IRWre;
    wire [1:0] PCSrc,RegDst;
    wire [2:0] ALUopcode;
    wire [4:0] rd,WriteReg;
    wire [5:0] Opcode;
    wire [15:0] immediate;
    wire [27:0] addr;
    wire [31:0] sa,extendImmediate,rega,regb,ROMDataOut,RAMDataOut,IROut,WriteData,ADR,BDR,ALUDR,DBDR;
    wire InsMemRW;
    wire [31:0] PC4;
  
       assign PC4=curPC+4;
       assign states=state;

   
    ControlUnit U0(.clk(keyout),.reset(Reset),.Opcode(Opcode),.zero(zero),.sign(sign),.PCWre(PCWre),
                   .ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.DBDataSrc(DBDataSrc),.RegWre(RegWre),
                   .InsMemRw(InsMemRW),.RD(RD),.WR(WR),.RegDst(RegDst),.ExtSel(ExtSel),
                   .PCSrc(PCSrc),.ALUOp(ALUopcode),.WrRegDSrc(WrRegDSrc),.IRWre(IRWre),.state(state));
    
    key_debounce U1 (.clk(clk),.key_in(keyin),.key_out(keyout));
    //
    PC U2(.Reset(Reset),.clk(keyout),.PCWre(PCWre),.NextPC(NextPC),.curPC(curPC));
    
    ROM U3(.rw(InsMemRW),.addr(curPC),.DataOut(ROMDataOut));
    
    IR U4(.clk(keyout),.reset(Reset),.IRWre(IRWre),.DataOut(ROMDataOut),.instruct(IROut));
    
    Instruction U5(.DataOut(IROut),.Opcode(Opcode),.rs(rs),.rt(rt),
        .rd(rd),.sa(sa),.immediate(immediate),.addr(addr));
        
    data3Select S1 (.control(RegDst),.B(rt),.C(rd),.result(WriteReg));
    //
    RegFile U6 (.CLK(keyout),.RST(Reset),.RegWre(RegWre),.ReadReg1(rs),.ReadReg2(rt)
    ,.WriteReg(WriteReg),.WriteData(WriteData),.ReadData1(ReadData1),.ReadData2(ReadData2));
    
    data2Select S2 (.control(WrRegDSrc),.A(PC4),.B(DB),.result(WriteData));
    
    //ExtSel为0则0扩展，为1则符号扩展
    SignZeroExtend U7 (.ExtSel(ExtSel),.immediate(immediate),.extendImmediate(extendImmediate));
    
    data4Select S3 (.PCSrc(PCSrc),.curPC(curPC),.extendImmediate(extendImmediate),
        .ReadData1(ReadData1),.addr(addr),.NextPC(NextPC));
    
    DR L1 (.clk(keyout),.in(ReadData1),.out(ADR));
    
    DR L2 (.clk(keyout),.in(ReadData2),.out(BDR));
           
    data2Select S4 (.control(ALUSrcA),.A(ADR),.B(sa),.result(rega));
    
    data2Select S5 (.control(ALUSrcB),.A(BDR),.B(extendImmediate),.result(regb));
    
    ALU U8 (.ALUopcode(ALUopcode),.rega(rega),.regb(regb),.result(result),.sign(sign),.zero(zero));
    
    DR L3 (.clk(keyout),.in(result),.out(ALUDR));
    
    //key_value
    RAM U9 (.clk(keyout),.address(ALUDR),.writeData(BDR),
        .nRD(RD), // 为0，正常读；为1,输出高组态
        .nWR(WR), // 为0，写；为1，无操作
        .Dataout(RAMDataOut));
    
    data2Select S6 (.control(DBDataSrc),.A(result),.B(RAMDataOut),.result(DBDR)); 
    
    DR L4 (.clk(keyout),.in(DBDR),.out(DB));
endmodule
