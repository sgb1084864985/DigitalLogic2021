`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:18:39 01/09/2021
// Design Name:   print_test
// Module Name:   G:/ise_project/BuildingDrops/sim_test_print.v
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

module sim_test_print;

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
		.b(b)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		vga_clk = 0;
		resetn = 0;
		blocks = 0;
		pos_blocks = 0;
		people = 0;
		scene = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

