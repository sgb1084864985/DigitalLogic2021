`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:22:31 01/09/2021
// Design Name:   print_test
// Module Name:   G:/ise_project/BuildingDrops/sim_print_test.v
// Project Name:  BuildingDrops
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: print_test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sim_print_test;

	// Inputs
	reg clk;
	reg vga_clk;
	reg resetn;
	reg [11:0] blocks;
	reg [59:0] pos_blocks;
	reg [1:0] people;
	reg [1:0] scene;

	// Outputs
	wire hs;
	wire vs;
	wire [3:0] r;
	wire [3:0] g;
	wire [3:0] b;
	wire [18:0] addr_bg_start;
	wire [11:0] rgb_bg_start;
	wire [8:0] row;
	wire [9:0] col;
	wire [11:0] vga_in;

	// Instantiate the Unit Under Test (UUT)
	print_test uut (
		.clk(clk), 
		.vga_clk(vga_clk), 
		.resetn(resetn), 
		.blocks(blocks), 
		.pos_blocks(pos_blocks), 
		.people(people), 
		.scene(scene), 
		.hs(hs), 
		.vs(vs), 
		.r(r), 
		.g(g), 
		.b(b), 
		.addr_bg_start(addr_bg_start), 
		.rgb_bg_start(rgb_bg_start), 
		.row(row), 
		.col(col), 
		.vga_in(vga_in)
	);

	initial begin
		// Initialize Inputs
		resetn = 0;
		blocks = 0;
		pos_blocks = 0;
		people = 0;
		scene = 0;

		// Wait 100 ns for global reset to finish
		#100;
      resetn=1;
		// Add stimulus here

	end
	always begin
		clk<=0;
		vga_clk<=0;
		#20;
		clk<=1;
		#20;
		clk<=0;
		vga_clk<=1;
		#20;
		clk<=1;
      #20;
	end
      
endmodule

