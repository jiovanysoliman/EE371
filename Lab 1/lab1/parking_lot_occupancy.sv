// Combines car_detection module and car_counter module to determine occupancy of parking lot.
// 1 bit inputs are clk, reset, inner, outer
// 7 bits outputs are HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
module parking_lot_occupancy(clk, reset, inner, outer, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic clk, reset, inner, outer;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // 7-bit counter for HEX display module
	logic enter, exit;
			 
	// instanciates a car detector, and passess the below signals in the ports explicitly.
	car_detection detector (.clk(clk), .reset(reset), .outer(outer), .inner(inner), .enter(enter), .exit(exit)); 
	
	// instanciates a counter, and passess the below signals in the ports explicitly.
	car_counter counter (.clk(clk), .reset(reset), .incr(enter), .decr(exit), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));

endmodule // parking_lot_occupancy 


// testbench module for parking_lot_occupancy
module parking_lot_occupancy_tb();
	
	logic clk, reset, inner, outer, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	// begin simulation
	//simulate clock signal
	initial begin
	parameter CLOCK_PERIOD = 10;
	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
	end
	
	//initialize an instance of the device under test (dut)
	parking_lot_occupancy dut (.*);
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		inner <= 1; @(posedge clk);
		inner <= 0; @(posedge clk);
		
		outer <= 1; @(posedge clk);
		outer <= 0; @(posedge clk);
	end
endmodule // parking_lot_occupancy_tb