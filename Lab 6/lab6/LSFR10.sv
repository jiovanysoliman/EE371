/*
This module is a modified verson of the LFSR10 module. It divides the 10-bit
pseudorandom number by 4 and outputs the remainder, resulting in a pseudorandom
generation of numbers from 0 to 3 (inclusive). 
Inputs
	clk   - clock
	reset - restarts the LFSR
Outputs 
	mod   - pseudorandom number from 0 to 3 (inclusive)
*/
module LSFR10(mod, clk, reset);
	output logic [1:0] mod; // range of 0 to 3
	input  logic clk, reset;

	logic xnor_out;
	logic [9:0] Q; // 10 bit
	assign xnor_out = (Q[9] ~^ Q[6]);
	
	always_ff @(posedge clk) begin
		if(reset)
			Q <= 10'b0000000000;
			
		else
			Q <= {Q[8:0], xnor_out};
	end
	
	logic [4:0] a = 5'b11111; // arbitrary value used for initial division to help avoid too many repetitions
	logic [3:0] b = 4'b1011;  // arbitrary value used for second division to help avoid too many repetitions
	logic [2:0] c = 3'b100;   // for final mod division
	logic [3:0] temp1, temp2;
	
//	assign temp1 = Q % a;
	assign temp2 = Q % b;
	assign mod = temp2 % c;

endmodule

module LSFR10_testbench();
	logic clk, reset;
	logic [1:0] mod;
	
	LSFR10 dut (.*); // connect all ports by name since they match
	
	// Set up a simulated clock.
   parameter CLOCK_PERIOD=100;
   initial begin
       clk <= 0;
       forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
   end
	 
   // Set up the inputs to the design. Each line is a clock cycle.
   initial begin	
	
		 reset <= 1; 				  @(posedge clk);
		 reset <= 0; repeat(1500) @(posedge clk);
												     $stop;
    end
endmodule 











			 //logic in;
	
//	D_FF d1 (.q(Q[1]), .d(in),   .clk(clk)); 
//	D_FF d2 (.q(Q[2]), .d(Q[1]), .clk(clk));
//	D_FF d3 (.q(Q[3]), .d(Q[2]), .clk(clk));
//	D_FF d4 (.q(Q[4]), .d(Q[3]), .clk(clk));
//	D_FF d5 (.q(Q[5]), .d(Q[4]), .clk(clk));
//	D_FF d6 (.q(Q[6]), .d(Q[5]), .clk(clk));
//	D_FF d7 (.q(Q[7]), .d(Q[6]), .clk(clk));
//	D_FF d8 (.q(Q[8]), .d(Q[7]), .clk(clk));
//	D_FF d9 (.q(Q[9]), .d(Q[8]), .clk(clk));
//	D_FF d10(.q(Q[10]),.d(Q[9]), .clk(clk));
//	
//	always_ff @(posedge clk) begin
//		if(reset)
//			in <= 0;
//		else
//			in <= ~(Q[10] ^ Q[7]);
	
//	// some internal wires for connecting the DFFs and the XNOR gate
//	logic q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, in; // in = output of XNOR gate
//	
//	D_FF d1 (.q(q1), .d(in), .clk(clk)); 
//	D_FF d2 (.q(q2), .d(q1), .clk(clk));
//	D_FF d3 (.q(q3), .d(q2), .clk(clk));
//	D_FF d4 (.q(q4), .d(q3), .clk(clk));
//	D_FF d5 (.q(q5), .d(q4), .clk(clk));
//	D_FF d6 (.q(q6), .d(q5), .clk(clk));
//	D_FF d7 (.q(q7), .d(q6), .clk(clk));
//	D_FF d8 (.q(q8), .d(q7), .clk(clk));
//	D_FF d9 (.q(q9), .d(q8), .clk(clk));
//	D_FF d10(.q(q10),.d(q9), .clk(clk));
//	
//	xnor gate(in, q10, q7);
//	
//	// concatenate individual wires into the 10-bit output
//   assign out = { q1, q2, q3, q4, q5, q6, q7, q8, q9, q10 };
//	
//	always_ff @(posedge clk) begin
//		if(reset)
//			out <= 10'b0000000000;
//		else
//			out <= { q1, q2, q3, q4, q5, q6, q7, q8, q9, q10 };
//	end
//endmodule