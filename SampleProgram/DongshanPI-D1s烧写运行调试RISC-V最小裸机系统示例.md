# DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例

## 获取工程

我们所有的操作环境目前在ubuntu-18.04 请使用ubuntu系统进行操作

工程源码存放在 https://github.com/DongshanPI/DongshanPI-D1s_BareMetal 内，需要在终端下使用git命令进行clone获取,获取完成源码后，进入 源码目录内，执行 git submodule update --init  单独获取交叉编译工具链

```shell
book@ubuntu1804:~$ git clone https://github.com/DongshanPI/DongshanPI-D1s_BareMetal.git
Cloning into 'DongshanPI-D1s_BareMetal'...
remote: Enumerating objects: 369, done.
remote: Counting objects: 100% (135/135), done.
remote: Compressing objects: 100% (107/107), done.
remote: Total 369 (delta 26), reused 129 (delta 22), pack-reused 234
Receiving objects: 100% (369/369), 258.22 MiB | 8.49 MiB/s, done.
Resolving deltas: 100% (78/78), done.
Checking out files: 100% (322/322), done.
book@ubuntu1804:~$ cd DongshanPI-D1s_BareMetal/
book@ubuntu1804:~/DongshanPI-D1s_BareMetal$ ls
README.md  ReferenceResources  SampleProgram  toolchain  Tools
book@ubuntu1804:~/DongshanPI-D1s_BareMetal$ git submodule update --init 
Submodule 'toolchain' (https://gitlab.com/dongshanpi/toolchain.git) registered for path 'toolchain'
Cloning into '/home/book/DongshanPI-D1s_BareMetal/toolchain'...
Submodule path 'toolchain': checked out 'c2132b75fd91e2f532bd8030ff63244e148ac172'
book@ubuntu1804:~/DongshanPI-D1s_BareMetal$ 
```

工程目录作用介绍

```bash
book@ubuntu1804:~/DongshanPI-D1s_BareMetal$ tree -L 2
.
├── README.md //主README说明文档
├── ReferenceResources //支持的参考资料，有主芯片架构相关 GNU相关 RISC-V组织官方文献 以及平头哥C906相关参考资料
│   ├── Allwinner-D1
│   ├── GNU
│   ├── RISC-V
│   └── Thead-C906
├── SampleProgram //提供两个裸机示例程序，优先阅读 spinor-count_example 这个
│   ├── spinor-count_example
│   └── YuzukiHD_d1-ddr_example
├── toolchain //支持的交叉编译工具链，可以直接进行配置编译裸机使用
│   └── riscv64-glibc-gcc-thead_20200702
└── Tools //支持的烧写工具，一个是 主芯片调试器的DebugServer驱动，一个是xfel单独的usb烧录裸机工具，可以在Ubuntu下使用。
    ├── CKLinkServer
    └── xfel

```



## 编译工程

这个工程示例以 spinor的示例为主，~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example 进入此目录内，执行make命令进行编译。

```bash
book@ubuntu1804:~/DongshanPI-D1s_BareMetal$ cd SampleProgram/spinor-count_example/
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example$ ls
include  link.ld  Makefile  source
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example$ make 
[AS] source/start.S
[AS] source/memset.S
[AS] source/memcpy.S
[CC] source/sys-dram.c
[CC] source/sys-uart.c
[CC] source/sys-clock.c
[CC] source/sys-spinor.c
[CC] source/main.c
[CC] source/sys-jtag.c
[CC] source/sys-copyself.c
[LD] Linking output/d1s-baremetal.elf
[OC] Objcopying output/d1s-baremetal.bin
copy from `output/d1s-baremetal.elf' [elf64-littleriscv] to `output/d1s-baremetal.bin' [binary]
Make header information for brom booting
The bootloader head has been fixed, spl size is 24576 bytes.
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example$ 

