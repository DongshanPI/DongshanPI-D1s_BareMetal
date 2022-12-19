
module mem #(                   // 
    parameter  ADDR_LEN  = 11   // 
) (
    input  clk, rst,
    input  [ADDR_LEN-1:0] addr, // memory address
    output reg [31:0] rd_data,  // data read out
    input  wr_req,
    input  [31:0] wr_data       // data write in
);
localparam MEM_SIZE = 1<<ADDR_LEN;
reg [31:0] ram_cell [MEM_SIZE];

always @ (posedge clk or posedge rst)
    if(rst)
        rd_data <= 0;
    else
        rd_data <= ram_cell[addr];

always @ (posedge clk)
    if(wr_req) 
        ram_cell[addr] <= wr_data;

initial begin
    ram_cell[       0] = 32'h00000021;
    ram_cell[       1] = 32'h00000017;
    ram_cell[       2] = 32'h00000098;
    ram_cell[       3] = 32'h000000ec;
    ram_cell[       4] = 32'h0000009d;
    ram_cell[       5] = 32'h0000000c;
    ram_cell[       6] = 32'h00000003;
    ram_cell[       7] = 32'h000000a6;
    ram_cell[       8] = 32'h00000012;
    ram_cell[       9] = 32'h000000d5;
    ram_cell[      10] = 32'h000000c3;
    ram_cell[      11] = 32'h000000ad;
    ram_cell[      12] = 32'h000000eb;
    ram_cell[      13] = 32'h000000da;
    ram_cell[      14] = 32'h00000072;
    ram_cell[      15] = 32'h0000007d;
    ram_cell[      16] = 32'h0000005a;
    ram_cell[      17] = 32'h00000029;
    ram_cell[      18] = 32'h00000011;
    ram_cell[      19] = 32'h00000094;
    ram_cell[      20] = 32'h00000001;
    ram_cell[      21] = 32'h000000ea;
    ram_cell[      22] = 32'h00000045;
    ram_cell[      23] = 32'h00000028;
    ram_cell[      24] = 32'h0000000d;
    ram_cell[      25] = 32'h000000ac;
    ram_cell[      26] = 32'h000000f5;
    ram_cell[      27] = 32'h00000084;
    ram_cell[      28] = 32'h000000b5;
    ram_cell[      29] = 32'h000000f0;
    ram_cell[      30] = 32'h00000027;
    ram_cell[      31] = 32'h0000002a;
    ram_cell[      32] = 32'h000000ba;
    ram_cell[      33] = 32'h00000067;
    ram_cell[      34] = 32'h0000005c;
    ram_cell[      35] = 32'h000000e8;
    ram_cell[      36] = 32'h000000d6;
    ram_cell[      37] = 32'h0000002b;
    ram_cell[      38] = 32'h0000001c;
    ram_cell[      39] = 32'h000000db;
    ram_cell[      40] = 32'h000000d7;
    ram_cell[      41] = 32'h0000007a;
    ram_cell[      42] = 32'h000000e3;
    ram_cell[      43] = 32'h0000009a;
    ram_cell[      44] = 32'h000000c7;
    ram_cell[      45] = 32'h000000a8;
    ram_cell[      46] = 32'h00000044;
    ram_cell[      47] = 32'h0000005e;
    ram_cell[      48] = 32'h00000031;
    ram_cell[      49] = 32'h00000048;
    ram_cell[      50] = 32'h0000002d;
    ram_cell[      51] = 32'h00000022;
    ram_cell[      52] = 32'h0000003c;
    ram_cell[      53] = 32'h0000007b;
    ram_cell[      54] = 32'h000000fa;
    ram_cell[      55] = 32'h00000074;
    ram_cell[      56] = 32'h000000cd;
    ram_cell[      57] = 32'h00000033;
    ram_cell[      58] = 32'h00000051;
    ram_cell[      59] = 32'h000000bf;
    ram_cell[      60] = 32'h00000082;
    ram_cell[      61] = 32'h00000095;
    ram_cell[      62] = 32'h00000036;
    ram_cell[      63] = 32'h0000001a;
    ram_cell[      64] = 32'h000000ef;
    ram_cell[      65] = 32'h000000dc;
    ram_cell[      66] = 32'h00000016;
    ram_cell[      67] = 32'h0000005b;
    ram_cell[      68] = 32'h000000b3;
    ram_cell[      69] = 32'h000000a3;
    ram_cell[      70] = 32'h0000001b;
    ram_cell[      71] = 32'h00000053;
    ram_cell[      72] = 32'h000000df;
    ram_cell[      73] = 32'h000000b8;
    ram_cell[      74] = 32'h00000070;
    ram_cell[      75] = 32'h0000009f;
    ram_cell[      76] = 32'h000000e2;
    ram_cell[      77] = 32'h00000079;
    ram_cell[      78] = 32'h00000015;
    ram_cell[      79] = 32'h00000009;
    ram_cell[      80] = 32'h000000a7;
    ram_cell[      81] = 32'h00000013;
    ram_cell[      82] = 32'h00000080;
    ram_cell[      83] = 32'h00000024;
    ram_cell[      84] = 32'h0000005f;
    ram_cell[      85] = 32'h00000037;
    ram_cell[      86] = 32'h000000c9;
    ram_cell[      87] = 32'h0000008a;
    ram_cell[      88] = 32'h00000055;
    ram_cell[      89] = 32'h00000041;
    ram_cell[      90] = 32'h00000087;
    ram_cell[      91] = 32'h00000066;
    ram_cell[      92] = 32'h000000ae;
    ram_cell[      93] = 32'h00000046;
    ram_cell[      94] = 32'h00000081;
    ram_cell[      95] = 32'h00000018;
    ram_cell[      96] = 32'h0000007f;
    ram_cell[      97] = 32'h000000ca;
    ram_cell[      98] = 32'h00000076;
    ram_cell[      99] = 32'h000000b1;
    ram_cell[     100] = 32'h0000004c;
    ram_cell[     101] = 32'h00000086;
    ram_cell[     102] = 32'h0000002c;
    ram_cell[     103] = 32'h0000005d;
    ram_cell[     104] = 32'h000000e0;
    ram_cell[     105] = 32'h000000b7;
    ram_cell[     106] = 32'h0000004e;
    ram_cell[     107] = 32'h00000047;
    ram_cell[     108] = 32'h0000009b;
    ram_cell[     109] = 32'h000000de;
    ram_cell[     110] = 32'h00000054;
    ram_cell[     111] = 32'h00000042;
    ram_cell[     112] = 32'h000000aa;
    ram_cell[     113] = 32'h000000c2;
    ram_cell[     114] = 32'h000000b6;
    ram_cell[     115] = 32'h00000035;
    ram_cell[     116] = 32'h000000a9;
    ram_cell[     117] = 32'h000000bb;
    ram_cell[     118] = 32'h0000002f;
    ram_cell[     119] = 32'h000000b9;
    ram_cell[     120] = 32'h0000000b;
    ram_cell[     121] = 32'h00000065;
    ram_cell[     122] = 32'h000000d4;
    ram_cell[     123] = 32'h000000ab;
    ram_cell[     124] = 32'h00000032;
    ram_cell[     125] = 32'h000000fd;
    ram_cell[     126] = 32'h0000001d;
    ram_cell[     127] = 32'h00000085;
    ram_cell[     128] = 32'h00000088;
    ram_cell[     129] = 32'h00000090;
    ram_cell[     130] = 32'h000000b4;
    ram_cell[     131] = 32'h000000a4;
    ram_cell[     132] = 32'h00000014;
    ram_cell[     133] = 32'h00000096;
    ram_cell[     134] = 32'h000000b2;
    ram_cell[     135] = 32'h0000006b;
    ram_cell[     136] = 32'h000000d2;
    ram_cell[     137] = 32'h00000006;
    ram_cell[     138] = 32'h00000059;
    ram_cell[     139] = 32'h0000004b;
    ram_cell[     140] = 32'h000000c0;
    ram_cell[     141] = 32'h0000007e;
    ram_cell[     142] = 32'h000000e4;
    ram_cell[     143] = 32'h0000008d;
    ram_cell[     144] = 32'h00000093;
    ram_cell[     145] = 32'h000000f2;
    ram_cell[     146] = 32'h0000006f;
    ram_cell[     147] = 32'h0000000e;
    ram_cell[     148] = 32'h000000fb;
    ram_cell[     149] = 32'h00000078;
    ram_cell[     150] = 32'h0000004f;
    ram_cell[     151] = 32'h0000003d;
    ram_cell[     152] = 32'h0000003f;
    ram_cell[     153] = 32'h000000fc;
    ram_cell[     154] = 32'h000000fe;
    ram_cell[     155] = 32'h0000006a;
    ram_cell[     156] = 32'h000000c1;
    ram_cell[     157] = 32'h0000003b;
    ram_cell[     158] = 32'h0000006e;
    ram_cell[     159] = 32'h0000006d;
    ram_cell[     160] = 32'h00000040;
    ram_cell[     161] = 32'h00000034;
    ram_cell[     162] = 32'h0000009e;
    ram_cell[     163] = 32'h000000c6;
    ram_cell[     164] = 32'h000000e6;
    ram_cell[     165] = 32'h0000003a;
    ram_cell[     166] = 32'h00000020;
    ram_cell[     167] = 32'h000000d9;
    ram_cell[     168] = 32'h000000bd;
    ram_cell[     169] = 32'h000000bc;
    ram_cell[     170] = 32'h0000001e;
    ram_cell[     171] = 32'h00000043;
    ram_cell[     172] = 32'h000000a2;
    ram_cell[     173] = 32'h00000056;
    ram_cell[     174] = 32'h0000000a;
    ram_cell[     175] = 32'h000000a5;
    ram_cell[     176] = 32'h000000be;
    ram_cell[     177] = 32'h000000f4;
    ram_cell[     178] = 32'h00000002;
    ram_cell[     179] = 32'h0000007c;
    ram_cell[     180] = 32'h0000006c;
    ram_cell[     181] = 32'h00000026;
    ram_cell[     182] = 32'h000000ff;
    ram_cell[     183] = 32'h000000af;
    ram_cell[     184] = 32'h00000089;
    ram_cell[     185] = 32'h0000008f;
    ram_cell[     186] = 32'h00000064;
    ram_cell[     187] = 32'h00000061;
    ram_cell[     188] = 32'h00000049;
    ram_cell[     189] = 32'h00000097;
    ram_cell[     190] = 32'h000000f6;
    ram_cell[     191] = 32'h000000f3;
    ram_cell[     192] = 32'h0000008b;
    ram_cell[     193] = 32'h00000038;
    ram_cell[     194] = 32'h00000004;
    ram_cell[     195] = 32'h00000073;
    ram_cell[     196] = 32'h00000007;
    ram_cell[     197] = 32'h00000075;
    ram_cell[     198] = 32'h00000008;
    ram_cell[     199] = 32'h000000f1;
    ram_cell[     200] = 32'h000000a0;
    ram_cell[     201] = 32'h000000ce;
    ram_cell[     202] = 32'h00000030;
    ram_cell[     203] = 32'h00000050;
    ram_cell[     204] = 32'h00000071;
    ram_cell[     205] = 32'h00000023;
    ram_cell[     206] = 32'h00000005;
    ram_cell[     207] = 32'h00000091;
    ram_cell[     208] = 32'h000000c8;
    ram_cell[     209] = 32'h00000069;
    ram_cell[     210] = 32'h00000099;
    ram_cell[     211] = 32'h0000004d;
    ram_cell[     212] = 32'h0000000f;
    ram_cell[     213] = 32'h00000019;
    ram_cell[     214] = 32'h000000d1;
    ram_cell[     215] = 32'h000000f8;
    ram_cell[     216] = 32'h00000083;
    ram_cell[     217] = 32'h00000058;
    ram_cell[     218] = 32'h000000cb;
    ram_cell[     219] = 32'h0000008c;
    ram_cell[     220] = 32'h000000e5;
    ram_cell[     221] = 32'h00000077;
    ram_cell[     222] = 32'h00000010;
    ram_cell[     223] = 32'h0000008e;
    ram_cell[     224] = 32'h00000063;
    ram_cell[     225] = 32'h000000d0;
    ram_cell[     226] = 32'h0000001f;
    ram_cell[     227] = 32'h000000a1;
    ram_cell[     228] = 32'h00000025;
    ram_cell[     229] = 32'h0000002e;
    ram_cell[     230] = 32'h00000000;
    ram_cell[     231] = 32'h000000d3;
    ram_cell[     232] = 32'h00000039;
    ram_cell[     233] = 32'h0000003e;
    ram_cell[     234] = 32'h000000dd;
    ram_cell[     235] = 32'h0000004a;
    ram_cell[     236] = 32'h000000e9;
    ram_cell[     237] = 32'h0000009c;
    ram_cell[     238] = 32'h000000cc;
    ram_cell[     239] = 32'h00000057;
    ram_cell[     240] = 32'h00000062;
    ram_cell[     241] = 32'h000000ee;
    ram_cell[     242] = 32'h000000b0;
    ram_cell[     243] = 32'h00000052;
    ram_cell[     244] = 32'h000000e1;
    ram_cell[     245] = 32'h000000e7;
    ram_cell[     246] = 32'h00000060;
    ram_cell[     247] = 32'h000000c5;
    ram_cell[     248] = 32'h000000f7;
    ram_cell[     249] = 32'h000000cf;
    ram_cell[     250] = 32'h000000f9;
    ram_cell[     251] = 32'h000000d8;
    ram_cell[     252] = 32'h00000092;
    ram_cell[     253] = 32'h000000ed;
    ram_cell[     254] = 32'h000000c4;
    ram_cell[     255] = 32'h00000068;
end

endmodule

