`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:13:45 01/16/2021
// Design Name:   getscore
// Module Name:   G:/ise_project/BuildingDrops/sim_get_score.v
// Project Name:  BuildingDrops
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: getscore
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sim_get_score;

	// Inputs
	reg [1:0] scene;
	reg work_clk;

	// Outputs
	wire [15:0] score;

	// Instantiate the Unit Under Test (UUT)
	getscore uut (
		.scene(scene), 
		.work_clk(work_clk), 
		.score(score)
	);

	initial begin
		// Initialize Inputs
		scene = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		scene=1;
		#500;
		scene=2;
		#200;
		scene=0;
	end
	
	always begin
		work_clk<=1'b0;
		#20;
		work_clk<=1'b1;
		#20;
	end
      
endmodule

