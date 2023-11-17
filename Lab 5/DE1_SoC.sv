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
	logic [31:0] divided_clocks;
	logic color;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
// 	assign LEDR[8:0] = SW[8:0];
	
	logic [10:0] x0, y0, x1, y1, x, y;
	logic reset;
	logic [4:0] count;
	
	VGA_framebuffer fb (
		.clk50			(CLOCK_50), 
		.reset			(1'b0), 
		.x(x), 
		.y(y),
		.pixel_color	(1'b1), 
		.pixel_write	(color),
		.VGA_R, 
		.VGA_G, 
		.VGA_B, 
		.VGA_CLK, 
		.VGA_HS, 
		.VGA_VS,
		.VGA_BLANK_n	(VGA_BLANK_N), 
		.VGA_SYNC_n		(VGA_SYNC_N));
				
	logic done;

	always_comb begin
		case(count)
			0: begin
			    color = 1;
				x0 = 120;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			1: begin
			    color = 0;
				x0 = 120;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			2: begin
				color = 1;
				x0 = 320;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			3: begin
				color = 0;
				x0 = 320;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			4: begin
				color = 1;
				x0 = 420;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			5: begin
				color = 0;
				x0 = 420;
				y0 = 200;
				x1 = 320;
				y1 = 300;
			
			end
			
			6: begin
				color = 1;
				x0 = 120;
				y0 = 250;
				x1 = 420;
				y1 = 250;
			
			end
			
			7: begin
				color = 0;
				x0 = 120;
				y0 = 250;
				x1 = 420;
				y1 = 250;
			
			end
			
			
			default: begin
				color = 0;
				x0 = 0;
				y0 = 0;
				x1 = 0;
				y1 = 0;
			
			end
		
		endcase
	
	end
	
	clock_divider cdiv (.clock(CLOCK_50), .divided_clocks);
	
	counter animator (.reset, .clock(divided_clocks[20]), .count);
	
	line_drawer lines (.clk(CLOCK_50), .reset(reset), .x0(x0), .y0(y0), .x1(x1), .y1(y1), .x(x), .y(y), .done(done));
	
	assign LEDR[9] = done;
	assign reset = SW[9];

endmodule  // DE1_SoC
