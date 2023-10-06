/* Top-level module for LandsLand hardware connections to implement the parking lot system.*/

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, V_GPIO);

	input  logic		 CLOCK_50;	// 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	inout  logic [35:0] V_GPIO;	// expansion header 0 (LabsLand board)
	
	
	parameter whichClock = 0; // 0.75 Hz clock
   clock_divider cdiv (.clock(CLOCK_50),
                                .reset(reset),
                                .divided_clocks(div_clk));

    // Clock selection; allows for easy switching between simulation and board clocks
    logic clkSelect;
    // Uncomment ONE of the following two lines depending on intention

    // assign clkSelect = CLOCK_50; // for simulation
    assign clkSelect = div_clk[whichClock]; // for board

	
    // Turn off all 7-seg displays (active low: 1 = off, 0 = on)
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	
	// LED ON (1) = SENSOR BLOCKED. LED OFF (0) = SENSOR UNBLOCKED		 
	// assign V_GPIO[35] (outer LED) to V_GPIO[24] (outer switch)
	assign V_GPIO[32] = V_GPIO[24];
	
	// assign V_GPIO[33] (inner LED) to V_GPIO[26] (inner switch)
	assign V_GPIO[34] = V_GPIO[29];
	
	// assign v_GPIO[35] (reset LED) to V_GPIO[23] (reset switch)
	assign V_GPIO[35] = V_GPIO[23];
	assign reset = V_GPIO[23];
	
	parking_lot_occupancy parking (.clk(clkSelect), .V_GPIO, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);

endmodule  // DE1_SoC