```

编译生成的文件在工程目录下的output目录， d1s-baremetal.bin 我们烧写使用的是 d1s-baremetal.bin 这个文件，调试使用 d1s-baremetal.elf 文件

## 烧写至开发板

如下图为开发板的功能示意图，我们需要先将 配套的typec线 一根插至 黑色序号3. OTG烧录接口，用于进行供电和烧录系统操作。

![](http://photos.100ask.net/dongshanpi/d1s/DongshanPI-D1s-V2TopFuction.png)

连接成功后后，长按 黑色序号2. 烧录模式按键此时按一下 5.系统复位按键 开发板就会进入烧录模式，如果之前安装过 全志的usb烧写驱动，电脑的设备管理器会出来一个 usb device设备，表明已经进入烧写模式成功。如果你的电脑没有安装驱动，会提示一个 位置设备 https://dongshanpi.com/DongshanNezhaSTU/03-QuickStart/#usb 那么请参考这篇文章安装一下驱动。

![image-20221230183307481](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230183307481.png)

接下来 我没将设备挂载到Ubuntu系统内,如下图所示。

![image-20221230183836681](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230183836681.png)

连接成功后，我们进入到 DongshanPI-D1s_BareMetal/Tools/xfel 目录下，执行xfel version命令，可以看到已经识别到了芯片。

```bash
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/xfel$ sudo ./xfel version
AWUSBFEX ID=0x00185900(D1/F133) dflag=0x44 dlength=0x08 scratchpad=0x00045000
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/xfel$ 
```

识别到芯片以后，就可以将我们前面编译生成的镜像烧录进开发板里面了。

```bash 
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/xfel$ sudo ./xfel spinor write 0x0 /home/book/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example/output/d1s-baremetal.bin 
100% [================================================] 24.000 KB, 176.538 KB/s        
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/xfel$ 

```

烧录完成以后，重启开发板。 接上串口 PE2 PE3就可以看到启动信息，需要提前连接 黑色序号4. 调试&串口 CKlink接口到电脑，然后使用杜邦线 一段连接至PE2引脚(背面有引脚编号标注)，另一端连接至 黄色标号 的RX 接口。

![image-20221230184634686](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230184634686.png)

使用putty或者mobaxterm等工具打开串口设备，按下RESET键重启开发板，就可以看到串口启动的裸机程序了

![image-20221230184524274](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230184524274.png)



## 调试裸机

主要分为两步，步骤一，安装对应的CKlink驱动程序，步骤二 使用gdb调试

步骤1，先将开发板 黑色序号为4的 调试&串口接口的配套TYPEC线连接至电脑USB接口，此时设备管理器会弹出两个设备，一个是串口设备一个是Cklink-lite设备，如下图所示，拨码开关要提前拨到 靠近 typec方向，也就是字母ON方向，这样才能使用Cklink去调试主芯片。

![image-20221230184903102](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230184903102.png)

接下来 将 Cklink-lite设备连接到Ubuntu系统内

![image-20221230185133821](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230185133821.png)

连接完成后，进入到Ubuntu系统终端内，切换到  ~/DongshanPI-D1s_BareMetal/Tools/CKLinkServer 目录下，进行安装 Cklink对应的驱动。我们使用的版本是 T-Head-DebugServer-linux-x86_64-V5.16.6-20221102.sh.tar.gz 这个。如下安装步骤，使用的命令 都进行了 绿色标亮，用于区分，安装时保持默认就可以。



```bash
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/CKLinkServer$ ls
T-HEAD+CPU调试技巧.pdf
T-Head-DebugServer-linux-i386-V5.16.6-20221102.sh.tar.gz
`T-Head-DebugServer-linux-x86_64-V5.16.6-20221102.sh.tar.gz`
T-Head-DebugServer-windows-V5.16.6-20221102-1510.zip
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/CKLinkServer$ `tar -xvf T-Head-DebugServer-linux-x86_64-V5.16.6-20221102.sh.tar.gz 
T-Head-DebugServer-linux-x86_64-V5.16.6-20221102.sh
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/CKLinkServer$ `sudo ./T-Head-DebugServer-linux-x86_64-V5.16.6-20221102.sh  -i`
You have installed DebugServerConsole in : /usr/bin/T-HEAD_DebugServer
Uninstall DebugServerConsole! [yes/no]:`yes`
Uninstall ...
Do you agree to install the DebugServer? [yes/no]:`yes`
Set full installing path:
This software will be installed to the path: (/usr/bin)? [yes/no/cancel]:`yes`
Installing ...
Done!
You can use command "DebugServerConsole" to start DebugServerConsole!
(NOTE: The full path of 'DebugServerConsole.elf' is: /usr/bin/T-HEAD_DebugServer)
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/Tools/CKLinkServer$ 

```

