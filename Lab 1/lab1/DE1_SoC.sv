/* Top-level module for LandsLand hardware connections to implement the parking lot system.*/
module DE1_SoC (CLOCK_50, V_GPIO, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input logic CLOCK_50;	// 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	inout logic [35:0] V_GPIO;	// expansion header 0 (LabsLand board)
	
	// LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
 	// assign V_GPIO[32] (outer LED) to V_GPIO[24] (outer switch)
 	assign V_GPIO[32] = V_GPIO[24];
	
 	// assign V_GPIO[34] (inner LED) to V_GPIO[29] (inner switch)
 	assign V_GPIO[34] = V_GPIO[29];
	
 	// assign v_GPIO[35] (reset LED) to V_GPIO[23] (reset switch)
 	assign V_GPIO[35] = V_GPIO[23];
	
	// make an instance of the module parking_lot_occupancy that contains 2 modules, car_detection, and car_counter.
	parking_lot_occupancy parking (.clk(CLOCK_50), .reset(V_GPIO[23]), .inner(V_GPIO[29]), .outer(V_GPIO[24]), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));

endmodule  // DE1_SoC



/* Test bench for the GPIO example module */
module DE1_SoC_tb ();

	// inout pins must be connected to a wire type
	wire [35:0] V_GPIO;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic clk;
	
	// additional logic required to simulate inout pins
	logic [35:0] V_GPIO_in;
	logic [35:0] V_GPIO_dir; // 1 = input, 0 = output
	
	// set up tristate buffers for inout pins
	genvar i;
	generate
		for (i = 0; i < 36; i++) begin : gpio
			assign V_GPIO[i] = V_GPIO_dir[i] ? V_GPIO_in[i] : 1'bZ;
		end
	endgenerate
	
	// begin simulation
	//simulate clock signal
	initial begin
	parameter CLOCK_PERIOD = 10;
	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
	end
	
	//initialize an instance of the device under test (dut)
	DE1_SoC dut (.CLOCK_50(clk), .V_GPIO, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
	
	initial begin
	// you only need to set the pin directions once
	V_GPIO_dir[23] = 1'b1;
	V_GPIO_dir[24] = 1'b1;
	V_GPIO_dir[29] = 1'b1;
	
	V_GPIO_dir[32] = 1'b0;
	V_GPIO_dir[34] = 1'b0;
	V_GPIO_dir[35] = 1'b0;
	
	// manipulate the V_GPIO input bits indirectly through V_GPIO_in
	// activate reset switch once.
	V_GPIO_in[23] = 1'b1;
	V_GPIO_in[23] = 1'b0;
	
	// car going in sequence. 
	V_GPIO_in[24] = 1'b1; #10;
	V_GPIO_in[29] = 1'b1; #10;
	V_GPIO_in[24] = 1'b0; #10;
	V_GPIO_in[29] = 1'b0; #10;
	
	// activate reset switch once.
	V_GPIO_in[23] = 1'b1; #10;
	V_GPIO_in[23] = 1'b0; #10;
	
	// car going in sequence. repeats 16 times. 
	for (int i = 0; i <= 16; i++) begin: carsIn
		V_GPIO_in[24] = 1'b1; #10;
		V_GPIO_in[29] = 1'b1; #10;
		V_GPIO_in[24] = 1'b0; #10;
		V_GPIO_in[29] = 1'b0; #10;
	end
	
	// car going out in sequence. repeats 16 times.
	for (int i = 0; i <= 16; i++) begin: carsOut
		V_GPIO_in[29] = 1'b1; #10;
		V_GPIO_in[24] = 1'b1; #10;
		V_GPIO_in[29] = 1'b0; #10;
		V_GPIO_in[24] = 1'b0; #10;
	end
	
	// Car going in, then pedestrian going in. 
	V_GPIO_in[24] = 1'b1; #10;
	V_GPIO_in[29] = 1'b1; #10;
	V_GPIO_in[24] = 1'b0; #10;
	V_GPIO_in[29] = 1'b0; #10;
	
	V_GPIO_in[24] = 1'b1; #10;
	V_GPIO_in[24] = 1'b0; #10;
	V_GPIO_in[29] = 1'b1; #10;
	V_GPIO_in[29] = 1'b0; #10;
	
	// pedestrian going out. 
	V_GPIO_in[29] = 1'b1; #10;
	V_GPIO_in[29] = 1'b0; #10;
	V_GPIO_in[24] = 1'b1; #10;
	V_GPIO_in[24] = 1'b0; #10;
	
	$stop;
	
	end
endmodule // DE1_SoC_tb