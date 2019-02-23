`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/13 17:22:10
// Design Name: 
// Module Name: ROM
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


module ROM (  rw,addr,DataOut);
// 存储器模块 
     input  rw;      // 读使能信号      
     input [ 31:0] addr;    // 存储器地址     
     output  reg [31:0] DataOut;   // 输出的数据
     
     reg [7:0]  rom [99:0]; // 存储器定义必须用reg类型，存储器存储单元8位长度，共100个存储单元     
     initial begin     // 加载数据到存储器rom。注意：必须使用绝对路径，如：E:/Xlinx/VivadoProject/ROM/（自己定）            
         $readmemb ("C:/Users/LJ/Desktop/ECOP-16337130-03/rom_data.txt", rom);  // 数据文件rom_data（.coe或.txt）。未指定，就从0地址开始存放。        
     end     
     always @( rw or addr ) begin           
         if (rw==1) begin            // 为1，读存储器。大端数据存储模式               
          DataOut[31:24] = rom[addr];                
          DataOut[23:16] = rom[addr+1];                
          DataOut[15:8] = rom[addr+2];                
          DataOut[7:0] = rom[addr+3]; 
          end       
     end 
     endmodule 