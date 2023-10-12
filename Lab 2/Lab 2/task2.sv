
// Needs more work
module task2 (address, clock, data, wren, q);
	input	 [4:0] address;
	input        clock;
	input	 [2:0] data;
	input        wren;
	output [2:0] q;
	
	logic [2:0] memory_array [31:0];
	
	always_ff @(posedge clock) begin
		if(wren) begin
			memory_array[address] <= data;
			q <= data;
		end
		else begin
			q <= memory_array[address];
		end
	end //always_ff	
endmodule 

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
		wren <= 1; address <= 5'b00000; data <= 3'b111; @(posedge clock); //write to 5 different registers
					  address <= 5'b00101; data <= 3'b010; @(posedge clock);
					  address <= 5'b01010; data <= 3'b001; @(posedge clock);
					  address <= 5'b01111; data <= 3'b110; @(posedge clock);
					  address <= 5'b10100; data <= 3'b101; @(posedge clock);
		wren <= 0;													@(posedge clock);
					  address <= 5'b00101; 						@(posedge clock); //read from 2/5 registers to verify W/R capabilities
					  address <= 5'b01111;						@(posedge clock);
																		@(posedge clock);
																		$stop;
	end
endmodule