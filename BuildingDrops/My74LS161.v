`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:05 12/28/2020 
// Design Name: 
// Module Name:    My74LS161 
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
module My74LS161(
	input CTP,
	input CTT,
	input CR,
	input CP,
	input load,
	input [3:0] P,
	output CO,
	output [3:0] Q
    );
	 
	wire [3:0] D;
	reg [3:0] mid;
	assign CO = (&Q)&CTT;
	assign D = (!load)?P:
				  (CTP&CTT)?(Q+4'b0001):Q;
				  
	assign Q=CR?mid:4'b0000;
	
	initial mid=4'b0000;
	always @(posedge CP)begin
		mid <= D;
	end
	
endmodule
