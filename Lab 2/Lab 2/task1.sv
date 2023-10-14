// Module to demonstrate the functionality of task1
// This module use the IP cataloge 1port RAM.
// clock, wren are 1 bit inputs.
// address is a 5 bit input.
// data is a 3 bit input.
// q is a 3 bit output.
module task1(address, clock, data, wren, q);
	input	 [4:0] address;
	input        clock;
	input	 [2:0] data;
	input        wren;
	output [2:0] q;
	
	// Make an instance of a 32 Depth by 3 Width Ram. Pass the ports accordingly.
	ram32x3 ram1 (.*);

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
	
	// simulates some values while write is enabled and some while right is disabled.
//	initial begin
//		wren <= 1; address <= 5'b00000; data <= 3'b111; @(posedge clock); //write to 5 different registers
//					  address <= 5'b00101; data <= 3'b010; @(posedge clock);
//					  address <= 5'b01010; data <= 3'b001; @(posedge clock);
//					  address <= 5'b01111; data <= 3'b110; @(posedge clock);
//					  address <= 5'b10100; data <= 3'b101; @(posedge clock);
//		wren <= 0;													@(posedge clock);
//					  address <= 5'b00101; 						@(posedge clock); //read from 2/5 registers to verify W/R capabilities
//					  address <= 5'b01111;						@(posedge clock);
//																		@(posedge clock);
//		$stop;
	
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