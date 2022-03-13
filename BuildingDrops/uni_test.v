`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:54 01/11/2021 
// Design Name: 
// Module Name:    uni_test 
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
module uni_test;
	reg a;
	reg b;
	initial begin
		a<=0;
		b<=1;
		#50
		a<=b;
		b<=0;
	end

endmodule
