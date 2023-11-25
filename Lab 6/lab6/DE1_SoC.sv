module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;

	logic reset, clear;
	logic [9:0] x;
	logic [8:0] y;
	logic [0:639] q, q0, q1, q2, q3, qintro, qgameOver;
	logic [7:0] r, g, b;
	logic color;
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
			 

	ROM_640x480_No0_1channel ROM0 (.address(y), .clock(CLOCK_50), .q(q0));
	ROM_640x480_No1_1channel ROM1 (.address(y), .clock(CLOCK_50), .q(q1));
	ROM_640x480_No2_1channel ROM2 (.address(y), .clock(CLOCK_50), .q(q2));
	ROM_640x480_No3_1channel ROM3 (.address(y), .clock(CLOCK_50), .q(q3));
	ROM_640x480_intro_1channel ROMintro (.address(y), .clock(CLOCK_50), .q(qintro));
	ROM_640x480_gameOver_1channel ROMgameOver (.address(y), .clock(CLOCK_50), .q(qgameOver));

	
// enum {intro, zero, one, two, three, gameOver} ps, ns; 
	always_comb begin 
		case(SW[2:0]) // Switches for testing purposes only, will have to change to the last 2 bits of the LFSR.
			3'b000 : begin // rename to intro
				q = qintro;
			end
			3'b001 : begin // rename to zero
				q = q0;
			end
			3'b010 : begin // rename to one
				q = q1;
			end
			3'b011 : begin // rename to two
				q = q2;
			end
			3'b100 : begin // rename to three
				q = q3;
			end
			3'b101 : begin // rename to gameOver
				q = qgameOver;
			end
			default : begin
				q = qintro;
			end
		endcase
	end 
	
	
/////////////// This's closer to the final code //////////////////////////////////////

//	always_comb begin 
//		case(SW[1:0]) // Switches for testing purposes only, will have to change to the last 2 bits of the LFSR.
//			3'b000 : begin // rename to zero
//				q = q0;
//			end
//			3'b001 : begin // rename to one
//				q = q1;
//			end
//			3'b010 : begin // rename to two
//				q = q2;
//			end
//			3'b011 : begin // rename to three
//				q = q3;
//			end
//			default : begin
//				q = qintro;
//			end
//		endcase
//	end 
//	
//	always_comb begin
//	    case(GameOverSignalFromCounter)
//			1'0 : begin // rename to intro
//				q = qintro;
//			end
//			1'b1 : begin // rename to gameOver
//				q = qgameOver;
//			end
//			default : begin
//				q = qintro;
//			end
//	    endcase
//	end
	
	always_ff @(posedge CLOCK_50) begin
	    if (clear) begin // clears the screen without reseting the VGA 
            r <= 8'd0;
        	g <= 8'd0;
            b <= 8'd0;
		end else begin // displays the correct digit/message based on state logic.
            r <= q[x] ? 8'd191 : 8'd255;
        	g <= q[x] ? 8'd64 : 8'd215;
            b <= q[x] ? 8'd191 : 8'd0;
    	end
	end
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign reset = '0;
	assign clear = SW[9];

	
endmodule  // DE1_SoC


`timescale 1 ps / 1 ps
module DE1_SoC_testbench ();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR, SW;
	logic [3:0] KEY;
	logic CLOCK_50;
	logic [7:0] VGA_R, VGA_G, VGA_B;
	logic VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
	
	// instantiate module
	DE1_SoC dut (.*);
	
	// create simulated clock
	parameter T = 20;
	initial begin
		CLOCK_50 <= 0;
		forever #(T/2) CLOCK_50 <= ~CLOCK_50;
	end  // clock initial
	
	// simulated inputs
	initial begin
		
		SW[9] <= 1;
		SW[9] <= 0;
		repeat(100);
		
		$stop();
	end  // inputs initial
	
endmodule  // DE1_SoC_testbench