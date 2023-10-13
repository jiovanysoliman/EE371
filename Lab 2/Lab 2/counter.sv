module counter(reset, clk, addr);
	output logic [4:0] addr; // address of memory location being read
	input  logic reset, clk;
	
	always_ff @(posedge clk) begin
		if(reset)
			addr <= 5'b0;
		else
			begin
				if(addr == 5'b11111)
					addr <= 5'b0;
				else
					addr <= addr + 5'b00001;
			end
	end // always_ff
endmodule


module counter_tb();
	logic [4:0] addr;
	logic reset, clk;
	
	counter dut(.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
	end
	
	initial begin
		reset <= 1;            @(posedge clk);
		reset <= 0; repeat(35) @(posedge clk);
		reset <= 1;				  @(posedge clk);
		reset <= 0;				  @(posedge clk);
									  $stop;
	end
endmodule
						
	