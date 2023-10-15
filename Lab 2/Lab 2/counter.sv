// simple implmentation of the counter module from 271.
// reset, clock are 1 bit inputs.
// count is a 5 bit output.
module counter(reset, clock, count);
	output logic [4:0] count; // address of memory location being read
	input  logic reset, clock;
	
	always_ff @(posedge clock) begin
		if(reset)
			count <= 0;
		else
			begin
				if(count == 31)
					count <= 0;
				else
					count <= count + 1;
			end
	end // always_ff
endmodule // counter

// 
module counter_tb ();

	logic reset, clock;
	logic [4:0] count;

	parameter CLOCK_PERIOD = 10;
	initial begin
	clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock; // forever toggle the clock
	end

	counter dut (.*);

	initial begin

		reset <= 1; @(posedge clock);
		reset <= 0; repeat (35) @(posedge clock);
		
		$stop;
	end
endmodule // counter_tb