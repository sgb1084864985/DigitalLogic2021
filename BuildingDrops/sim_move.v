`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:21:49 01/09/2021
// Design Name:   move
// Module Name:   G:/ise_project/BuildingDrops/sim_move.v
// Project Name:  BuildingDrops
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: move
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sim_move;

	// Inputs
	reg clk;
	reg [1:0] scene;
	reg scene_posedge;
	reg [7:0] key;
	reg key_released;
	reg done_posedge;
	reg expand;

	// Outputs
	wire [1:0] people;

	// Instantiate the Unit Under Test (UUT)
	move uut (
		.clk(clk), 
		.scene(scene), 
		.scene_posedge(scene_posedge), 
		.key(key), 
		.key_released(key_released), 
		.done_posedge(done_posedge), 
		.expand(expand), 
		.people(people)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		scene = 0;
		scene_posedge = 0;
		key = 0;
		key_released = 0;
		done_posedge = 0;
		expand = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		scene<=1;
		scene_posedge<=1;
		#40;
		scene_posedge<=0;
		#120;
		expand<=1;
		#40;
		key_released<=1;
		#40;
		key<=8'h6b;
		done_posedge<=1;
		#40;
		done_posedge<=0;
	end
	
	always begin
		clk<=0;
		#20;
		clk<=1;
		#20;
	end
      
endmodule