安装完成后，我们在任意位置输入DebugServerConsole 就可以启动调试器了，默认情况下会自动识别到D1s主芯片，如果识别不到，可以尝试 进入烧录模式，如果无法识别，可以尝试长按 黑色序号 **2. 烧录模式按钮**  按一下 黑色序号 **5. 系统复位按键** 进入烧录模式，也就是调试模式，这个时候 再次执行 DebugServerConsole 就可以识别到了。

```bash
book@ubuntu1804:~$ DebugServerConsole 
+---                                                    ---+
|  T-Head Debugger Server (Build: Nov  2 2022)	           |
   User   Layer Version : 5.16.06 
   Target Layer version : 2.0
|  Copyright (C) 2022 T-HEAD Semiconductor Co.,Ltd.        |
+---                                                    ---+
T-HEAD: CKLink_Lite_V2, App_ver unknown, Bit_ver null, Clock 2526.316KHz,
       5-wire, With DDC, Cache Flush On, SN CKLink_Lite_Vendor-rog C9F85B.
+--  Debug Arch is CKHAD.  --+
+--  CPU 0  --+
T-HEAD Xuan Tie CPU Info:
	WORD[0]: 0x0910090d
	WORD[1]: 0x11002000
	WORD[2]: 0x260c0001
	WORD[3]: 0x30030066
	WORD[4]: 0x42180000
	WORD[5]: 0x50000000
	WORD[6]: 0x60000853
	MISA   : 0x8000000000b4112d
Target Chip Info:
	CPU Type is C906FDV, Endian=Little, Vlen=128, Version is R1S0P2.
	DCache size is 32K, 4-Way Set Associative, Line Size is 64Bytes, with no ECC.
	ICache size is 32K, 2-Way Set Associative, Line Size is 64Bytes, with no ECC.
	Target is 1 core.
	MMU has 256 JTLB items.
	PMP zone num is 8.
	HWBKPT number is 2, HWWP number is 2.
	MISA: (RV64IMAFDCVX, Imp M-mode, S-mode, U-mode)

GDB connection command for CPUs(CPU0):
	`target remote 127.0.0.1:1025
	`target remote 192.168.19.133:1025

****************  DebuggerServer Commands List **************
help/h
	Show help informations.
*************************************************************
DebuggerServer$ 

```

可以识别到CPU以后，我们需要记住 上面两行绿色的  CPU 链接地址和端口 分别是 target remote 127.0.0.1:1025 target remote 192.168.19.133:1025 默认都可以，在接下来的调试中会用到。



接下来进行步骤二： 调试D1s裸机程序

在保持上述的 DebugServerConsole 不关闭状态下，重新开一个新的终端，进入到 提前编译好的裸机程序 ~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example/output 目录下 开始使用 d1s-baremetal.elf 进行调试，注意我们的 gdb调试器在 /home/book/DongshanPI-D1s_BareMetal/toolchain/riscv64-glibc-gcc-thead_20200702/bin/riscv64-unknown-linux-gnu-gdb 这个，其中，需要连接的设备地址是target remote 127.0.0.1:1025 连接成功后 就可以开始执行断点 进行调试操作了。

```bash
book@ubuntu1804:~/DongshanPI-D1s_BareMetal/SampleProgram/spinor-count_example/output$  /home/book/DongshanPI-D1s_BareMetal/toolchain/riscv64-glibc-gcc-thead_20200702/bin/riscv64-unknown-linux-gnu-gdb d1s-baremetal.elf 
GNU gdb (C-SKY RISCV Tools V1.8.4 B20200702) 8.2.50.20190202-git
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-pc-linux-gnu --target=riscv64-unknown-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from d1s-baremetal.elf...
(gdb) `target remote 127.0.0.1:1025`
Remote debugging using 127.0.0.1:1025
0x000000004000502a in __delay (loop=1000000) at source/main.c:8
8		for(; loop > 0; loop--);
(gdb) 

```

![image-20221230190336579](C:\Users\livel\Downloads\DongshanPI-D1s烧写运行调试RISC-V最小裸机系统示例.assets\image-20221230190336579.png)