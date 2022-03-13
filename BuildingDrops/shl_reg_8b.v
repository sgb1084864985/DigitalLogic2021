`timescale 1ns / 1ps

module shl_reg_8b(
	input wire clk, S_L, s_in,
	input wire [7:0] p_in,
	output wire [7:0] Q);
	
	wire [7:0] D;

	assign D = S_L?p_in:{Q[6:0],s_in};

	FD #(.INIT(1'b0)) d0(.C(clk),.D(D[0]),.Q(Q[0]));
	FD #(.INIT(1'b0)) d1(.C(clk),.D(D[1]),.Q(Q[1]));
	FD #(.INIT(1'b0)) d2(.C(clk),.D(D[2]),.Q(Q[2]));
	FD #(.INIT(1'b0)) d3(.C(clk),.D(D[3]),.Q(Q[3]));
	FD #(.INIT(1'b0)) d4(.C(clk),.D(D[4]),.Q(Q[4]));
	FD #(.INIT(1'b0)) d5(.C(clk),.D(D[5]),.Q(Q[5]));
	FD #(.INIT(1'b0)) d6(.C(clk),.D(D[6]),.Q(Q[6]));
	FD #(.INIT(1'b0)) d7(.C(clk),.D(D[7]),.Q(Q[7]));
	
endmodule
