`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: ControlUnit
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: RISC-V Instruction Decoder
//////////////////////////////////////////////////////////////////////////////////
//功能和接口说明
    //ControlUnit       是本CPU的指令译码器，组合逻辑电路
//输入
    // Op               是指令的操作码部分
    // Fn3              是指令的func3部分
    // Fn7              是指令的func7部分
//输出
    // JalD==1          表示Jal指令到达ID译码阶段
    // JalrD==1         表示Jalr指令到达ID译码阶段
    // RegWriteD        表示ID阶段的指令对应的寄存器写入模式
    // MemToRegD==1     表示ID阶段的指令需要将data memory读取的值写入寄存器,
    // MemWriteD        共4bit，为1的部分表示有效，对于data memory的32bit字按byte进行写入,MemWriteD=0001表示只写入最低1个byte，和xilinx bram的接口类似
    // LoadNpcD==1      表示将NextPC输出到ResultM
    // RegReadD         表示A1和A2对应的寄存器值是否被使用到了，用于forward的处理
    // BranchTypeD      表示不同的分支类型，所有类型定义在Parameters.v中
    // AluContrlD       表示不同的ALU计算功能，所有类型定义在Parameters.v中
    // AluSrc2D         表示Alu输入源2的选择
    // AluSrc1D         表示Alu输入源1的选择
    // ImmType          表示指令的立即数格式
//实验要求  
    //补全模块  

`include "Parameters.v"   
module ControlUnit(
    input wire [6:0] Op,
    input wire [2:0] Fn3,
    input wire [6:0] Fn7,
    output reg JalD,
    output reg JalrD,
    output reg [2:0] RegWriteD,
    output reg MemToRegD,
    output reg [3:0] MemWriteD,
    output reg LoadNpcD,
    output reg [1:0] RegReadD,
    output reg [2:0] BranchTypeD,
    output reg [3:0] AluContrlD,
    output reg [1:0] AluSrc2D,
    output reg AluSrc1D,
    output reg AluSrc3D,
    output reg [2:0] ImmType,
    output reg CSRWriteD,
    output reg CSRReadD,
    output reg MemReadD    
    ); 
    parameter TYPE_I = 7'b0010011;
    parameter TYPE_R = 7'b0110011;
    parameter TYPE_LUI = 7'b0110111;
    parameter TYPE_AUIPC = 7'b0010111;
    parameter TYPE_JALR = 7'b1100111;
    parameter TYPE_JAL = 7'b1101111;
    parameter TYPE_BRANCH = 7'b1100011;
    parameter TYPE_LOAD = 7'b0000011;
    parameter TYPE_STORE = 7'b0100011;
    parameter TYPE_CSR = 7'b1110011;
    // assign JalrD = (Op==JALR);
    // assign JalD = (Op==JAL);
    // if (Op==LOAD) begin
    //     assign MemToRegD = ();
    // end
    // assign MemToRegD = ();
    always @(*) begin
        {RegWriteD,MemWriteD,RegReadD,BranchTypeD,AluContrlD,ImmType,JalD,JalrD,MemToRegD,LoadNpcD,AluSrc1D,AluSrc2D,CSRWriteD,CSRReadD,AluSrc3D, MemReadD}=30'd0;
        case (Op)
            TYPE_I:  begin
                case (Fn3)
                    3'b001: begin
                        case (Fn7) 
                            7'b0000000: begin // SLLI
                                RegWriteD = `LW;
                                RegReadD=2'b01;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD = `SLL;
                                ImmType=`ITYPE;
                                AluSrc2D=2'b01;
                            end
                            default: ;
                        endcase
                    end
                    3'b101: begin
                        case (Fn7) 
                            7'b0000000: begin // SRLI
                                RegWriteD = `LW;
                                RegReadD=2'b01;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD = `SRL;
                                ImmType=`ITYPE;
                                AluSrc2D=2'b01;
                            end
                            7'b0100000: begin //SRAI
                                RegWriteD = `LW;
                                RegReadD=2'b01;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD=`SRA;
                                ImmType=`ITYPE;
                                AluSrc2D=2'b01;
                            end
                            default: ;
                        endcase
                    end
                    3'b000: //ADDI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`ADD;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b010: //SLTI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`SLT;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b011: //SLTIU
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`SLTU;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b100: //XORI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`XOR;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b000: //ADDI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`ADD;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b110://ORI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`OR;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end
                    3'b111://ANDI
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b01;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`AND;
                        ImmType=`ITYPE;
                        AluSrc2D=2'b10;
                    end

                    default: ;
                    
                endcase
            end
            TYPE_R: begin
                case (Fn3)
                    3'b000: // ADD SUB 
                    begin
                        case (Fn7)
                            7'b0000000: // ADD
                            begin
                                RegWriteD=`LW;
                                RegReadD=2'b11;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD=`ADD;
                                ImmType=`RTYPE;
                            end 
                            7'b0100000: // SUB
                            begin
                                RegWriteD=`LW;
                                RegReadD=2'b11;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD=`SUB;
                                ImmType=`RTYPE;
                            end 
                            default: ;
                        endcase
                    end
                    3'b001: // SLL
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`SLL;
                        ImmType=`RTYPE;
                    end
                    3'b010: // SLT
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`SLT;
                        ImmType=`RTYPE;
                    end
                    3'b011: // SLTU
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`SLTU;
                        ImmType=`RTYPE;
                    end
                    3'b100: // XOR
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`XOR;
                        ImmType=`RTYPE;
                    end
                    3'b101: // SRL/SRA
                    begin
                        case (Fn7)
                            7'b0000000: // SRL
                            begin
                                RegWriteD=`LW;
                                RegReadD=2'b11;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD=`SRL;
                                ImmType=`RTYPE;
                            end 
                            7'b0100000: // SRA
                            begin
                                RegWriteD=`LW;
                                RegReadD=2'b11;
                                BranchTypeD=`NOBRANCH;
                                AluContrlD=`SRA;
                                ImmType=`RTYPE;
                            end 
                            default: ;
                        endcase
                    end
                    3'b110: // OR
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`OR;
                        ImmType=`RTYPE;
                    end
                    3'b111: // AND
                    begin
                        RegWriteD=`LW;
                        RegReadD=2'b11;
                        BranchTypeD=`NOBRANCH;
                        AluContrlD=`AND;
                        ImmType=`RTYPE;
                    end
                    default: ;
                endcase
            end
        TYPE_LUI:
        begin
            RegWriteD=`LW;
            RegReadD=2'b00;
            BranchTypeD=`NOBRANCH;
            AluContrlD=`LUI;
            ImmType=`UTYPE;
            AluSrc1D=1;
            AluSrc2D=2'b10;
        end
        TYPE_AUIPC:
        begin
            RegWriteD=`LW;
            RegReadD=2'b00;
            BranchTypeD=`NOBRANCH;
            AluContrlD=`ADD;
            ImmType=`UTYPE;
            AluSrc1D=1;
            AluSrc2D=2'b10;
        end
        TYPE_JALR:
        begin
            AluContrlD=`ADD;
            RegWriteD=`LW;
            RegReadD=2'b01;
            BranchTypeD=`NOBRANCH;
            ImmType=`ITYPE;
            JalrD=1;
            LoadNpcD=1;
            AluSrc2D=2'b10;
        end
        TYPE_JAL:
        begin
            RegWriteD=`LW;
            BranchTypeD=`NOBRANCH;
            ImmType=`JTYPE;
            JalD=1;
            LoadNpcD=1;
        end
        TYPE_BRANCH:
        begin
            case (Fn3)
                3'b000: // BEQ
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BEQ;
                    ImmType=`BTYPE;
                end
                3'b001: // BNE
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BNE;
                    ImmType=`BTYPE;
                end
                3'b100: // BLT
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BLT;
                    ImmType=`BTYPE;
                end
                3'b101: // BGE
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BGE;
                    ImmType=`BTYPE;
                end
                3'b110: // BLTU
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BLTU;
                    ImmType=`BTYPE;
                end
                3'b111: // BGEU
                begin
                    RegWriteD=`NOREGWRITE;
                    RegReadD=2'b11;
                    BranchTypeD=`BGEU;
                    ImmType=`BTYPE;
                end
                default: ;
            endcase
        end
        TYPE_LOAD:
        begin
            case (Fn3)
                3'b000: // LB 
                begin
                    RegWriteD=`LB;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`ADD;
                    ImmType=`ITYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                    MemReadD = 1;
                end
                3'b001: // LH
                begin
                    RegWriteD=`LH;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`ADD;
                    ImmType=`ITYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                    MemReadD = 1;
                end
                3'b010: // LW
                begin
                    RegWriteD=`LW;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`ADD;
                    ImmType=`ITYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                    MemReadD = 1;
                end
                3'b100: // LBU
                begin
                    RegWriteD=`LBU;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`ADD;
                    ImmType=`ITYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                    MemReadD = 1;
                end
                3'b101: // LHU
                begin
                    RegWriteD=`LHU;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`ADD;
                    ImmType=`ITYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                    MemReadD = 1;
                end

                default: ;
            endcase
        end
        TYPE_STORE:
        begin
            case (Fn3)
                3'b000: // SB
                begin
                    MemWriteD=`SB;
                    BranchTypeD=`NOBRANCH;
                    RegReadD=2'b11;
                    AluContrlD=`ADD;
                    ImmType=`STYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                end
                3'b001: // LH
                begin
                    MemWriteD=`SH;
                    BranchTypeD=`NOBRANCH;
                    RegReadD=2'b11;
                    AluContrlD=`ADD;
                    ImmType=`STYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                end
                3'b010: // SW
                begin
                    MemWriteD=`SW;
                    BranchTypeD=`NOBRANCH;
                    RegReadD=2'b11;
                    AluContrlD=`ADD;
                    ImmType=`STYPE;
                    MemToRegD=1;
                    AluSrc2D=2'b10;
                end 
                default: ;
            endcase
        end
        TYPE_CSR:
        begin
            case (Fn3)
                3'b001: // CSRRW
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    RegReadD=2'b01;
                    ImmType=`RTYPE;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`RW;
                    AluSrc2D=2'b11;
                end 
                3'b010: // CSRRS
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`OR;
                    ImmType=`RTYPE;
                    AluSrc2D=2'b11;
                end 
                3'b011: // CSRRS
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    RegReadD=2'b01;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`RC;
                    ImmType=`RTYPE;
                    AluSrc2D=2'b11;
                end 
                3'b101: // CSRRWI
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`RW;
                    AluSrc2D=2'b11;
                    ImmType=`CTYPE;
                    AluSrc3D = 1;
                end 
                3'b110: // CSRRSI
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`OR;
                    AluSrc2D=2'b11;
                    ImmType=`CTYPE;
                    AluSrc3D = 1;
                end 
                3'b111: // CSRRSI
                begin
                    RegWriteD=`LW;
                    CSRWriteD = 1;
                    CSRReadD = 1;
                    BranchTypeD=`NOBRANCH;
                    AluContrlD=`RC;
                    AluSrc2D=2'b11;
                    ImmType=`CTYPE;
                    AluSrc3D = 1;
                end 
                default: ;
            endcase
        end
        endcase
    end
endmodule

