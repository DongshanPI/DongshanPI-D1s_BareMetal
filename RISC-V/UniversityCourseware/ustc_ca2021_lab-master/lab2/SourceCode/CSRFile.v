`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: RegisterFile
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: 
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //上升沿写入，异步读的寄存器堆，0号寄存器值始终为32'b0
    //在接入RV32Core时，输入为~clk，因此本模块时钟输入和其他部件始终相反
    //等价于例化本模块时正常接入时钟clk，同时修改代码为always@(negedge clk or negedge rst) 
//实验要求  
    //无需修改

module CSRFile(
    input wire clk,
    input wire rst,
    input wire WE3,
    input wire [11:0] A1,
    input wire [11:0] A3,
    input wire [31:0] WD3,
    output wire [31:0] RD1
    );

    reg [31:0] RegFile[4095:0];
    integer i;
    //
    always@(negedge clk or posedge rst) 
    begin 
        if(rst)                                 for(i=0;i<4096;i=i+1) RegFile[i][31:0]<=32'b0;
        else if(WE3==1)    RegFile[A3]<=WD3;   
    end
    //    
    assign RD1= RegFile[A1];
    
endmodule
