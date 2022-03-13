`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:52 12/14/2020 
// Design Name: 
// Module Name:    DispNum 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DispNum(clk, 
                HEXS, 
                RST, 
                AN, 
                SEGMENT);

    input clk;
    input [15:0] HEXS;
    input RST;
   output [3:0] AN;
   output [7:0] SEGMENT;
   
   wire V0;
   wire V5;
   wire XLXN_10;
   wire [3:0] XLXN_11;
   wire [31:0] XLXN_17;
   
   MyMC14490  XLXI_1 (.D0(XLXN_11[0]), 
                     .D1(XLXN_11[1]), 
                     .D2(XLXN_11[2]), 
                     .D3(XLXN_11[3]), 
                     .LE(XLXN_10), 
                     .point(XLXN_10), 
                     .a(SEGMENT[0]), 
                     .b(SEGMENT[1]), 
                     .c(SEGMENT[2]), 
                     .d(SEGMENT[3]), 
                     .e(SEGMENT[4]), 
                     .f(SEGMENT[5]), 
                     .g(SEGMENT[6]), 
                     .p(SEGMENT[7]));
   Mulx4to1b4  XLXI_2 (.I0(HEXS[3:0]), 
                      .I1(HEXS[7:4]), 
                      .I2(HEXS[11:8]), 
                      .I3(HEXS[15:12]), 
                      .s(XLXN_17[18:17]), 
                      .o(XLXN_11[3:0]));
   Mulx4to1b4  XLXI_3 (.I0({V5, V5, V5, V0}), 
                      .I1({V5, V5, V0, V5}), 
                      .I2({V5, V0, V5, V5}), 
                      .I3({V0, V5, V5, V5}), 
                      .s(XLXN_17[18:17]), 
                      .o(AN[3:0]));
   clkdiv  XLXI_4 (.clk(clk), 
                  .rst(RST), 
                  .clkdiv(XLXN_17[31:0]));
   GND  XLXI_6 (.G(XLXN_10));
   GND  XLXI_7 (.G(V0));
   VCC  XLXI_8 (.P(V5));
endmodule