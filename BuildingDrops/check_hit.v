`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date:    15:46:52 01/08/2021 
// Module Name:    check_hit 
// Description: 
//		check if the any block hits the people
//////////////////////////////////////////////////////////////////////////////////module check_hit(
module check_hit(
    input [1:0]scene,
    input [59:0] pos_blocks,
    input [11:0] blocks,
    input [1:0] people,
    output wire hit
);

	 // hit: in a specific range of height, and have the same horizontal with the people
    assign hit =    ~scene[0]?1'b0:
                    (pos_blocks[9:0]>10'd380 && pos_blocks[9:0]<10'd480) && (blocks[11:10] == people) ? 1'b1:
                    (pos_blocks[19:10]>10'd380&& pos_blocks[19:10]<10'd480) && (blocks[9:8] == people) ? 1'b1:
                    (pos_blocks[29:20]>10'd380&& pos_blocks[29:20]<10'd480) && (blocks[7:6] == people) ? 1'b1:
                    (pos_blocks[39:30]>10'd380&& pos_blocks[39:30]<10'd480) && (blocks[5:4] == people) ? 1'b1:
                    (pos_blocks[49:40]>10'd380&& pos_blocks[49:40]<10'd480) && (blocks[3:2] == people) ? 1'b1:
                    (pos_blocks[59:50]>10'd380&& pos_blocks[59:50]<10'd480) && (blocks[1:0] == people) ? 1'b1:1'b0;

endmodule
