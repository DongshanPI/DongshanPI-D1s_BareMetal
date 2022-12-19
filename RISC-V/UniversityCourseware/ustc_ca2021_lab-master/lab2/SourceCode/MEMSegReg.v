`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: MEMSegReg
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: EX-MEM Segment Register
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //MEMSegReg是EX-MEM段寄存器
//实验要求  
    //无需修改
    
module MEMSegReg(
    input wire clk,
    input wire en,
    input wire clear,
    //Data Signals
    input wire [31:0] AluOutE,
    output reg [31:0] AluOutM, 
    input wire [31:0] ForwardData2,
    output reg [31:0] StoreDataM, 
    input wire [4:0] RdE,
    output reg [4:0] RdM,
    input wire [31:0] PCE,
    output reg [31:0] PCM,
    //Control Signals
    input wire [2:0] RegWriteE,
    output reg [2:0] RegWriteM,
    input wire MemToRegE,
    output reg MemToRegM,
    input wire [3:0] MemWriteE,
    output reg [3:0] MemWriteM,
    input wire LoadNpcE,
    output reg LoadNpcM,
    input wire CSRWriteE,
    output reg CSRWriteM,
    input wire [31:0] CSROutE,
    output reg [31:0] CSROutM, 
    input wire [11:0] CSRE,
    output reg [11:0] CSRM,
    input wire MemReadE,
    output reg MemReadM

    
    );
    initial begin
        AluOutM    = 0;
        StoreDataM = 0;
        RdM        = 5'h0;
        PCM        = 0;
        RegWriteM  = 3'h0;
        MemToRegM  = 1'b0;
        MemWriteM  = 4'b0;
        LoadNpcM   = 0;
        MemReadM   = 1'b0;
    end
    
    always@(posedge clk)
        if(en) begin
            AluOutM    <= clear ?     0 : AluOutE;
            StoreDataM <= clear ?     0 : ForwardData2;
            RdM        <= clear ?  5'h0 : RdE;
            PCM        <= clear ?     0 : PCE;
            RegWriteM  <= clear ?  3'h0 : RegWriteE;
            MemToRegM  <= clear ?  1'b0 : MemToRegE;
            MemWriteM  <= clear ?  4'b0 : MemWriteE;
            LoadNpcM   <= clear ?     0 : LoadNpcE;
            CSRWriteM  <= clear ?  0 : CSRWriteE;
            CSROutM <= clear? 31'b0: CSROutE;
            CSRM <= clear? 12'b0: CSRE;
            MemReadM   <= clear ?  1'b0 : MemReadE;
        end
    
endmodule
