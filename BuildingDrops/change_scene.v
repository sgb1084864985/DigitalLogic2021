`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    15:56:09 01/08/2021 
// Module Name:    change_scene 
//////////////////////////////////////////////////////////////////////////////////

module change_scene(
    input clk,
    input hit,//see MyTop Module
	 input resetn,// if resetn=0, scene is determined by init_scene
    input done_posedge,// a key is just done
	 input key_released,
	 input [1:0] init_scene,
    output reg[1:0] scene
);

    always@(posedge clk)begin
		  if(~resetn) scene<=init_scene;
		  else begin
			  if(hit) scene<=2'b10;//if the game is playing, and people is hit, end the game
			  if(done_posedge&&key_released)begin// press any key to change mode
					case(scene)
						2'b00:scene<=2'b01;
						2'b10:scene<=2'b00;
					endcase
			  end
		  end
    end

endmodule
