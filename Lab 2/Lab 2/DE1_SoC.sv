/* Top-level module for LandsLand hardware connections to implement the memory.*/
module DE1_SoC (SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

//	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	logic [4:0] Address;
	logic [2:0] DataIn;
	logic Write;
	logic Clock;
	logic [2:0] DataOut;
	
	assign DataIn = SW[3:1];
	assign Address = SW[8:4];
	assign Write = SW[0];
	assign Clock = KEY[0];
	
	task2 t (.address(Address), .clock(Clock), .data(DataIn), .wren(Write), .q(DataOut));
//	instantiate modified seg7
	
endmodule  // DE1_SoC





///* Test bench for the DE1_SoC module */
//module DE1_SoC_tb ();
//
//	// inout pins must be connected to a wire type
//	wire [35:0] V_GPIO;
//	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//	logic clk;
//	
//	// additional logic required to simulate inout pins
//	logic [35:0] V_GPIO_in;
//	logic [35:0] V_GPIO_dir; // 1 = input, 0 = output
//	
//	// set up tristate buffers for inout pins
//	genvar i;
//	generate
//		for (i = 0; i < 36; i++) begin : gpio
//			assign V_GPIO[i] = V_GPIO_dir[i] ? V_GPIO_in[i] : 1'bZ;
//		end
//	endgenerate
//	
//	// begin simulation
//	//simulate clock signal
//	initial begin
//	parameter CLOCK_PERIOD = 10;
//	clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
//	end
//	
//	//initialize an instance of the device under test (dut)
//	DE1_SoC dut (.CLOCK_50(clk), .V_GPIO, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
//	
//	
//	initial begin
//	// you only need to set the pin directions once
//	V_GPIO_dir[23] = 1'b1;
//	V_GPIO_dir[24] = 1'b1;
//	V_GPIO_dir[29] = 1'b1;
//	
//	V_GPIO_dir[32] = 1'b0;
//	V_GPIO_dir[34] = 1'b0;
//	V_GPIO_dir[35] = 1'b0;
//	
//	// manipulate the V_GPIO input bits indirectly through V_GPIO_in
//	// activate reset switch once.
//	V_GPIO_in[23] = 1'b1;
//	V_GPIO_in[23] = 1'b0;
//	
//	// car going in sequence. 
//	V_GPIO_in[24] = 1'b1; #10;
//	V_GPIO_in[29] = 1'b1; #10;
//	V_GPIO_in[24] = 1'b0; #10;
//	V_GPIO_in[29] = 1'b0; #10;
//	
//	// activate reset switch once.
//	V_GPIO_in[23] = 1'b1; #10;
//	V_GPIO_in[23] = 1'b0; #10;
//	
//	// car going in sequence. repeats 16 times. 
//	for (int i = 0; i <= 16; i++) begin: carsIn
//		V_GPIO_in[24] = 1'b1; #10;
//		V_GPIO_in[29] = 1'b1; #10;
//		V_GPIO_in[24] = 1'b0; #10;
//		V_GPIO_in[29] = 1'b0; #10;
//	end
//	
//	// car going out in sequence. repeats 16 times.
//	for (int i = 0; i <= 16; i++) begin: carsOut
//		V_GPIO_in[29] = 1'b1; #10;
//		V_GPIO_in[24] = 1'b1; #10;
//		V_GPIO_in[29] = 1'b0; #10;
//		V_GPIO_in[24] = 1'b0; #10;
//	end
//	
//	// Car going in, then pedestrian going in. 
//	V_GPIO_in[24] = 1'b1; #10;
//	V_GPIO_in[29] = 1'b1; #10;
//	V_GPIO_in[24] = 1'b0; #10;
//	V_GPIO_in[29] = 1'b0; #10;
//	
//	V_GPIO_in[24] = 1'b1; #10;
//	V_GPIO_in[24] = 1'b0; #10;
//	V_GPIO_in[29] = 1'b1; #10;
//	V_GPIO_in[29] = 1'b0; #10;
//	
//	// pedestrian going out. 
//	V_GPIO_in[29] = 1'b1; #10;
//	V_GPIO_in[29] = 1'b0; #10;
//	V_GPIO_in[24] = 1'b1; #10;
//	V_GPIO_in[24] = 1'b0; #10;
//	
//	$stop;
//	
//	end
//endmodule // DE1_SoC_tb