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
    logic isSteep, doneSignal;
	 logic signed [10:0] y_step;
	
	 // absolute value of the difference between x's and y's
	 assign absX = (x1 > x0) ? (x1 - x0) : (x0 - x1);
	 assign absY = (y1 > y0) ? (y1 - y0) : (y0 - y1);

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
		assign deltay = (y1temp2 > y0temp2) ? (y1temp2 - y0temp2) : (y0temp2 - y1temp2); // absolute value
	 
	 always_ff @(posedge clk) begin
		if(reset) begin
			nextX <= x0temp2;
			nextY <= y0temp2;
			error <= -(deltax/2);
			doneSignal <= 0;
		end else if(nextX <= (x1temp2)) begin // for x from x0 to x1 (inclusive)
			nextX <= nextX + 1;
				
			if(isSteep) begin
				x <= nextY;
				y <= nextX;
			end else begin
				x <= nextX;
				y <= nextY;
			end
			
			if(error + deltay >= 0) begin
				nextY <= nextY + y_step;
				error <= error + deltay - deltax;
			end else begin
				nextY <= nextY;
				error <= error + deltay;
			end
			
			if((nextX == x1temp2) && (nextY == y1temp2))
				doneSignal <= 1;
	   end 
	end // always_ff
	 
	 assign done = doneSignal; 

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
	
		// test horizontal line from on screen left to right
//		reset <= 1;	x0 <= 11'd3;  y0 <= 11'd4; x1 <= 11'd15;  y1 <= 11'd4;            			@(posedge clk); // slope = 0
//		reset <= 0;																						 repeat(40) @(posedge clk);
		
		// test horizontal line from on screen right to left
//		reset <= 1;	x0 <= 11'd15;  y0 <= 11'd4; x1 <= 11'd3;  y1 <= 11'd4;            			@(posedge clk); // slope = 0
//		reset <= 0;																						 repeat(40) @(posedge clk);


		// test gradual slope from on screen left to right (positive)
//		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd15; x1 <= 11'd15;  y1 <= 11'd0;            			@(posedge clk); 
//		reset <= 0;																						 repeat(40) @(posedge clk);


		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd450; x1 <= 11'd600;  y1 <= 11'd450;            		 @(posedge clk); 
		reset <= 0;																						 repeat(700) @(posedge clk);
		
		// test diagonal line from on screen left to right
//		reset <= 1;	x0 <= 11'd2;  y0 <= 11'd0; x1 <= 11'd10;  y1 <= 11'd8;                     @(posedge clk); // slope = 1
//		reset <= 0;																			          repeat(40) @(posedge clk);
		
		// test gradual slope left to right -- less steep (negative)
//		reset <= 1; x0 <= 11'd0; y0 <= 11'd0; x1 <= 11'd15;	y1 <= 11'd10; 			            @(posedge clk); // slope < 1
//		reset <= 0;																						 repeat(40) @(posedge clk);


		
		// test gradual slope from left to right -- even less steep (negative)
//		reset <= 1; x0 <= 11'd0; y0 <= 11'd0; x1 <= 11'd15;	y1 <= 11'd5; 			            @(posedge clk); // slope < 1
//		reset <= 0;																						 repeat(40) @(posedge clk);
		
		// test gradual slope from right to left -- even less steep (negative)
//		reset <= 1; x0 <= 11'd15; y0 <= 11'd5; x1 <= 11'd0;	y1 <= 11'd0; 			            @(posedge clk); // slope < 1
//		reset <= 0;																						 repeat(40) @(posedge clk);


		
		// test gradual slope from left to right -- more steep (negative)
//		reset <= 1; x0 <= 11'd0; y0 <= 11'd0; x1 <= 11'd10;	y1 <= 11'd15; 			            @(posedge clk); // slope > 1
//		reset <= 0;																						 repeat(40) @(posedge clk);
		
		// test gradual slope from right to left -- more steep (negative)
//		reset <= 1; x0 <= 11'd10; y0 <= 11'd15; x1 <= 11'd0;	y1 <= 11'd0; 			            @(posedge clk); // slope > 1
//		reset <= 0;																						 repeat(40) @(posedge clk);


		
		// test horizontal line from left to right -- even more steep (negative)
//		reset <= 1; x0 <= 11'd0; y0 <= 11'd0; x1 <= 11'd5;	y1 <= 11'd15; 			               @(posedge clk); // slope > 1
//		reset <= 0;																						 repeat(40) @(posedge clk);
		
		// test horizontal line from right to left -- even more steep (negative)
//		reset <= 1; x0 <= 11'd5; y0 <= 11'd15; x1 <= 11'd0;	y1 <= 11'd0; 			            @(posedge clk); // slope > 1
//		reset <= 0;																						 repeat(40) @(posedge clk);


		
		// test vertical line from on screen
//		reset <= 1; x0 <= 11'd5; y0 <= 11'd0; x1 <= 11'd5;	y1 <= 11'd10; 			               @(posedge clk); // slope = undefined
//		reset <= 0;																						 repeat(40) @(posedge clk);
		
		// test vertical line from off screen
//		reset <= 1; x0 <= 11'd5; y0 <= 11'd11111111110; x1 <= 11'd5;	y1 <= 11'd10; 			   @(posedge clk); // slope = undefined
//		reset <= 0;																						 repeat(40) @(posedge clk);
						
																												$stop;
																								 
	end
	
endmodule 

