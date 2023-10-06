// Basic DFF from example code in lecture.
// Two DFFs in series will help eliminate metastability
module D_FF(q, d, clk);
	output logic q;
	input logic d, clk;
	
	always_ff @(posedge clk)
		begin
			q <= d;
		end
endmodule 

module D_FF_testbench();
	logic q, d, clk;
	
	D_FF dut (.*); // connect all ports by name since they match
	
	// Set up a simulated clock.
   parameter CLOCK_PERIOD=100;
   initial begin
       clk <= 0;
       forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
   end
	 
   // Set up the inputs to the design. Each line is a clock cycle.
   initial begin
										@(posedge clk);
				d <= 0; repeat(4) @(posedge clk);
				d <= 1; repeat(4) @(posedge clk);
				d <= 0; 				@(posedge clk);
				d <= 1;				@(posedge clk);
				d <= 0;				@(posedge clk);
										@(posedge clk);
				d <= 1;				@(posedge clk);
										@(posedge clk);
													$stop;
    end
endmodule 
			
	 