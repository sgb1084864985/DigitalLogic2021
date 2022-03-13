`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    15:48:06 01/08/2021 
// Module Name:    control_blocks 
// Description: 
//  	control the failing and regenerate of the blocks
// Dependencies: 
// 	rand_generator
//////////////////////////////////////////////////////////////////////////////////
module control_blocks(
    input wire clk,
    input wire clk_mov, // the move rate of the blocks
    input wire clk_count, // the waiting rates of the regeneration of the blocks
    input wire [1:0]scene, 
    output reg [59:0] pos_blocks,
    output reg [11:0] blocks
);
    wire [14:0] rand;// random bits
    reg [17:0] waits;// determing the waiting time of the regeneration of the blocks
    reg [23:0] wait_counts; // according to the waits, tell the rest counts

	 // random bits with different initial parameters
    rand_generator #(16'h4FD1) a2(clk_mov,rand[0]);
    rand_generator #(16'h0D5A) a3(clk_mov,rand[1]);
    rand_generator #(16'h4420) a4(clk_mov,rand[2]);
    rand_generator #(16'h6367) a5(clk_mov,rand[3]);
    rand_generator #(16'h03EC) a6(clk_mov,rand[4]);
    rand_generator #(16'h3D40) a7(clk_mov,rand[5]);
    rand_generator #(16'h596F) a8(clk_mov,rand[6]);
    rand_generator #(16'hC301) a9(clk_mov,rand[7]);
    rand_generator #(16'h35A7) a10(clk_mov,rand[8]);
    rand_generator #(16'h83E9) a11(clk_mov,rand[9]);
    rand_generator #(16'hA701) a12(clk_mov,rand[10]);
    rand_generator #(16'h1384) a13(clk_mov,rand[11]);
    rand_generator #(16'h4686) a14(clk_mov,rand[12]);
    rand_generator #(16'h1F14) a15(clk_mov,rand[13]);
    rand_generator #(16'h3D05) a16(clk_mov,rand[14]);

	 // process the waitint time for the regeneration of each block
    always@(posedge clk_count)begin
	 
        case (wait_counts[3:0])
            4'd8: // assign the waits to wait_counts, which belongs [0,7]
						// 4'd8 is a special state
                if(pos_blocks[9:0]==10'd482) wait_counts[3:0]<={1'b0,waits[2:0]};
            4'd0: wait_counts[3:0]<=4'd8;// counting done
            default: wait_counts[3:0]<=wait_counts[3:0]-4'd1;
        endcase
		  
        case (wait_counts[7:4])
            4'd8:
                if(pos_blocks[19:10]==10'd482) wait_counts[7:4]<={1'b0,waits[5:3]};
            4'd0: wait_counts[7:4]<=4'd8;
            default: wait_counts[7:4]<=wait_counts[7:4]-4'd1;
        endcase
		  
        case (wait_counts[11:8])
            4'd8:
                if(pos_blocks[29:20]==10'd482) wait_counts[11:8]<={1'b0,waits[8:6]};
            4'd0: wait_counts[11:8]<=4'd8;
            default: wait_counts[11:8]<=wait_counts[11:8]-4'd1;
        endcase
		  
        case (wait_counts[15:12])
            4'd8:
                if(pos_blocks[39:30]==10'd482) wait_counts[15:12]<={1'b0,waits[11:9]};
            4'd0: wait_counts[15:12]<=4'd8;
            default: wait_counts[15:12]<=wait_counts[15:12]-4'd1;
        endcase
		  
        case (wait_counts[19:16])
            4'd8:
                if(pos_blocks[49:40]==10'd482) wait_counts[19:16]<={1'b0,waits[14:12]};
            4'd0: wait_counts[19:16]<=4'd8;
            default: wait_counts[19:16]<=wait_counts[19:16]-4'd1;
        endcase
		  
        case (wait_counts[23:20])
            4'd8:
                if(pos_blocks[59:50]==10'd482) wait_counts[23:20]<={1'b0,waits[17:15]};
            4'd0: wait_counts[23:20]<=4'd8;
            default: wait_counts[23:20]<=wait_counts[23:20]-4'd1;
        endcase
    end

	 // deal with the falling of the blocks
    always@(posedge clk_mov)begin
        if(scene[0])begin//if the game is playing
            case (pos_blocks[9:0])
                10'd410: begin // landing, generate the waiting time for next falling
                    pos_blocks[9:0]<=10'd482;
                    waits[2:0]<=rand[14:12];
						  end
                10'd482: // waiting for regenerating
                    if(wait_counts[3:0]==4'd0) pos_blocks<=10'd900;
                10'd900: begin // change the horizontal coordinate
                    blocks[1:0]<=rand[1:0];
                    pos_blocks[9:0]<=10'd911;
						  end
                default: pos_blocks[9:0]<=pos_blocks[9:0]+1'b1; // falling
            endcase
				
				// the following is the same as the case above, but is for diffrent blocks
            case (pos_blocks[19:10])
                10'd410: begin
                    pos_blocks[19:10]<=10'd482;
                    waits[5:3]<=rand[11:9];
						  end
                10'd482:
                    if(wait_counts[7:4]==4'd0) pos_blocks<=10'd900;
                10'd900: begin
                    blocks[3:2]<=rand[3:2];
                    pos_blocks[19:10]<=10'd905;
						  end
                default: pos_blocks[19:10]<=pos_blocks[19:10]+1'b1;
            endcase

            case (pos_blocks[29:20])
                10'd410: begin
                    pos_blocks[29:20]<=10'd482;
                    waits[8:6]<=rand[8:6];
						  end
                10'd482:
                    if(wait_counts[11:8]==4'd0) pos_blocks<=10'd900;
                10'd900: begin
                    blocks[5:4]<=rand[5:4];
                    pos_blocks[29:20]<=10'd932;
						  end
                default: pos_blocks[29:20]<=pos_blocks[29:20]+1'b1;
            endcase

            case (pos_blocks[39:30])
                10'd410: begin
                    pos_blocks[39:30]<=10'd482;
                    waits[11:9]<=rand[5:3];
						  end
                10'd482:
                    if(wait_counts[15:12]==4'd0) pos_blocks<=10'd900;
                10'd900: begin
                    blocks[7:6]<=rand[7:6];
                    pos_blocks[39:30]<=10'd923;
						  end
                default: pos_blocks[39:30]<=pos_blocks[39:30]+1'b1;
            endcase

            case (pos_blocks[49:40])
                10'd410: begin
                    pos_blocks[49:40]<=10'd482;
                    waits[14:12]<=rand[2:0];
						  end
                10'd482:
                    if(wait_counts[19:16]==4'd0) pos_blocks<=10'd900;
                10'd900: begin
                    blocks[9:8]<=rand[9:8];
                    pos_blocks[49:40]<=10'd915;
						  end
                default: 
					     pos_blocks[49:40]<=pos_blocks[49:40]+1'b1;
            endcase

            case (pos_blocks[59:50])
                10'd410: begin
                    pos_blocks[59:50]<=10'd482;
                    waits[17:15]<={rand[13],rand[0],rand[4]};
						  end
                10'd482:
                    if(wait_counts[23:20]==4'd0) pos_blocks<=10'd900;
                10'd900: begin
                    blocks[11:10]<=rand[11:10];
                    pos_blocks[59:50]<=10'd940;
						  end
                default: 
						  pos_blocks[59:50]<=pos_blocks[59:50]+1'b1;
            endcase

        end
        else begin// not playing, go to landing state
            waits<=18'd0;
            pos_blocks[9:0]   <= 10'd481;
            pos_blocks[19:10] <= 10'd481;
            pos_blocks[29:20] <= 10'd481;
            pos_blocks[39:30] <= 10'd481;
            pos_blocks[49:40] <= 10'd481;
            pos_blocks[59:50] <= 10'd481;    
        end

    end

endmodule
