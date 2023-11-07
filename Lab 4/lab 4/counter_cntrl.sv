/*
	Module to implmement the control path of task 1.
	External inputs (inputs): clk, reset, s
	Status signals (inputs): A_zero (true if A = 0, false otherwise), got_1 (true if A[0] = 1, false otherwise)
	Control signals (outputs): load_A, r_shift_A, incr_result, clr_result, done
*/

module counter_cntrl(clk, reset, s, A_zero, got_1, load_A, r_shift_A, incr_result, clr_result, done);
	
	// port definitions
	input  logic clk, reset, s, A_zero, got_1;
	output logic load_A, r_shift_A, incr_result, clr_result, done;
	
	// define state names and variables
	enum {S1, S2, S3} ps, ns;
	
	// controller logic with synchronous reset
	always_ff @(posedge clk)
		if(reset)
			ps <= S1;
		else
			ps <= ns;
			
	// next state logic
	always_comb
		case(ps)
			S1:	ns = s ? S2 : S1;
			S2:	ns = A_zero ? S3 : S2;
			S3:	ns = s ? S3 : S1;
	endcase
	
	// output assignments
	assign load_A      = (ps == S1) & ~s;
	assign r_shift_A   = (ps == S2);
	assign incr_result = (ps == S2) & got_1;
	assign clr_result  = (ps == S1);
	assign done			 = (ps == S3);
	
endmodule // counter_cntrl

module counter_cntrl_tb();
	logic clk, reset, s, A_zero, got_1;
	logic load_A, r_shift_A, incr_result, clr_result, done;
	
	counter_cntrl dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		// test all possible routes of ASMD chart
		reset <= 1; s <= 0; A_zero <= 0; got_1 <= 0; 			 @(posedge clk);
		reset <= 0; 											repeat(2) @(posedge clk); // loop into S1 (clr_result and load_A asserted)
						s <= 1;												 @(posedge clk); // from S1 to S2 (r_shift_A asserted)
																				 @(posedge clk); // loop into S2 (r_shift_A asserted)
													got_1 <= 1;				 @(posedge clk); // loop into S2 (incr_result and r_shift_A asserted)
					   s <= 1; A_zero <= 1; got_1 <= 0;	repeat(4) @(posedge clk); // from S2 to S3 (done asserted)
						s <= 0; A_zero <= 0;					repeat(4) @(posedge clk); // from S3 to S1 (clr_result and load_A asserted)
																				 $stop;
						
	end
endmodule 