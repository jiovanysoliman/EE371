module task1 (addressI, clock, dataI, wrenI, q);

input logic [4:0] addressI;
logic [4:0] address;

input logic [2:0] dataI;
logic [2:0] data;

input logic clock;

input logic wrenI;
logic wren;

output logic [2:0] q;

always_ff @(posedge clock) begin

	address <= addressI;
	data <= dataI;
	wren <= wrenI;

end

ram32x3 RAM (.*);

endmodule 

`timescale 1 ps / 1 ps
module task1_tb ();

	logic [4:0] addressI;
	logic clock;
	logic [2:0] dataI;
	logic wrenI;
	logic [2:0] q;

	task1 dut (.*);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock; // forever toggle the clock
	end

	initial begin
		integer i;
		integer j;
		for (i = 0; i <= 31; i++) begin
			for (j = 0; j <= 7; j++) begin
				wrenI = 1; 
				addressI = i; @(posedge clock);
				dataI = j; @(posedge clock);
			end
		end
		$stop;
	end
endmodule 