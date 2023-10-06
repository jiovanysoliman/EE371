// Combines car_detection module and car_counter module to determine occupancy of parking lot.
// May need to change module header with appropriate I/O as necessary.
module parking_lot_occupancy(clk, reset, counter, V_GPIO);
	input  logic clk, reset;
//	input  logic inner_switch, outer_switch; // off-board switches to mimic photosensor inputs
//	output logic inner_led, outer_led; // off-board LEDs to indicate the value of photosensor inputs (1 = on/blocked, 0 = off/unblocked)
	output logic [4:0] counter; // 5-bit counter for HEX display module
	inout  logic V_GPIO;
			 logic enter, exit, outer_wire, inner_wire, outer, inner;
			 
	// LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
	// assign V_GPIO[35] (outer LED) to V_GPIO[24] (outer switch)
	assign V_GPIO[35] = V_GPIO[24];
	
	// assign V_GPIO[33] (inner LED) to V_GPIO[26] (inner switch)
	assign V_GPIO[33] = V_GPIO[26];
	
	//2 DFFs in series for each input (switch) will help eliminate metastability
	D_FF outer_switch_1 (.q(outer_wire), .d(V_GPIO[24]), .clk(clk));
	D_FF outer_switch_2 (.q(outer),      .d(outer_wire), .clk(clk));
	
	D_FF inner_switch_1 (.q(inner_wire), .d(V_GPIO[26]), .clk(clk));
	D_FF inner_switch_2 (.q(inner),      .d(inner_wire), .clk(clk));
	
	// connect car detector, car counter, and HEX display modules
	car_detection detector (.clk(clk), .reset(reset), .outer(outer), .inner(inner), .enter(enter), .exit(exit)); 

endmodule
