`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:12:57 12/24/2020 
// Design Name: 
// Module Name:    MyMCzlz 
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
module MyMCzlz(
	input [3:0]num,
	output [7:0]SEGMENT
    );

   MyMC14490  XLXI_1 (.D0(num[0]), 
                     .D1(num[1]), 
                     .D2(num[2]), 
                     .D3(num[3]), 
                     .LE(1'b0), 
                     .point(1'b1), 
                     .a(SEGMENT[0]), 
                     .b(SEGMENT[1]), 
                     .c(SEGMENT[2]), 
                     .d(SEGMENT[3]), 
                     .e(SEGMENT[4]), 
                     .f(SEGMENT[5]), 
                     .g(SEGMENT[6]), 
                     .p(SEGMENT[7]));
							
endmodule


