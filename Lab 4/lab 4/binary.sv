`timescale 1 ps / 1 ps
module binary(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, LEDR, KEY);
	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	logic [7:0] A;
	assign A = SW[7:0];
	
	logic Reset, Start;
	assign Reset = ~KEY[0];
	assign Start = ~KEY[3];
	
	// 2 ffs for s input
//	logic w1, s;
//	D_FF d1 (.q(w1), .d(Start), .clk(CLOCK_50));
//	D_FF d2 (.q(s), .d(w1), .clk(CLOCK_50));
	
	// internal wires
	logic eR, F, gt, CM, SLSB, SMSB, i;
	logic [4:0] Loc;
	logic DONE;
	
	binaryFSM   cntrl (.CLOCK_50(CLOCK_50), .Reset(Reset), .Start(Start), .exhaustedRAM(eR), .Found(F), .gt(gt), .Compute_M(CM), .Set_LSB(SLSB), .Set_MSB(SMSB), .init(i));
	binaryDataPath dp (.CLOCK_50(CLOCK_50), .A(A), .Compute_M(CM), .Set_LSB(SLSB), .Set_MSB(SMSB), .init(i), .exhaustedRAM(eR), .gt(gt), .Found(F), .Loc(Loc), .DONE(DONE));
	
	// output on HEX1-HEX0 Loc
	seg7 seg1(.hex(Loc[3:0]), .leds(HEX0));
	seg7 seg2(.hex({3'b0, Loc[4]}), .leds(HEX1));

	assign LEDR[0] = F;
	assign LEDR[9] = DONE;
	
endmodule

`timescale 1 ps / 1 ps
module binary_tb();
	logic CLOCK_50;	// 50MHz clock
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [9:0] LEDR;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	binary dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		// reset		 start	     A = 4
		KEY[0] <= 0; KEY[3] <= 1; SW[7] <= 0; SW[6] <=0;  SW[5] <= 0; SW[4] <= 0; SW[3] <= 0; SW[2] <= 0; SW[1] <= 1; SW[0] <= 1;          @(posedge CLOCK_50);
		KEY[0] <= 1; 																																				 repeat(4) @(posedge CLOCK_50);
						 KEY[3] <= 0;																																 repeat(50)@(posedge CLOCK_50);
																																													  $stop;
		
	end

endmodule