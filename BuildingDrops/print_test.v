`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    19:15:15 01/09/2021 
// Module Name:    print_test 
// Description: 
//  The same as print_out;
// However, it is for test cases.
//////////////////////////////////////////////////////////////////////////////////
module print_test(
    input clk,
	 input vga_clk,
	 input resetn,
    input  [11:0] blocks,
    input  [59:0] pos_blocks,
    input  [1:0] people,
    input  [1:0] scene,

    output hs,
    output vs,
    output [3:0] r,g,b,
	 output wire [18:0] addr_bg_start,
	 output wire [11:0] rgb_bg_start,
    output wire [8:0] row,
    output wire [9:0] col,
    output reg [11:0] vga_in

);
    wire [18:0] addr_bg_run;
    wire [18:0] addr_bg_end;
    wire [13:0] addr_peo;
    wire [13:0] addr_blocks[5:0];
    wire [11:0] rgb_bg_run;
    wire [11:0] rgb_bg_end;
    wire [11:0] rgb_peo;
    wire [11:0] rgb_blocks[5:0];
    wire [9:0] paths[3:0];
    wire [9:0] x_peo;
    wire [9:0] x_blocks[5:0];

    wire readn;

    assign paths[0]=10'd0;
    assign paths[1]=10'd160;
    assign paths[2]=10'd320;
    assign paths[3]=10'd480;

    assign x_peo = paths[people];
    assign x_blocks[0]=paths[blocks[1:0]];
    assign x_blocks[1]=paths[blocks[3:2]];
    assign x_blocks[2]=paths[blocks[5:4]];
    assign x_blocks[3]=paths[blocks[7:6]];
    assign x_blocks[4]=paths[blocks[9:8]];
    assign x_blocks[5]=paths[blocks[11:10]];

    VGA m0(.vga_clk(vga_clk),.clrn(resetn),.d_in(vga_in),.row_addr(row),.col_addr(col),.rdn(readn),.r(r),.g(g),.b(b),.hs(hs),.vs(vs));
	 
    peo p0(.a(addr_peo),.spo(rgb_peo));
    my_block b0(.a(addr_blocks[0]),.spo(rgb_blocks[0]));
    my_block b1(.a(addr_blocks[1]),.spo(rgb_blocks[1]));
    my_block b2(.a(addr_blocks[2]),.spo(rgb_blocks[2]));
    my_block b3(.a(addr_blocks[3]),.spo(rgb_blocks[3]));
    my_block b4(.a(addr_blocks[4]),.spo(rgb_blocks[4]));
    my_block b5(.a(addr_blocks[5]),.spo(rgb_blocks[5]));
    bg_start bg1(.addra(addr_bg_start),.douta(rgb_bg_start),.clka(vga_clk));
    bg_run bg2(.addra(addr_bg_run),.douta(rgb_bg_run),.clka(vga_clk));
    bg_end bg3(.addra(addr_bg_end),.douta(rgb_bg_end),.clka(vga_clk));

    assign addr_bg_start = row*9'd640+col;
    assign addr_bg_run = addr_bg_start;
    assign addr_bg_end = addr_bg_start;
    assign addr_peo = (row-9'd400)*9'd640+col-x_peo;
    assign addr_blocks[0] = (row-pos_blocks[9:0])*9'd640+col-x_blocks[0];
    assign addr_blocks[1] = (row-pos_blocks[19:10])*9'd640+col-x_blocks[1];
    assign addr_blocks[2] = (row-pos_blocks[29:20])*9'd640+col-x_blocks[2];
    assign addr_blocks[3] = (row-pos_blocks[39:30])*9'd640+col-x_blocks[3];
    assign addr_blocks[4] = (row-pos_blocks[49:40])*9'd640+col-x_blocks[4];
    assign addr_blocks[5] = (row-pos_blocks[59:50])*9'd640+col-x_blocks[5];


    always@(posedge clk)begin
        if(~readn)begin
            if(scene==2'd0)begin
                vga_in <= rgb_bg_start;
            end
            if(scene==2'd2)begin
                vga_in <= rgb_bg_end;
            end 
            if(scene==2'd1)begin
                vga_in <= rgb_bg_run;
                if(row>=9'd400 && row < 9'd480 && col >= x_peo && col<x_peo+10'd160 && rgb_peo!=12'hfff) vga_in <= rgb_peo;
                if(row>=pos_blocks[9:0] && row<pos_blocks[9:0]+9'd80 && col>=x_blocks[0] && col<x_blocks[0]+10'd160 && rgb_blocks[0]!=12'hfff) vga_in<=rgb_blocks[0];
                if(row>=pos_blocks[19:10] && row<pos_blocks[19:10]+9'd80 && col>=x_blocks[1] && col<x_blocks[1]+10'd160 && rgb_blocks[1]!=12'hfff) vga_in<=rgb_blocks[0];
                if(row>=pos_blocks[29:20] && row<pos_blocks[29:20]+9'd80 && col>=x_blocks[2] && col<x_blocks[2]+10'd160 && rgb_blocks[2]!=12'hfff) vga_in<=rgb_blocks[1];
                if(row>=pos_blocks[39:30] && row<pos_blocks[39:30]+9'd80 && col>=x_blocks[3] && col<x_blocks[3]+10'd160 && rgb_blocks[3]!=12'hfff) vga_in<=rgb_blocks[2];
                if(row>=pos_blocks[49:40] && row<pos_blocks[49:40]+9'd80 && col>=x_blocks[4] && col<x_blocks[4]+10'd160 && rgb_blocks[4]!=12'hfff) vga_in<=rgb_blocks[3];
                if(row>=pos_blocks[59:50] && row<pos_blocks[59:50]+9'd80 && col>=x_blocks[5] && col<x_blocks[5]+10'd160 && rgb_blocks[5]!=12'hfff) vga_in<=rgb_blocks[4];
            end
        end
		  else vga_in<=12'd0;
    end

endmodule 

