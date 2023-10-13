//module car_counter(clk, reset, incr, decr, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
//    input logic clk, reset, incr, decr; // Initialize inputs
//    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Initialize outputs


// CURRENT TOP LEVEL MODULE CONTENTS-----------------------------------------
//	input  logic CLOCK_50;	// 50MHz clock
//	input  logic [9:0] SW;
//	input  logic [3:0] KEY;
//	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
//	
//	logic [4:0] Address;
//	logic [2:0] DataIn;
//	logic Write;
//	logic Clock;
//	logic [2:0] DataOut;
//	
//	assign DataIn = SW[3:1];
//	assign Address = SW[8:4];
//	assign Write = SW[0];
//	assign Clock = KEY[0];

//	
//	task2 t (.address(Address), .clock(Clock), .data(DataIn), .wren(Write), .q(DataOut));
////	instantiate modified seg7


// MY MODIFIED VERSION OF TOP LEVEL-------------------------------------------
//	input  logic CLOCK_50;	// 50MHz clock
//	input  logic [9:0] SW;
//	input  logic [3:0] KEY;
//	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
//	
//	logic [4:0] Address;
//	logic [2:0] DataIn;
//	logic Write;
//	logic Clock;
//	logic [2:0] DataOut;
//	logic reset;
//	
//	assign DataIn = SW[3:1];
//	assign Address = SW[8:4];
//	assign Write = SW[0];
//	assign Clock = KEY[0];
// assign reset = SW[9]; // 0 = task2, 1 = task3		


module task3 (address, clock, data, wren, q);
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
	
	
endmodule