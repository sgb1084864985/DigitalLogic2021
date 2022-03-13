`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Zhu LiZhen
// 
// Create Date:    15:43:35 01/08/2021 
// Module Name:    MyTop 
// Description: 
//		The Top Module
// Dependencies: 
//		clkdiv
//		check_hit
//		control_blocks
// 	getscore
//		change_scene
//		move
//		print_out
// 	DispNum
//		ps2_keyboard_driver
//		key_echo
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MyTop(
    input clk,
	 input clear_n,// if clear_n=0, the keyboard and scene changes will be banned. Instead, you can debug the game with input "init_scene"
	 input vga_rstn, // if vga_rstn=0, the screen won't be active
	 input [1:0]init_scene,// When debuging, we can choose what scene to be showed by change init_scene;
    input ps2_clk, // the clock of ps2 keyboard
    input ps2_data,// the data of ps2 keyboard when the ps2_clk are in negative edge
	 
	 output reg key_changed, // Whenever any key is released, the key_changed will change its value, which can be seen in a led
   
	 // show the score
	 output [7:0] SEGMENT,
    output [3:0] AN,

	 // the output to vga
    output hs,
    output vs,
    output [3:0] r,b,g,
	 
	 // the output to 8 bits 7-segment digital tube, which will show the key you pressed in ps2 code
	 output SEG_CLK,
	 output SEG_CLR,
	 output SEG_DT,
	 output SEG_EN
);
    wire hit; // when a people is hit, hit = 1
    wire [11:0] blocks; // the horizontal coordinates of the blocks
    wire [59:0] pos_blocks; // the vertical coordinate of the blocks
    wire [1:0] people;  // the horizontal coordinate of the people
    wire [1:0] scene;   // the scene of the game, which is, tell if it is in a state of starting(0), running(1) or ending(2).
    wire [31:0] div_clk; 
    wire [15:0] score;
    wire done;  // when a key data is tranferred out of the module ps2_key_board, done=1;
	 wire done_posedge; // the posedge of the done
    wire [7:0] key; // the ps2 code of the key of the keyboard
    wire key_released; // if the key is released or pressed
    wire expand_key; // if the key is the expand key
	 
	 reg [23:0] key_queue;
	 reg [2:0] rls_queue;
	 reg [2:0] xpd_queue;
	 
	 reg [2:0] done_queue;
	 
	 reg [2:0] scene_queue=3'd0;// the queue of scene[0], which means the running of the game
	 wire scene_posedge;// the posedge of scene[0],which means the runing of the game
	 
	 assign done_posedge=~done_queue[2]&done_queue[1];
	 assign scene_posedge=~scene_queue[2]&scene_queue[1];
	 
	 // shift the queue
	 always@(posedge clk)begin
		 if(clear_n)begin
			done_queue<={done_queue[1:0],done};
			key_queue<={key_queue[15:0],key};
			rls_queue<={rls_queue[1:0],key_released};
			xpd_queue<={xpd_queue[1:0],expand_key};
			
			scene_queue<={scene_queue[1:0],scene[0]};
		 end
		 else begin
			done_queue<=3'b0;
			scene_queue<=3'b0;
		 end
	 end
	 
	 // process key_changed
	 always@(posedge key_released)begin
		if(~clear_n) key_changed<=0;
		else key_changed<=~key_changed;
	 end
	 
	 // Modules
	 // see the comments in each module file.
    clkdiv c0(clk,1'b0,div_clk);
	 
    check_hit m0(scene,pos_blocks,blocks,people,hit);
	 
    control_blocks m1(clk,div_clk[18],div_clk[24],scene,pos_blocks,blocks);
	 
    getscore m2(scene,div_clk[25],score);
	 
    change_scene m3(clk,hit,clear_n,done_posedge,rls_queue[1],init_scene,scene);
	 
    move m4(clk,scene,scene_posedge,key_queue[15:8],rls_queue[1],done_posedge,xpd_queue[1],people);
	 
    print_out m5(clk,div_clk[1],vga_rstn,blocks,pos_blocks,people,scene,hs,vs,r,g,b);
	 
    DispNum m6(clk,score,1'b0,AN,SEGMENT);
	 
    ps2_keyboard_driver m7(clk,1'b1,ps2_clk,ps2_data,done,key_released,expand_key,key);
	 
	 key_echo m8(done_posedge,key_queue[15:8],rls_queue[1],xpd_queue[1],div_clk[5],SEG_CLK,SEG_CLR,SEG_DT,SEG_EN);

endmodule
