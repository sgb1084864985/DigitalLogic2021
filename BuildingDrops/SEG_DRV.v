`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:39 12/24/2020 
// Design Name: 
// Module Name:    SEG_DRV 
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
module SEG_DRV(
	input [31:0] num,
	input start,
	input clk,
	output SEG_CLK,
	output SEG_CLR,
	output SEG_DT,
	output SEG_EN
);

	wire finish;
	wire load;
	wire loadn;
	wire din,qin;
	wire dout,qout;
	wire [63:0]Q;

   wire [63:0] segments;
	
	MyMCzlz s7(num[31:28],segments[63:56]);
	MyMCzlz s6(num[27:24],segments[55:48]);
	MyMCzlz s5(num[23:20],segments[47:40]);
	MyMCzlz s4(num[19:16],segments[39:32]);
	MyMCzlz s3(num[15:12],segments[31:24]);
	MyMCzlz s2(num[11:8],segments[23:16]);
	MyMCzlz s1(num[7:4],segments[15:8]);
	MyMCzlz s0(num[3:0],segments[7:0]);

	shl_reg_8b m7(clk,load,Q[55],segments[63:56],Q[63:56]);
	shl_reg_8b m6(clk,load,Q[47],segments[55:48],Q[55:48]);
	shl_reg_8b m5(clk,load,Q[39],segments[47:40],Q[47:40]);
	shl_reg_8b m4(clk,load,Q[31],segments[39:32],Q[39:32]);
	shl_reg_8b m3(clk,load,Q[23],segments[31:24],Q[31:24]);
	shl_reg_8b m2(clk,load,Q[15],segments[23:16],Q[23:16]);
	shl_reg_8b m1(clk,load,Q[7],segments[15:8],Q[15:8]);
	shl_reg_8b m0(clk,load,qin,segments[7:0],Q[7:0]);

	assign dout= load?1'b1:Q[63];
	assign din = load?1'b0:1'b1;
	
	FD q(.C(clk),.D(din),.Q(qin));
	FD q1(.C(clk),.D(dout),.Q(qout));

	assign SEG_CLK=finish?1'b0:clk;
	assign SEG_DT =qout;
	assign SEG_CLR=1'b1;
	assign SEG_EN=1'b1;

	assign finish=
	(qin
	&(&Q[63:56])
	&(&Q[55:48])
	&(&Q[47:40])
	&(&Q[39:32])
	)
	&(
	(&Q[31:24])&
	(&Q[23:16])&
	(&Q[15:8]) &
	(&Q[7:0])
	);
	
	assign load=!(loadn|!finish);
	assign loadn=!(load|(start&finish));

endmodule