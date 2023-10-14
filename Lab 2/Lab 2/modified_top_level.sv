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
<<<<<<< Updated upstream
	logic readAddr; // for ram32x3port2
=======
	logic [4:0] readAddr; // for ram32x3port2
	
	// slow clock down for counter
	logic clkSelect;
	logic [31:0] clk;
	parameter whichclk = 25;
	clock_divider cdiv (.clock(CLOCK_50), .divided_clocks(clk));
	
	// Uncomment ONE of the following two lines depending on intention
//    assign clkSelect = CLOCK_50; // for simulation
     assign clkSelect = clk[whichclk]; // for board
>>>>>>> Stashed changes
	
	assign DataIn = SW[3:1];
	assign Address = SW[8:4];
	assign Write = SW[0];
	assign reset = ~KEY[3]; // active low
	assign select = SW[9]; // 0 = task2, 1 = task3
	
	always_comb
		case(select)
			1'b0: 
				begin
<<<<<<< Updated upstream
					address1 = Address;
=======
					address1 = Address; 
					address2 = Address;
>>>>>>> Stashed changes
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
	
<<<<<<< Updated upstream
	task2 t2 (.address(address1), .clock(CLOCK_50), .data(DataIn), .wren(wren1), .q(DataOut));
	ram32x3port2 r (.clock(CLOCK_50), .data(DataIn), .rdaddress(readAddr), .wraddress(address2), .wren(wren2), .q(DataOut));
	
	seg7 s (.hex, .leds);
	
//	input  logic [3:0] hex;
//	output logic [6:0] leds;
endmodule
	
=======
  	counter c (.reset(reset), .clk(clkSelect), .addr(readAddr));
    
 	task2 t2 (.address(address1), .clock(clkSelect), .data(DataIn), .wren(wren1), .q(DataOut1));
 	ram32x3port2 r (.clock(clkSelect), .data(DataIn), .rdaddress(readAddr), .wraddress(address2), .wren(wren2), .q(DataOut2));
	
	// Display the write address for task 1
	seg7 addrDisplay1 (.hex(SW[8]), .leds(HEX5));
	seg7 addrDisplay2 (.hex(SW[7:4]), .leds(HEX4));
	
		// Display the read address for task 2
	seg7 addrDisplay3 (.hex(readAddr[4]), .leds(HEX3));
	seg7 addrDisplay4 (.hex(readAddr[3:0]), .leds(HEX2));

	// Display data in
	seg7 dataInDisplay (.hex(SW[3:1]), .leds(HEX1));

	// Display data out
	seg7 dataOutDisplay (.hex(dataDisplay), .leds(HEX0));	
endmodule

module clock_divider (clock, divided_clocks);
	input logic clock;
	output logic [31:0] divided_clocks;

	initial begin
		divided_clocks <= 0;
	end

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
   end
endmodule

//module modified_top_level_tb();
//	logic CLOCK_50;	// 50MHz clock
//	logic [9:0] SW;
//	logic [3:0] KEY;
//	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
//	
//	modified_top_level dut(.*);
//	
//	// Set up a simulated clock.
//    parameter CLOCK_PERIOD=100;
//    initial begin
//        CLOCK_50 <= 0;
//        forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
//    end
//
//    // Test the design.
//    initial begin
//		KEY[3] <= 0;
//	
//endmodule

/* NOTES:
	SW9 toggles between memory task 2 and task 3
	SW8 - SW4 sets write address 
	SW3 - SW1 sets write data
	
	KEY3 reset
	
	Display on HEX3 - HEX2 read address
	Dispaly on HEX0 content of memory at address
	
*/

>>>>>>> Stashed changes
//ram32x3port2 (clock,	data,	rdaddress,	wraddress,	wren,	q);
//
//	input	  clock;
//	input	[2:0]  data;
//	input	[4:0]  rdaddress;
//	input	[4:0]  wraddress;
//	input	  wren;
//	output	[2:0]  q;
	
	