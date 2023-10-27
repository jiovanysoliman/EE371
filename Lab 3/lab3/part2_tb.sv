// This module mocks the behavior of module part2 for testing purposes, 
// omitting all other signals of the Audio CODEC for simplicity. Module
// part2 is supposed to pass audio input only when CODEC is ready for 
// reading and writing.
// Inputs
// 	read_ready  = CODEC read ready signal
// 	write_ready = CODEC write ready signal
//		CLOCK_50    = onboard clock
// Outputs
//		writedata_left  = output audio (left channel)
//		writedata_right = output audio (right channel)
//		read  = read signal from our circuit
// 	write = write signal from our circuit
module mockPart2(CLOCK_50, reset, read_ready, write_ready, writedata_left, writedata_right, read, write);
	input  logic read_ready, write_ready, CLOCK_50, reset;
	output wire [23:0] writedata_left, writedata_right;
	output wire read, write;
	
	logic [3:0]  address;

// initialize ROM memory (artificial samples created for testing purposes - not real generated tone samples)
	logic [23:0][15:0] ROM  = {{24'h4d7f1e},
									   {24'h3f8a2c},
										{24'h5a9b5d},
										{24'h7e6c1c},
										{24'h8d9e3f},
										{24'h6b4a2b},
										{24'h9c8d3e},
										{24'h2f5b1d},
										{24'h1e7c5a},
										{24'h3d9f2c},
										{24'h6a4b3f},
										{24'h8d7e1c},
										{24'h5a9c3e},
										{24'h7d6b2b},
										{24'h4c8e5c},
										{24'h9b5a3f}};
	
	// cycle through each sample of our artificial tone
	always_ff @(posedge CLOCK_50) begin
		if (reset | (address == 15)) address <= 0;
		else if (read & write) address <= address + 1'b1;
		else address <= address;
	end
										
	assign writedata_left  = ROM[address];
	assign writedata_right = ROM[address];
	assign read = read_ready && write_ready;
	assign write = read_ready && write_ready;
	
endmodule


module part2_tb();
	logic read_ready, write_ready, CLOCK_50, reset;
	wire [23:0] writedata_left, writedata_right;
	wire read, write;
	
	mockPart2 dut(.*);
	
	parameter CLOCK_PERIOD = 10; // arbitrary choice
	initial begin
	CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	integer i;
	initial begin
		reset <= 1; @(posedge CLOCK_50);
		reset <= 0; @(posedge CLOCK_50);
		
		for(i = 0; i < 4; i++) begin
			{read_ready, write_ready} = i; repeat(3) @(posedge CLOCK_50);
		end
		read_ready <= 0; write_ready <= 0; repeat(3) @(posedge CLOCK_50);
		$stop;
	end
	
endmodule 