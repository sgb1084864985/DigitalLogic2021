`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:13 01/08/2021 
// Design Name: 
// Module Name:    clock_10 
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
module clock_10(
	input CP,
	input CTP,
	input CTT,
	input clear,
	output CO,
	output [3:0] Q
);

	wire CR;
	
	My74LS161 m0 (CTP,CTT,1'b1,CP,CR,4'b0000,trash,Q);
	
	assign CR = !(CO)&clear;
	assign CO=(Q[0]&Q[3])&CTT;
endmodule
