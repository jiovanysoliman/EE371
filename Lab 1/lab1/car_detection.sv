// Module detects if a car is entering or exiting and asserts the "enter" or "exit" signals for the counter.
// May need to change module header with appropriate I/O as necessary.
module car_detection (clk, reset, outer, inner, enter, exit);
	input  logic outer, inner; // input from off-board switches
	input  logic clk, reset;
	output logic enter, exit;  // outputs connected to off-board LEDs in parking_lot_occupancy module

	// enumerate the possible values for present state (ps), and next state (ns)
	enum {S0, S1, S2, S3, S4, S5, S6, S7} ps, ns; 
	
	// case transition logic
	always_comb begin
	
		case (ps)
		
			S0: begin // initial state
					if(~outer & ~inner) ns = S1;
					else					  ns = ps;
				 end
			
			S1: begin // both unblocked
					if (outer & inner)   	  ns = S0;
					else if (outer & ~inner)  ns = S2;
					else if (~outer & ~inner) ns = ps;
					else 							  ns = S3;
				 end
				
			S2: begin // outer blocked
					if (outer & ~inner) 		  ns = ps;
					else if (~outer & ~inner) ns = S1;
					else if (~outer & inner)  ns = S0;
					else 							  ns = S4;
				 end
				
			S3: begin // inner blocked
					if (~outer & inner)       ns = ps;
					else if (~outer & ~inner) ns = S1;
					else if (outer & inner)   ns = S7;
					else                      ns = S0;
				 end
			
			S4: begin // both blocked (entering)
					if (~outer & ~inner)      ns = S1;
					else if (~outer & inner)  ns = S5;
					else if (outer & ~inner)  ns = S0;
					else							  ns = ps;
				 end
			
			S5: begin // end of enter sequence
					if (~outer & ~inner)      ns = S1;
					else							  ns = S0;
				 end
			
			S6: begin // end of exit sequence
					if (~outer & ~inner)      ns = S1;
					else							  ns = S0;
				 end
			
			S7: begin // both blocked (exiting)
					if (~outer & ~inner)      ns = S1;
					else if (~outer & inner)  ns = S0;
					else if (outer & ~inner)  ns = S6;
					else							  ns = ps;
				 end
			
			default: ns = S0;
		
		endcase
	end
	
	// output logic
	assign enter = (ps == S5);
	assign exit  = (ps == S6);
	
	// next state logic
	always_ff @(posedge clk) begin
		
		if (reset) ps <= S0;
		else       ps <= ns;
	
	end
endmodule // car_detection

module car_detection_tb();
	logic clk, reset, outer, inner, enter, exit;
	
	car_detection dut (.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	// Inputs designed such that each transition between states is made at least once.
	
	initial begin
	
		reset <= 1;												 @(posedge clk);
		reset <= 0; outer <= 0; inner <= 0; repeat(2) @(posedge clk); // S4 --> S0
						            inner <= 1;	repeat(2) @(posedge clk); // start exit sequence, verify same state for multiple cycles
						outer <= 1;          	repeat(2) @(posedge clk); 
										inner <= 0;	repeat(2) @(posedge clk); 
						outer <= 0;					repeat(2) @(posedge clk); 
						outer <= 1;					          @(posedge clk); // start enter sequence
										inner <= 1;				 @(posedge clk); 
						outer <= 0;								 @(posedge clk); 
										inner <= 0;				 @(posedge clk); 
		reset <= 1;                       	          @(posedge clk); // test restart sequence, same state for multiple cycles
		reset <= 0;             inner <= 1; repeat(2) @(posedge clk); 
						outer <= 1;   			   repeat(2) @(posedge clk); 
										inner <= 0; repeat(2) @(posedge clk); 
						outer <= 0;								 @(posedge clk); // test for pedestrian (enter/exit signals unaffected)
										inner <= 1; 			 @(posedge clk); 
										inner <= 0;				 @(posedge clk); 
						outer <= 1;								 @(posedge clk);
						outer <= 0;								 @(posedge clk);
						outer <= 1; inner <= 1;				 @(posedge clk); // back to initial state
						outer <= 0; inner <= 0;				 @(posedge clk); // test breaking out of enter sequence
						outer <= 1;								 @(posedge clk);
										inner <= 1;				 @(posedge clk);
										inner <= 0;	repeat(4) @(posedge clk); // EXIT = 1!!!!
																	 $stop;
	end
endmodule