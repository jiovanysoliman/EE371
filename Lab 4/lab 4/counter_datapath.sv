/*
	External inputs (inputs): clk, A
	Control signals (inputs): load_A, r_shift_A, incr_result, clr_result
	Status signals (outputs): A_zero (true if A = 0, false otherwise), got_1 (true if A[0] = 1, false otherwise)
	External outputs (outputs): result
*/

module counter_datapath(clk, A, load_A, r_shift_A, incr_result, clr_result, A_zero, got_1, result);
	
	// port definitions
	input  logic clk, load_A, r_shift_A, incr_result, clr_result;
	input  logic [7:0] A;
	output logic [3:0] result; // highest value counter can be is 8
	output logic A_zero, got_1;
	
	logic [7:0] a;
	
	// datapath logic
	always_ff @(posedge clk) begin
		if(load_A)
			a <= A; 
			
		if(clr_result)
			result <= 0;
		else if(incr_result)
			result <= result + 1;
		else 
			result <= result;
			
		if(r_shift_A)
			a <= (a >> 1);
	end
			
	assign A_zero = (a == 8'b0);
	assign got_1 = (a[0] == 1'b1);		
	
endmodule // counter_datapath

module counter_datapath_tb();
	logic clk, load_A, r_shift_A, incr_result, clr_result;
	logic [7:0] A;
	logic [3:0] result; // highest value result can be is 8
	logic A_zero, got_1;
	
	counter_datapath dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		load_A <= 1; clr_result <= 1; A = 8'b11100101; r_shift_A <= 0; incr_result <= 0; repeat(2) @(posedge clk); // A = 11100101, A_zero = 0, got_1 = 1, result = 0
												A = 8'b00110111;												repeat(2) @(posedge clk); // A = 00000111					" "
		load_A <= 0; 						A = 8'b00011100;												repeat(2) @(posedge clk); // A = 00000111					" "
						 clr_result <= 0;						  r_shift_A <= 1; incr_result <= 1; repeat(3) @(posedge clk); // A = 00000011, A_zero = 001, got_1 = 111, result=3
																							incr_result <= 0;           @(posedge clk); // result = 3, A = 00000000, A_zero = 1, got_1 = 0
																							incr_result <= 1; repeat(2) @(posedge clk);	
																	  r_shift_A <= 0; incr_result <= 0;	repeat(4) @(posedge clk);
																																 $stop;
	end 
endmodule 