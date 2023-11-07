// Top-level module for LandsLand hardware connections to demonstrate Lab 4 task 1 and task 2 functionality using DE1_SoC interfaces.*/
// SW is a 10 bit input
// KEY is a 4 bit input
// HEX5- HEX0 is a 7 bit output.
// LEDR is a single bit output. 
module DE1_SoC(CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    // active low
	
	// internal control signals to control the binary data path module
	logic A_zero, got_1, load_A, r_shift_A, incr_result, clr_result, done;
	logic [3:0] result;
	logic Compute_M, Set_LSB, Set_MSB, init, exhaustedRAM, gt, Found, DONE;
	logic [4:0] Loc;
	logic Start, Reset;
	logic [7:0] A;
	logic [3:0] out1, out2;
	logic [6:0] leds1, leds2;
	logic d;
	logic f;
	
	// assign the requested external inputs to the internal control signals 
	assign A = SW[7:0];
	assign Reset = ~KEY[0];
	assign Start = ~KEY[3];
	assign HEX5 = 7'h7F;
	assign HEX4 = 7'h7F;
	assign HEX3 = 7'h7F;
	assign HEX2 = 7'h7F;

	// initalize the counter algorithm FSM and datapath.
	counter_cntrl cc(.clk(CLOCK_50), .reset(Reset), .s(Start), .A_zero, .got_1, .load_A, .r_shift_A, .incr_result, .clr_result, .done);
	counter_datapath cdp (.clk(CLOCK_50), .A, .load_A, .r_shift_A, .incr_result, .clr_result, .A_zero, .got_1, .result);

	// initialize the binary search algorithm FSM and datapath. 
	binaryFSM bc (.CLOCK_50, .Reset, .Start, .exhaustedRAM, .Found, .gt, .Compute_M, .Set_LSB, .Set_MSB, .init);
	binaryDataPath bdp (.CLOCK_50, .A, .Compute_M, .Set_LSB, .Set_MSB, .init, .exhaustedRAM, .gt, .Found, .Loc, .DONE);

	// switch between tasks
	always_comb begin
		case(SW[9])
			0: // counter  
			begin
				out1 = result;
				out2 = 4'b0000;
				d = done;
				f = 0;
			end
			1: // binary search
			begin
				out1 = Loc[3:0];
				out2 = {3'b0, Loc[4]};
				d = DONE;
				f = Found;
			end
			default:
			begin
				out1 = result;
				out2 = 4'b0000;
				d = done;
				f = 0;
			end
		endcase
	end

	// initialize a seven segment display module that outputs either the counter value or address of target value.
	seg7 seg1(.hex(out1), .leds(HEX0));
	seg7 seg2(.hex(out2), .leds(HEX1));

	assign LEDR[9] = d; // indicates done state for either counter or binary
	assign LEDR[0] = f; // off for counter, used for binary to indicate Found

endmodule


//module DE1_SoC_tb();
//
//
//
//endmodule 