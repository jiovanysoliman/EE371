/* Given two points on the screen this module draws a line between
 * those two points by coloring necessary pixels
 *
 * Inputs:
 *   clk    - should be connected to a 50 MHz clock
 *   reset  - resets the module and starts over the drawing process
 *	  x0 	- x coordinate of the first end point
 *   y0 	- y coordinate of the first end point
 *   x1 	- x coordinate of the second end point
 *   y1 	- y coordinate of the second end point
 *
 * Outputs:
 *   x 		- x coordinate of the pixel to color
 *   y 		- y coordinate of the pixel to color
 *   done	- flag that line has finished drawing
 *
 */
module line_drawer(clk, reset, x0, y0, x1, y1, x, y, done);
	input logic clk, reset;
	input logic [10:0]	x0, y0, x1, y1;
	output logic done;
	output logic [10:0]	x, y;
	
	/* You'll need to create some registers to keep track of things
    * such as error and direction.
    */
	 
	 logic [10:0] x0temp1, y0temp1, x1temp1, y1temp1;
	 logic [10:0] x0temp2, y0temp2, x1temp2, y1temp2;
	 logic [10:0] nextX, nextY;
	 logic [10:0] absX, absY;
    logic signed [11:0] error, deltax, deltay;
    logic isSteep;
	 logic signed [10:0] y_step;
	
	 // absolute value of the difference between x's and y's
	 assign absX = (x1 > x0) ? (x1 - x0) : (x0 - x1);
	 assign absY = (y1 > y0) ? (y1 - y0) : (y0 - y1);
	 
	 
//    assign error = ~(deltax / 2);
//    assign y_step = y0 < y1 ? -1 : 1;

	 assign isSteep = absY > absX;	 
	 
	 // swap (x0, y0) and (x1, y1)
	 always_comb begin
		if(isSteep) begin			
				x0temp1 = y0;
				y0temp1 = x0;
				x1temp1 = y1;
				y1temp1 = x1;
		end else begin
				x0temp1 = x0;
				x1temp1 = x1;
				y0temp1 = y0;
				y1temp1 = y1;
		end
		
		// swap (x0, x1) and (y0, y1)
		if(x0temp1 > x1temp1) begin
				x0temp2 = x1temp1;
				x1temp2 = x0temp1;
				y0temp2 = y1temp1;
				y1temp2 = y0temp1;
		end else begin
				x0temp2 = x0temp1;
				x1temp2 = x1temp1;
				y0temp2 = y0temp1;
				y1temp2 = y1temp1;
		end		
		
		if(y0temp2 < y1temp2) 
			y_step = 1;
		else
			y_step = -1;
			
	 end // always_comb
	 
	 // deltaX is always positive (after the correction from x0 > x1)
		assign deltax = (x1temp2 - x0temp2); 
		assign deltay = absY;
	 
	 always_ff @(posedge clk) begin
		if(reset) begin
			nextX <= x0temp2;
			nextY <= y0temp2;
			error <= -(deltax/2);
		end else if(nextX <= (x1temp2)) begin // for x from x0 to x1 (inclusive)
			nextX <= nextX + 1;
			
			if(isSteep) begin
				x <= nextY;
				y <= nextX;
				error <= error + deltay;
			end else begin
				x <= nextX;
				y <= nextY;
				error <= error + deltay;
			end
			
			if(error >= 0) begin
				nextY <= nextY + y_step;
				error <= error - deltax;
			end else begin
				nextY <= nextY;
				error <= error - deltax;
			end
	   end
	end // always_ff
	 
	 assign done = (nextX == x1) && (nextY == y1); 

endmodule
	



module tb();
	logic clk, reset;
	logic [10:0]	x0, y0, x1, y1;
	logic done;
	logic [10:0]	x, y;
	
	line_drawer dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	
		reset <= 1;	x0 <= 11'd2;  y0 <= 11'd0; x1 <= 11'd10;  y1 <= 11'd0; @(posedge clk);
		reset <= 0;																			 repeat(20) @(posedge clk);
																								 @(posedge clk); // test horizontal line
																								 $stop;
																								 
	end
	
endmodule 

