// Combines car_detection module and car_counter module to determine occupancy of parking lot.
// May need to change module header with appropriate I/O as necessary.
module parking_lot_occupancy(clk, reset, inner, outer, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic clk, reset, inner, outer;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // 7-bit counter for HEX display module
	logic enter, exit;
			 

	// connect car detector, car counter, and HEX display modules
	car_detection detector (.clk(clk), .reset(reset), .outer(outer), .inner(inner), .enter(enter), .exit(exit)); 
	car_counter counter    (.clk(clk), .reset(reset), .incr(enter), .decr(exit), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));

endmodule
