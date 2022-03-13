`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    15:56:54 01/08/2021 
// Module Name:    move 
//////////////////////////////////////////////////////////////////////////////////

module move(
	 // input and output:
	 // see the module MyTop for 
	 // further information
    input clk,
    input [1:0] scene, 
	 input scene_posedge,
    input [7:0] key,
    input key_released, 
    input done_posedge,
    input expand,
    output reg [1:0] people
);
	 
	 always@(posedge clk)begin
		if(scene_posedge)people<=2'd0;
		if(done_posedge && scene[0] && key_released && expand)begin// <- or -> key is released
            case(key)
                8'h6b: people<=people+2'd1;//<-
                8'h74: people<=people-2'd1;//->
            endcase            
      end
	 end

endmodule
