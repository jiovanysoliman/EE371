/* Top-level module for LandsLand hardware connections to implement task 2 using DE1_SoC interfaces.*/
// SW is a 10 bit input
// KEY is a 4 bit input
// HEX5- HEX0 is a 7 bit output.
module DE1_SoC (SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

//	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	logic [4:0] Address;
	logic [2:0] DataIn;
	logic [2:0] DataOut;
	logic Write;
	logic Clock;
	
	// sets the non-used HEX displays to off.
	assign HEX3 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	
	// Makes an instance of task2 that's driven by DE1_SoC inputs and drives its outputs.
	task2 RAM (.address(SW[8:4]), .clock(KEY[0]), .data(SW[3:1]), .wren(SW[0]), .q(DataOut[2:0]));
	
	// Display the address values on HEX5 and HEX4
	seg7 AddressValueHex5 (.hex(SW[8]), .leds(HEX5));
	seg7 AddressValueHex4 (.hex(SW[7:4]), .leds(HEX4));

	// Display data in value on HEX1
	seg7 DataInHex1 (.hex(SW[3:1]), .leds(HEX1));

	// Display data out on HEX0
	seg7 DataOutHex0 (.hex(DataOut[2:0]), .leds(HEX0));
	
endmodule  // DE1_SoC


///* Test bench for the DE1_SoC module */
module DE1_SoC_tb ();
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	DE1_SoC dut(.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		KEY[0] <= 0;
		forever #(CLOCK_PERIOD/2) KEY[0] <= ~KEY[0]; // forever toggle the clock
	end
	
	initial begin
		integer i;
		
		// goes through each memory address
		// sets the data at memory address to memory address
		// write enabled.
		for (i = 0; i <= 31; i++) begin
			SW[0] = 1; 
			SW[8:4] = i; @(posedge KEY[0]);
			SW[3:1] = i; @(posedge KEY[0]);
		end
		
		// goes through each memory address
		// sets data at each memory address to zero
		// write not enabled
		for (i = 0; i <= 31; i++) begin
			SW[0] = 0; 
			SW[8:4] = i; @(posedge KEY[0]);
			SW[3:1] = 0; @(posedge KEY[0]);
		end
	$stop;
	end
endmodule // DE1_SoC_tb