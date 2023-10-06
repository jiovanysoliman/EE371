// Combines car_detection module and car_counter module to determine occupancy of parking lot.
// May need to change module header with appropriate I/O as necessary.
module parking_lot_occupancy(clk, V_GPIO, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic clk;
//	input  logic inner_switch, outer_switch; // off-board switches to mimic photosensor inputs
//	output logic inner_led, outer_led; // off-board LEDs to indicate the value of photosensor inputs (1 = on/blocked, 0 = off/unblocked)
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // 7-bit counter for HEX display module
	inout  logic [35:0] V_GPIO;
			 logic enter, exit, outer_wire, inner_wire, outer, inner;
			 
	// LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
	// assign V_GPIO[35] (outer LED) to V_GPIO[24] (outer switch)
	assign V_GPIO[32] = V_GPIO[24];
	
	// assign V_GPIO[33] (inner LED) to V_GPIO[26] (inner switch)
	assign V_GPIO[34] = V_GPIO[29];
	
	// assign v_GPIO[35] (reset LED) to V_GPIO[23] (reset switch)
	assign V_GPIO[35] = V_GPIO[23];
	assign reset = V_GPIO[23];
	
	
	//2 DFFs in series for each input (switch) will help eliminate metastability
	D_FF outer_switch_1 (.q(V_GPIO[24]), .d(outer_wire), .clk);
	D_FF outer_switch_2 (.q(outer_wire), .d(outer), .clk);
	
	D_FF inner_switch_1 (.q(V_GPIO[29]), .d(inner_wire), .clk);
	D_FF inner_switch_2 (.q(inner_wire), .d(inner), .clk);
	
	// connect car detector, car counter, and HEX display modules
	car_detection detector (.clk, .reset, .outer, .inner, .enter(enter), .exit(exit)); 
	car_counter counter (.clk, .reset, .incr(enter), .decr(exit), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);

	// output logic [4:0] counter; // 5-bit counter for HEX display module
	// output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	// inout  logic V_GPIO;
	// 		 logic enter, exit, outer_wire, inner_wire, outer, inner;
			 
	// // LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
	// // assign V_GPIO[35] (outer LED) to V_GPIO[28] (outer switch)
	// assign V_GPIO[35] = V_GPIO[28];
	
	// // assign V_GPIO[33] (inner LED) to V_GPIO[30] (inner switch)
	// assign V_GPIO[33] = V_GPIO[30];
	
	// //2 DFFs in series for each input (switch) will help eliminate metastability
	// D_FF outer_switch_1 (.q(outer_wire), .d(V_GPIO[28]), .clk(clk));
	// D_FF outer_switch_2 (.q(outer),      .d(outer_wire), .clk(clk));
	
	// D_FF inner_switch_1 (.q(inner_wire), .d(V_GPIO[30]), .clk(clk));
	// D_FF inner_switch_2 (.q(inner),      .d(inner_wire), .clk(clk));
	
	// // connect car detector, car counter, and HEX display modules
	// // (clk, reset, incr, decr, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	// car_detection detector (.clk(clk), .reset(reset), .outer(outer), .inner(inner), .enter(enter), .exit(exit)); 
	// car_counter   counter  (.clk(clk), .reset(reset), .incr(enter), .decr(exit), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
endmodule
