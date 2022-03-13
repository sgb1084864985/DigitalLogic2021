`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    15:55:11 01/08/2021 
// Design Name: 
// Module Name:    ps2_keyboard_driver 
//////////////////////////////////////////////////////////////////////////////////

module ps2_keyboard_driver(
    input clk,
    input rst_n,
    input ps2k_clk,
    input ps2k_data,
    output reg done,
	 output reg rls_out,// release
	 output reg xpd_out,// expand
    output reg [7:0] data);

    reg [2:0] signals=3'd0;// ps2k_clk queue
    reg [3:0] byte_pointer;
    reg [9:0] buffer;
    wire starting;
	 
	 // middle variable
	 reg release_pressN;
    reg expand;

	 // push queue
    always@(posedge clk)begin
        signals<={signals[1:0],ps2k_clk};
    end

	 // negative edge of ps2k_clk
    assign starting= signals[2] & ~signals[1];

	 // dealing with data
    always@(posedge clk)begin
        if(~rst_n)begin//reset
            byte_pointer<=4'h0;
				release_pressN<=0;
				expand<=0;
        end
        else begin
            if(starting)begin
                if(byte_pointer==4'd10)begin// a key is just sampled
                    if(!buffer[0] && (^buffer[9:1]) && ps2k_data)begin //even parity
                        if(buffer[8:1]==8'hf0) release_pressN<=1'b1;//release
                        else if(buffer[8:1]==8'he0) expand<=1'b1;//expand
                        else begin// key value
									 rls_out<=release_pressN;
									 xpd_out<=expand;
									 release_pressN<=0;
									 expand<=0;
                            done<=1'b1;
                            data<=buffer[8:1];
                        end
                    end
                    buffer<=4'd0;
						  byte_pointer<=4'h0;
                end

                else begin
                    done<=1'b0;
                    buffer[byte_pointer]<=ps2k_data;
                    byte_pointer<=byte_pointer+4'h1;
                end

            end
        end
    end

endmodule
