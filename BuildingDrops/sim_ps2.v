`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:33:09 01/09/2021
// Design Name:   ps2_keyboard_driver
// Module Name:   G:/ise_project/BuildingDrops/sim_ps2.v
// Project Name:  BuildingDrops
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ps2_keyboard_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sim_ps2;

	// Inputs
	reg clk;
	reg rst_n;
	reg ps2k_clk;
	reg ps2k_data;

	// Outputs
	wire rls_out;
	wire done;
	wire xpd_out;
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	ps2_keyboard_driver uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.ps2k_clk(ps2k_clk), 
		.ps2k_data(ps2k_data), 
		.rls_out(rls_out), 
		.done(done), 
		.xpd_out(xpd_out), 
		.data(data)
	);
	reg [10:0] rls;
	reg [10:0] A;
	integer cnt;
	initial begin
		// Initialize Inputs
		rst_n = 0;
		ps2k_clk = 0;
		ps2k_data = 0;
		rls={1'b1,1'b1,8'hf0,1'b0};
		A={1'b1,1'b0,8'h1c,1'b0};
		cnt=0;
		// Wait 100 ns for global reset to finish
		#100;
		rst_n<=1;
		#20;
      for(cnt=0;cnt<11;cnt=cnt+1)begin
			#80;
			ps2k_clk<=1;
			ps2k_data<=rls[cnt];
			#80;
			ps2k_clk<=0;
		end
		
		for(cnt=0;cnt<11;cnt=cnt+1)begin
			#80;
			ps2k_clk<=1;
			ps2k_data<=A[cnt];
			#80;
			ps2k_clk<=0;
		end
	end
	
	always begin
		clk<=0;
		#10;
		clk<=1;
		#10;
	end
endmodule

