`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:16 01/08/2021 
// Design Name: 
// Module Name:    rand_generator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rand_generator(
    input clk,
    output wire rand
);
    parameter seed = 16'b0110_1000_1111_0011;
    reg [16:0] num;
    reg shift_out;
    wire feedback;

    initial num<=seed;
    initial shift_out<=1'b0;

    assign feedback= ((num[0]^num[2])^num[3])^num[5];
    assign rand=shift_out;

    always@(posedge clk)begin
        num<={feedback,num[15:1]};
        shift_out<=num[0];
    end

endmodule
