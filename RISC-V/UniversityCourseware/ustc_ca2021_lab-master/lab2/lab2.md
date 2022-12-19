# 计算机体系结构Lab2
## 简要说明

* 在实验一中我们初步了解了RISCV指令集和数据通路，接下来需要用verilog去实现我们的RV32I 流水线CPU了。	
* 本次实验分为三周，总共分为三个阶段进行验收。每周完成一个阶段。
* 实验结束后（阶段三检查完成）一周内需要提交Lab2的实验报告。
* **实验工具**：Vivado
* **实验方式**：Vivado自带的波形仿真

## 代码说明

* 三个目录Simulation、SourceCode、TestDataTools分别包含了仿真文件及测试数据、源代码、测试数据生成工具。
* 由于Vivado的编辑器存在中文编码问题，推荐在VScode环境下开发代码。
* 源代码均有注释，说明了模块功能、接口作用、是否需要补全，请参考注释完成RV32I Core
* 阶段二的测试可以参考General Register的3号寄存器，它的值代表执行到第几个test，全部测试通过，3号寄存器的值最终变为1


## 使用说明

* 以Vivado开发为例，新建工程，将SourceCode的代码导入，Simulation文件夹下的testBench.v作为仿真文件导入，并将testBench.v设置为Simulation的Top文件。之后直接进行仿真即可，会自动将.inst和.data的文件加载进Instruction Cache和Data Cache，并开始执行。
* testBench.v定义的四个宏：`DataCacheContentLoadPath`, `InstCacheContentLoadPath`, `DataCacheContentSavePath`, `InstCacheContentSavePath` ，分别是Data Cache、Instruction Cache的写入文件路径，及Data Cache、Instruction Cache导出内容路径，请根据需要自行修改。
* TestDataTools的工具使用说明，请参考文件夹的Readme文档

## 验收说明

### 阶段一验收要求（30%）：

*	自己手写合适的测试用汇编代码，通过提供的工具生成.inst和.data文件，用于初始化指令和数据的Block Memory，或者直接手写二进制测试代码
*	测试用的指令流中需要包含的指令包括SLLI、SRLI、SRAI、ADD、SUB、SLL、SLT、SLTU、XOR、SRL、SRA、OR、AND、ADDI、SLTI、SLTIU、XORI、ORI、ANDI、LUI、AUIPC
*	测试例（汇编和对应的.inst .data）可以用其他同学提供的，但是需要自己知道对应的指令逻辑，需要能清楚的向助教表达这个测试例如何验证CPU功能正确，即正确运行后寄存器值应该是多少
*	CPU执行后，各寄存器值符合预期
*	此时不需要处理数据相关。可以令Harzard模块始终输出stall、flush恒为0，forward恒为不转发，每两条指令之间间隔四条空指令。

### 阶段二验收要求（30%）：

* 我们提供了 1testAll.data、1testAll.inst、2testAll.data、2testAll.data、3testAll.data、
3testAll.inst 三个测试样例的.inst 和.data 文件，用于初始化指令和数据的 Block Memory。
* 对于任意一个测试样例，CPU 开始执行后 3 号寄存器的值会从 2 一直累增，该数字正在进行第多少项测试，执行结束后 3 号寄存器值变为 1
* CPU 执行后，各寄存器值符合预期
* 测试用的指令流中，除了阶段一的测试指令，还需要包含的指令包括 JALR、LB、LH、LW、LBU、LHU、SB、SH、SW、BEQ、BNE、BLT、BLTU、BGE、BGEU、JAL
* 此时需要处理数据相关，实现 Harzard 模块内部逻辑。

### 阶段三验收要求（20%）：

* 自己手写合适的测试用汇编代码，通过提供的工具生成.inst 和.data 文件，用于初始化
指令和数据的 Block Memory
* 在我们给的代码框架上添加你设计好的 CSR 数据通路 
* 测试用的指令流中需要包含的指令包括: CSRRW、CSRRS、CSRRC、CSRRWI、CSRRSI、
CSRRCI
* CPU 执行后，各寄存器值符合预期
* 阶段二已经处理好数据相关，这里不再特别考察(不代表不用实现流水线相关)

### Lab2实验报告（20%）：

*	实验目标
*	实验环境和工具
*	实验内容和过程（总结自己所做的三个阶段工作）
*	实验总结（说说自己踩的坑，总结收获，分析下自己花了多少时间，都用来做什么事情）
*	提出改进实验的意见
