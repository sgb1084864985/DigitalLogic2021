`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date:    15:52:09 01/08/2021 
// Module Name:    get_score 
// Description: 
// Dependencies: 
// 	clock_10 (old work)
// Revision: 
//////////////////////////////////////////////////////////////////////////////////

module getscore(
    input [1:0]scene,
	 input work_clk,// the counting clk
    output [15:0] score
);

    wire [3:0] C;
	 wire clear;
	 
	 assign clear=|scene;// if the scene is 0, clear=0, making the score be 0

    clock_10 m3(work_clk,C[2],C[2],clear,C[3],score[15:12]);
    clock_10 m2(work_clk,C[1],C[1],clear,C[2],score[11:8]);
    clock_10 m1(work_clk,C[0],C[0],clear,C[1],score[7:4]);
    clock_10 m0(work_clk,scene[0],scene[0],clear,C[0],score[3:0]);

endmodule
