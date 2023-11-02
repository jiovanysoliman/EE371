// Top-level module for LandsLand hardware connections to demonstrate Lab 4, task 1 and task 2 using DE1_SoC interfaces.*/
// SW is a 10 bit input
// KEY is a 4 bit input
// HEX5- HEX0 is a 7 bit output.
module DE1_SoC(CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	logic temp1, temp2, Start, Reset, A;

	//// switch between task 1 and task 2. 
	//Assign algo = SW[9];
	//
	//always_comb begin
	//
	//	case(SW[9]) begin
	//	
	//		0: counter counterAlgo ();
	//	
	//		1: binary binaryAlgo ();
	//		
	//	endcase
	//
	//
	//end


//	always_ff (posedge clk); begin
//
//		temp1 <= KEY[3];
//		Start <= temp1;
//		
//		temp2 <= KEY[0];
//		Reset <= temp2;
//		
////	end 
//
//	assign A = SW[7:0];

	//seg7 LocOutMSB (.hex(Loc[4]), .leds(HEX1));
	//seg7 LocOutLSB (.hex(Loc[3:0]), .leds(HEX0));

endmodule 