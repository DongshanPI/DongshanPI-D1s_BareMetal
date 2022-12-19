`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: WBSegReg
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Write Back Segment Register
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //WBSegReg是Write Back段寄存器?
    //类似于IDSegReg.V中对Bram的调用和拓展，它同时包含了一个同步读写的Bram
    //（此处你可以调用我们提供的InstructionRam，它将会自动综合为block memory，你也可以替代?的调用xilinx的bram ip核）?
    //同步读memory 相当? 异步读memory 的输出外接D触发器，?要时钟上升沿才能读取数据?
    //此时如果再?过段寄存器缓存，那么需要两个时钟上升沿才能将数据传递到Ex?
    //因此在段寄存器模块中调用该同步memory，直接将输出传?到WB段组合?辑
    //调用mem模块后输出为RD_raw，?过assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );
    //从?实现RD段寄存器stall和clear功能
//实验要求  
    //你需要补全WBSegReg模块，需补全的片段截取如?
    //DataRam DataRamInst (
    //    .clk    (???),                      //请完善代?
    //    .wea    (???),                      //请完善代?
    //    .addra  (???),                      //请完善代?
    //    .dina   (???),                      //请完善代?
    //    .douta  ( RD_raw         ),
    //    .web    ( WE2            ),
    //    .addrb  ( A2[31:2]       ),
    //    .dinb   ( WD2            ),
    //    .doutb  ( RD2            )
    //);   
//注意事项
    //输入到DataRam的addra是字地址，一个字32bit
    //请配合DataExt模块实现非字对齐字节load
    //请?过补全代码实现非字对齐store


module WBSegReg(
    input wire clk,
    input wire en,
    input wire clear,
    //Data Memory Access
    input wire [31:0] A,
    input wire [31:0] WD,
    input wire [3:0] WE,
    output wire [31:0] RD,
    output reg [1:0] LoadedBytesSelect,
    //Data Memory Debug
    input wire [31:0] A2,
    input wire [31:0] WD2,
    input wire [3:0] WE2,
    output wire [31:0] RD2,
    //input control signals
    input wire [31:0] ResultM,
    output reg [31:0] ResultW, 
    input wire [4:0] RdM,
    output reg [4:0] RdW,
    //output constrol signals
    input wire [2:0] RegWriteM,
    output reg [2:0] RegWriteW,
    input wire MemToRegM,
    output reg MemToRegW,
    input wire CSRWriteM,
    output reg CSRWriteW,
    input wire [31:0] CSROutM,
    output reg [31:0] CSROutW, 
    input wire [11:0] CSRM,
    output reg [11:0] CSRW,
    input wire MemReadM,
    output wire miss,
    input wire rst
    );
    
    //
    initial begin
        LoadedBytesSelect = 2'b00;
        RegWriteW         =  1'b0;
        MemToRegW         =  1'b0;
        ResultW           =     0;
        RdW               =  5'b0;
    end
    //
    always@(posedge clk)
        if(en) begin
            LoadedBytesSelect <= clear ? 2'b00 : A[1:0];
            RegWriteW         <= clear ?  1'b0 : RegWriteM;
            MemToRegW         <= clear ?  1'b0 : MemToRegM;
            ResultW           <= clear ?     0 : ResultM;
            RdW               <= clear ?  5'b0 : RdM;
            CSRWriteW  <= clear ?  0 : CSRWriteM;
            CSROutW <= clear? 31'b0: CSROutM;
            CSRW <= clear? 12'b0: CSRM;
        end

    wire [31:0] RD_raw;
    reg [31:0] WD_in;
    reg [3:0] WE_in;
    always@(*)
    begin
        WE_in = 4'b0000;
        WD_in = 32'b0;
        case(A[1:0])
            2'b00: 
            begin
                WD_in = WD;
                WE_in = WE;
            end
            2'b01:
            begin
                case(WE)
                    4'b0001: 
                    begin
                        WD_in = {16'b0,WD[7:0],8'b0};
                        WE_in = 4'b0010;
                    end
                    4'b0011:
                    begin
                        WD_in = {8'b0,WD[15:0],8'b0};
                        WE_in = 4'b0110;
                    end 
                endcase
            end
            2'b10:
            begin
                case(WE)
                    4'b0001: 
                    begin
                        WD_in = {8'b0,WD[7:0],16'b0};
                        WE_in = 4'b0100;
                    end
                    4'b0011:
                    begin
                        WD_in = {WD[15:0],16'b0};
                        WE_in = 4'b1100;
                    end 
                endcase
            end
            2'b11:
            begin
                case(WE)
                    4'b0001: 
                    begin
                        WD_in = {WD[7:0],24'b0};
                        WE_in = 4'b1000;
                    end
                endcase
            end
        endcase
    end
reg [31:0] total_count;
reg [31:0] miss_count;
reg state;

always@(posedge clk or posedge rst) begin
    if(rst)begin
        state <= 0;
        miss_count <= 0;
    end else begin
        case(state)
        1'b0:begin 
            if(miss) begin
                miss_count <= miss_count + 1;
                state <= 1'b1;   
            end             
        end
        1'b1:begin
            if(!miss) begin
                state <= 1'b0;
            end
        end
        endcase
    end
end
    

always@(posedge clk or posedge rst) begin
    if(rst)begin
        total_count <= 0;
    end else begin
        if((MemReadM | (|WE))&&!miss) begin
            total_count <= total_count + 1;
        end
    end
end

    cache #(
        .LINE_ADDR_LEN  ( 3             ),
        .SET_ADDR_LEN   ( 3             ),
        .TAG_ADDR_LEN   ( 6            ),
        .WAY_CNT        ( 4             )
    ) cache_test_instance (
        .clk            ( clk           ),
        .rst            ( rst           ),
        .miss           ( miss          ),
        .addr           ( A             ),
        .rd_req         ( MemReadM      ),
        .rd_data        ( RD_raw        ),
        .wr_req         ( |WE           ),
        .wr_data        ( WD            )
    );

    // Add clear and stall support
    // if chip not enabled, output output last read result
    // else if chip clear, output 0
    // else output values from bram
    // 以下部分无需修改
    reg stall_ff= 1'b0;
    reg clear_ff= 1'b0;
    reg [31:0] RD_old=32'b0;
    always @ (posedge clk)
    begin
        stall_ff<=~en;
        clear_ff<=clear;
        RD_old<=RD_raw;
    end    
    assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );

endmodule
