// Module to demonstrate the functionality of task2.
// This module use the IP cataloge 1port RAM.
// clock, wren are 1 bit inputs.
// address is a 5 bit input.
// data is a 3 bit input.
// q is a 3 bit output.
module task2 (address, clock, data, wren, q);
	input	logic [4:0] address;
	input logic clock;
	input	logic [2:0] data;
	input logic wren;
	output logic [2:0] q;
	
	logic [4:0] addressI;
	logic	[2:0] dataI;
	logic wrenI;
		
	// instanciation of a 32x3 array.
	logic [2:0] memory_array [31:0];
	
	// Flip flops applied to the inputs as described in lab specification figure 1-b.
	// If write is enabled, the data is applied to the input address in the array, as well as the output.
	// if write is disabled, the output remains to be the value at input address. No change to array.
	always_ff @(posedge clock) begin
		addressI <= address;
		dataI <= data;
		wrenI <= wren;
		
		// if write is enabled
		if(wrenI) begin
			memory_array[addressI] <= dataI;
			q <= dataI;
		end
		// if write is disabled
		else begin
			q <= memory_array[addressI];
		end
	end //always_ff

endmodule // task2

module task2_tb();
	logic [4:0] address;
	logic       clock;
	logic [2:0] data;
	logic       wren;
	logic [2:0] q;
	
	task2 dut(.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock; // forever toggle the clock
	end
	
	initial begin
		integer i;
		
		// goes through each memory address
		// sets the data at memory address to memory address
		// write enabled.
		for (i = 0; i <= 31; i++) begin
			wren = 1; 
			address = i; @(posedge clock);
			data = i; @(posedge clock);
		end
		
		// goes through each memory address
		// sets data at each memory address to zero
		// write not enabled
		for (i = 0; i <= 31; i++) begin
			wren = 0; 
			address = i; @(posedge clock);
			data = 0; @(posedge clock);
		end
	$stop;
	end
endmodule