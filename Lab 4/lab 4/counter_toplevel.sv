module counter_toplevel(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, LEDR, KEY);
	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	// turn HEX5 - HEX4 off
	assign HEX5 = 7'hFF;
	assign HEX4 = 7'hFF;
	assign HEX3 = 7'hFF;
	assign HEX2 = 7'hFF;
	assign HEX1 = 7'hFF;
	
	logic [7:0] A;
	assign A = SW[7:0];
	
	logic reset, start;
	assign reset = ~KEY[0];
	assign start = ~KEY[3];
	
	// 2 ffs for s input
	logic w1, s;
	D_FF d1 (.q(w1), .d(start), .clk(CLOCK_50));
	D_FF d2 (.q(s), .d(w1), .clk(CLOCK_50));
	
	// internal wires
	logic z, g, ld, sh, incr, clr, DONE;
	logic [3:0] r;
	
	counter_cntrl cntrl (.clk(CLOCK_50), .reset(reset), .s(s), .A_zero(z), .got_1(g), .load_A(ld), .r_shift_A(sh), .incr_result(incr), .clr_result(clr), .done(DONE));
	counter_datapath dp (.clk(CLOCK_50), .A(A), .load_A(ld), .r_shift_A(sh), .incr_result(incr), .clr_result(clr), .A_zero(z), .got_1(g), .result(r));
	
	seg7 seg (.hex(r), .leds(HEX0));
	assign LEDR[9] = DONE;
	
endmodule 

// FIX THIS -- DOES NOT SHOW HEX UPDATING PROPERLY but still works in labsland???
module toplevel_tb();
	logic CLOCK_50;	// 50MHz clock
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [9:0] LEDR;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	counter_toplevel dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	integer i;
	initial begin
		KEY[0] <= 0; @(posedge CLOCK_50);
		KEY[0] <= 1; @(posedge CLOCK_50);
		
		for(i = 0; i < 2**8; i++) begin
			SW[7:0] = i; @(posedge CLOCK_50);
		end
	end
endmodule 

