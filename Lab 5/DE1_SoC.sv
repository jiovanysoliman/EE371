/* Top level module of the FPGA that takes the onboard resources 
 * as input and outputs the lines drawn from the VGA port.
 *
 * Inputs:
 *   KEY 			- On board keys of the FPGA
 *   SW 			- On board switches of the FPGA
 *   CLOCK_50 		- On board 50 MHz clock of the FPGA
 *
 * Outputs:
 *   HEX 			- On board 7 segment displays of the FPGA
 *   LEDR 			- On board LEDs of the FPGA
 *   VGA_R 			- Red data of the VGA connection
 *   VGA_G 			- Green data of the VGA connection
 *   VGA_B 			- Blue data of the VGA connection
 *   VGA_BLANK_N 	- Blanking interval of the VGA connection
 *   VGA_CLK 		- VGA's clock signal
 *   VGA_HS 		- Horizontal Sync of the VGA connection
 *   VGA_SYNC_N 	- Enable signal for the sync of the VGA connection
 *   VGA_VS 		- Vertical Sync of the VGA connection
 */
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
	logic [10:0] x0, y0, x1, y1, x, y;
	logic line_reset;
	logic color;

	VGA_framebuffer fb (
		.clk50			(CLOCK_50), 
		.reset			(SW[5]), 
		.x(x), 
		.y(y),
		.pixel_color	(color), 
		.pixel_write	(1'b1),
		.VGA_R, 
		.VGA_G, 
		.VGA_B, 
		.VGA_CLK, 
		.VGA_HS, 
		.VGA_VS,
		.VGA_BLANK_n	(VGA_BLANK_N), 
		.VGA_SYNC_n		(VGA_SYNC_N));
				
	logic done;

	line_drawer lines (.clk(CLOCK_50), .reset(line_reset), .x0(x0), .y0(y0), .x1(x1), .y1(y1), .x(x), .y(y), .done(done));
	
	assign LEDR[9] = done;
	
	// use a slower clock for animation so that it is visible to users
	logic [31:0] new_clock;
	clock_divider cd (.clock(CLOCK_50), .divided_clocks(new_clock));
	logic animator_clk;
	assign animator_clk = new_clock[8]; // slower clock to use
	
	// state variables - drawing states, "erasing" states, idle state, and reset states to work with line drawer module
    enum {idle, negative, negative_reset, noff, noff_reset, vertical, vertical_reset, voff, voff_reset, 
			 positive, positive_reset, poff, poff_reset, horizontal, horizontal_reset, hoff, hoff_reset} ps, ns;
    
	 // if color = 1, draw white line
	 // if color = 0, draw black line
    always_comb begin
        case(ps)
				idle: // idle/reset state for drawing negative line
                begin
                    color = 1;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    ns = negative;
						  line_reset = 1;
                end
            negative: // draw negative line
                begin
                    color = 1;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    if(done) ns = negative_reset;
						  else ns = negative;
						  line_reset = 0;
                end
					 
				negative_reset: // reset state for erasing negative line
					begin
						  color = 0;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
						  ns = noff;
						  line_reset = 1;
					end
					
            noff: // erase negative line
                begin
                    color = 0;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    if(done) ns = noff_reset;
						  else ns = noff;
						  line_reset = 0;
                end
					 
				noff_reset: // reset state for drawing vertical line
					begin
						  color = 1;
                    x0 = 320;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300; 
						  ns = vertical;
						  line_reset = 1;
					end
					
            vertical: // draw vertical line
                begin
                    color = 1;
                    x0 = 320;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300; 
                    if(done) ns = vertical_reset;
						  else ns = vertical;
						  line_reset = 0;
                end
					 
				vertical_reset: // reset state for erasing vertical line
					begin
						  color = 0;
                    x0 = 320;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300; 
						  ns = voff;
						  line_reset = 1;
					end
					
            voff: // erase vertical line
                begin
                    color = 0;
                    x0 = 320;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    if(done) ns = voff_reset;
						  else ns = voff;
						  line_reset = 0;
                end
					 
				voff_reset: // reset state for drawing positive line
					begin
						color = 1;
                  x0 = 420;
                  y0 = 200;
                  x1 = 320;
                  y1 = 300;
						ns = positive;
						line_reset = 1;
					end
					
            positive: // draw positive line
                begin
                    color = 1;
                    x0 = 420;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    if(done) ns = poff;
						  else ns = positive;
						  line_reset = 0;
                end
					 
				positive_reset: // reset state for erasing positive line
					begin
						color = 0;
                    x0 = 420;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
							ns = poff;
						  line_reset = 1;
					end
					
            poff: // erase positive line
                begin
                    color = 0;
                    x0 = 420;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    if(done) ns = poff_reset;
						  else ns = poff;
						  line_reset = 0;
                end
					 
				poff_reset: // reset state for drawing horizontal line
					begin
						color = 1;
                    x0 = 120;
                    y0 = 250;
                    x1 = 420;
                    y1 = 250;
                    ns = horizontal;
						  line_reset = 1;
					end
					
            horizontal: // draw horizontal line
                begin
                    color = 1;
                    x0 = 120;
                    y0 = 250;
                    x1 = 420;
                    y1 = 250;
                    if(done) ns = horizontal_reset;
						  else ns = horizontal;
						  line_reset = 0;
                end
					 
				horizontal_reset: // reset state for erasing horizontal line
					begin
						color = 0;
                    x0 = 120;
                    y0 = 250;
                    x1 = 420;
                    y1 = 250;
                    ns = hoff;
						  line_reset = 1;
					end
					
            hoff: // erase horizontal line
                begin
                    color = 0;
                    x0 = 120;
                    y0 = 250;
                    x1 = 420;
                    y1 = 250;
                    if(done) ns = hoff_reset;
						  else ns = hoff;
						  line_reset = 0;
                end
					 
				hoff_reset: // reset state for drawing negative line
					begin
						color = 1;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    ns = negative;
						  line_reset = 1;
					end
					
            default:	
                begin
                    color = 0;
                    x0 = 120;
                    y0 = 200;
                    x1 = 320;
                    y1 = 300;
                    ns = idle;
						  line_reset = 0;
                end
            endcase
    end
    
    always_ff @(posedge animator_clk) begin
        if(SW[0]) // clear screen
            ps <= idle;
        else
            ps <= ns;
    end

endmodule  // DE1_SoC

module testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	
	DE1_SoC dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		SW[0] <= 1; @(posedge CLOCK_50);
		SW[0] <= 0; repeat(10000) @(posedge CLOCK_50);
						$stop;
		
	end
endmodule