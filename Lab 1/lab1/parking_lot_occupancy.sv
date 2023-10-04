// Combines car_detection module and car_counter module to determine occupancy of parking lot.
// May need to change module header with appropriate I/O as necessary.
module parking_lot_occupancy(clk, reset, inner_switch, outer_switch, inner_led, outer_led, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic inner_switch, outer_switch; // off-board switches to mimic photosensor inputs
	input  logic clk, reset;
	output logic inner_led, outer_led; // off-board LEDs to indicate the value of photosensor inputs (1 = on/blocked, 0 = off/unblocked)
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
			 logic enter, exit;
	
	// connect car detector and car counter modules, have HEX display module separate
	
	car_detection detector (.clk(clk), .reset(reset), .outer(outer_switch), .inner(inner_switch), .enter(enter), .exit(exit)); 
	// car_counter   counter  (....);
endmodule
