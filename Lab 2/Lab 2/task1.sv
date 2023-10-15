// Module to demonstrate the functionality of task1.
// This module use the IP cataloge 1port RAM.
// clock, wren are 1 bit inputs.
// address is a 5 bit input.
// data is a 3 bit input.
// q is a 3 bit output.
module task1(address, clock, data, wren, q);
	input logic	[4:0] address;
	input	logic [2:0] data;
	input logic clock;
	input logic wren;
	
	output logic [2:0] q;
	
	logic [4:0] addressI;
	logic	[2:0] dataI;
	logic wrenI;
	
	// Make an instance of a 32 Depth by 3 Width Ram. Pass the ports accordingly.
	ram32x3 ram1 (addressI, clock, dataI, wrenI, q);
	
	// Flip flops applied to the inputs as described in lab specification figure 1-b.
	always_ff @(posedge clock) begin
	
	addressI <= address;
	dataI <= data;
	wrenI <= wren;
	
	end
	
endmodule // task1

`timescale 1 ps / 1 ps
module task1_tb();
	logic [4:0] address;
	logic       clock;
	logic [2:0] data;
	logic       wren;
	logic [2:0] q;
	
	task1 dut(.*);
	
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
endmodule // task1_tb