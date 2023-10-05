// Module detects if a car is entering or exiting and asserts the "enter" or "exit" signals for the counter.
// May need to change module header with appropriate I/O as necessary.
module car_detection (clk, reset, outer, inner, enter, exit);
	input  logic outer, inner; // input from off-board switches
	input  logic clk, reset;
	output logic enter, exit;  // outputs connected to off-board LEDs in parking_lot_occupancy module

	// enumerate the possible values for present state (ps), and next state (ns)
	// S0: both unblocked
	// S1: only inner blocked
	// S2: both blocked
	// s3: only outer blocked
	// S4: restart sequence
	enum {S0, S1, S2, S3, S4} ps, ns; 
	
	// case transition logic
	always_comb begin
	
		case (ps):
		
			S0: if (~outer && inner) ns = S1;
				else if (outer && ~inner) ns = S3;
				else if (outer && inner) ns = S4;
				else ns = ps;
			
			S1: if (outer && inner) ns = S2;
				else if (outer && ~inner) ns = S4;
				else if (~outer && ~inner) ns = S1;
				else ns = ps;
				
			S2: if (outer && ~inner) ns = S3;
				else if (~outer && ~inner) ns = S4;
				else if (~outer && inner) ns = S1;
				else ns = ps;
				
			S3: if (~outer && inner) ns = S4;
				else if (~outer && ~inner) ns = S0;
				else if (outer && inner) ns = S2;
				else ns = ps;
			
			
			S4: if (~outer && ~inner) ns = S0;
				else ns = ps;
		
		endcase
	end
	
	// output logic
	//assign enter =
	//assign exit =
	
	// next state logic
	always_ff @(posedge clk) begin
		
		if (reset) ps <= S4;
		else ps <= ns;
	
	end
endmodule // car_detection