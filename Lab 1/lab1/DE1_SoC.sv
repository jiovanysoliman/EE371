/* Top-level module for LandsLand hardware connections to implement the parking lot system.*/

module DE1_SoC (CLOCK_50, LEDR, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input  logic		 CLOCK_50;	// 50MHz clock
	input logic [2:0] SW;
    output logic [2:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
// 	inout  logic [35:0] V_GPIO;	// expansion header 0 (LabsLand board)
	       logic inner, outer;
	    logic [31:0] div_clk;
		logic reset;
	
	
	parameter whichClock = 12; // 0.75 Hz clock
   clock_divider cdiv (.clock(CLOCK_50),
                                .reset(reset),
                                .divided_clocks(div_clk));

    // Clock selection; allows for easy switching between simulation and board clocks
    logic clkSelect;
    // Uncomment ONE of the following two lines depending on intention

    // assign clkSelect = CLOCK_50; // for simulation
    assign clkSelect = div_clk[whichClock]; // for board

	
    // Turn off all 7-seg displays (active low: 1 = off, 0 = on)
// 	assign HEX0 = 7'b1111111;
// 	assign HEX1 = 7'b1111111;
// 	assign HEX2 = 7'b1111111;
// 	assign HEX3 = 7'b1111111;
// 	assign HEX4 = 7'b1111111;
// 	assign HEX5 = 7'b1111111;
	
	
// 	// LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
// 	// assign V_GPIO[35] (outer LED) to V_GPIO[24] (outer switch)
// 	assign V_GPIO[32] = V_GPIO[24];
	
// 	// assign V_GPIO[33] (inner LED) to V_GPIO[26] (inner switch)
// 	assign V_GPIO[34] = V_GPIO[29];
	
// 	// assign v_GPIO[35] (reset LED) to V_GPIO[23] (reset switch)
// 	assign V_GPIO[35] = V_GPIO[23];
// 	assign reset = V_GPIO[23];

    assign LEDR[2] = SW[2]; // reset
    assign LEDR[1] = SW[1]; // inner
    assign LEDR[0] = SW[0]; // outer
    assign reset   = SW[2];
	
	//2 DFFs in series for each input (switch) will help eliminate metastability
	D_FF outer_switch_1 (.q(outer_wire), .d(SW[0]), .clk(clkSelect));
	D_FF outer_switch_2 (.q(outer), .d(outer_wire), .clk(clkSelect));
	
	D_FF inner_switch_1 (.q(inner_wire), .d(SW[1]), .clk(clkSelect));
	D_FF inner_switch_2 (.q(inner), .d(inner_wire), .clk(clkSelect));
	
	parking_lot_occupancy parking (.clk(clkSelect), .reset(reset), .inner(inner), .outer(outer), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));

endmodule  // DE1_SoC

// change clock select for test bench for modelsim
// basically copy car_detection
// chance clock select back for uploading to FPGA

