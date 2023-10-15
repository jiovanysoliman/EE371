module modified_top_level (CLOCK_50, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input  logic CLOCK_50;	// 50MHz clock
	input  logic [9:0] SW;
	input  logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	logic [2:0] DataOut1;
	logic [2:0] DataOut2;
	logic [2:0] dataDisplay;
	logic wren1, wren2; //wren1 = task2, wren2 = task3
	logic [4:0] readAddr; // for ram32x3port2
	logic CounterClock;
	
	
	always_comb
		case(SW[9])
			0: 
				begin
					wren1 = SW[9];
					wren2 = ~SW[9];
					dataDisplay = DataOut1;
				end
			1: 
				begin
					wren1 = ~SW[9];
					wren2 = SW[9];
					dataDisplay = DataOut2;
				end
				
			default: 
				begin
					wren1 = ~SW[9];
					wren2 = ~SW[9];
					dataDisplay = DataOut1;
				end
		endcase
	
	clock_divider cdiv (.clock(CLOCK_50), .divided_clocks(CounterClock));
	
 	counter c (.reset(~KEY[3]), .clock(CounterClock), .count(readAddr));
 	
 	logic [4:0] readAddrbuff;
 	
 	D_FF d1(.q(readAddrbuff[4]), .d(readAddr[4]), .reset(~KEY[3]), .clk(CLOCK_50));
 	D_FF d2(.q(readAddrbuff[3]), .d(readAddr[3]), .reset(~KEY[3]), .clk(CLOCK_50));
 	D_FF d3(.q(readAddrbuff[2]), .d(readAddr[2]), .reset(~KEY[3]), .clk(CLOCK_50));
 	D_FF d4(.q(readAddrbuff[1]), .d(readAddr[1]), .reset(~KEY[3]), .clk(CLOCK_50));
 	D_FF d5(.q(readAddrbuff[0]), .d(readAddr[0]), .reset(~KEY[3]), .clk(CLOCK_50));

    
	// Makes an instance of task2 that's driven by DE1_SoC inputs and drives its outputs.
	task2 RAM (.address(SW[8:4]), .clock(KEY[0]), .data(SW[3:1]), .wren(wren1), .q(DataOut1[2:0]));
	
	// Make an instance of task3 that's driven by the counter and inputs from DE1_SoC.
 	ram32x3port2 RAM2Port (.clock(CLOCK_50), .data(SW[3:1]), .rdaddress(readAddr), .wraddress(SW[8:4]), .wren(wren2), .q(DataOut2));
	
	
	// Display the address values on HEX5 and HEX4
	seg7 AddressValueHex5 (.hex(SW[8]), .leds(HEX5));
	seg7 AddressValueHex4 (.hex(SW[7:4]), .leds(HEX4));
	
	
	// Display the read address for task 2
	seg7 addrDisplay3 (.hex(readAddrbuff[4]), .leds(HEX3));
	seg7 addrDisplay4 (.hex(readAddrbuff[3:0]), .leds(HEX2));

	// Display data in value on HEX1
	seg7 DataInHex1 (.hex(SW[3:1]), .leds(HEX1));
	
endmodule

module D_FF (q, d, reset, clk);
    input  logic d, clk, reset;
    output logic q;
    
    always_ff @(posedge clk) begin 
        if(reset)
            q <= 0;
        else
            q <= d;
    end
endmodule

///* Test bench for the DE1_SoC modified module */
module modified_top_level_tb ();
	logic CLOCK_50;
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	DE1_SoC dut(.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // forever toggle the clock
	end
	
	initial begin
		
		integer i;
		
		// goes through each memory address
		// sets the data at memory address to memory address
		// write enabled.
		for (i = 0; i <= 31; i++) begin
			SW[9] = 1; 
			SW[8:4] = i; @(posedge CLOCK_50);
			SW[3:1] = i; @(posedge CLOCK_50);
		end
		
		// goes through each memory address
		// sets data at each memory address to zero
		// write not enabled
		for (i = 0; i <= 31; i++) begin
			SW[9] = 0; 
			SW[8:4] = i; @(posedge CLOCK_50);
			SW[3:1] = 0; @(posedge CLOCK_50);
		end
	$stop;
	end
endmodule // modified_top_level_tb