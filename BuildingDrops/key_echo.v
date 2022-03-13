`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:07:17 01/11/2021 
// Design Name: 
// Module Name:    key_echo 
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
module key_echo(
	input start,//when a new key comes, start=1
	input [7:0]key,
	input rls,//release
	input xpd,//expand
	input clk,
	output SEG_CLK,
	output SEG_CLR,
	output SEG_DT,
	output SEG_EN
);

	wire [31:0] num;
	assign num = {16'd0,3'd0,xpd,3'd0,rls,key};// the higher half of the num is not used
	SEG_DRV display(
	.num(num),
	.start(start),
	.clk(clk),
	.SEG_CLK(SEG_CLK),
	.SEG_CLR(SEG_CLR),
	.SEG_DT(SEG_DT),
	.SEG_EN(SEG_EN)
	);

endmodule
