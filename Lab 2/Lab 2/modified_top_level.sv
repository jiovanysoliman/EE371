module modified_top_level(CLOCK_50, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	
	logic [4:0] Address;
	logic [2:0] DataIn;
	logic Write;	
	logic reset;
	logic select;
	logic [2:0] DataOut;
	logic [2:0] address1, address2; //switch, addr value, select, real addr
	logic wren1, wren2; //wren1 = task2, wren2 = task3
	logic readAddr; // for ram32x3port2
	
	assign DataIn = SW[3:1];
	assign Address = SW[8:4];
	assign Write = SW[0];
	assign reset = KEY[3];
	assign select = SW[9]; // 0 = task2, 1 = task3
	
	always_comb
		case(select)
			1'b0: 
				begin
					address1 = Address;
					wren1 = Write;
					wren2 = 0;
				end
			1'b1: 
				begin
					address2 = Address;
					wren1 = 0;
					wren2 = Write;
				end
		endcase
	
	
	counter c (.reset(reset), .clk(CLOCK_50), .addr(readAddr));
	
	task2 t2 (.address(address1), .clock(CLOCK_50), .data(DataIn), .wren(wren1), .q(DataOut));
	ram32x3port2 r (.clock(CLOCK_50), .data(DataIn), .rdaddress(readAddr), .wraddress(address2), .wren(wren2), .q(DataOut));
	
	seg7 s (.hex, .leds);
	
//	input  logic [3:0] hex;
//	output logic [6:0] leds;
endmodule
	
//ram32x3port2 (clock,	data,	rdaddress,	wraddress,	wren,	q);
//
//	input	  clock;
//	input	[2:0]  data;
//	input	[4:0]  rdaddress;
//	input	[4:0]  wraddress;
//	input	  wren;
//	output	[2:0]  q;
	
	