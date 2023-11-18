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
	 
	 // temp variables for line corrections
	 logic [10:0] x0temp1, y0temp1, x1temp1, y1temp1;
	 logic [10:0] x0temp2, y0temp2, x1temp2, y1temp2;
	 
	 // variables for x and y coordinate assignments
	 logic [10:0] nextX, nextY;
	 
	 // pther variables for line drawing algorithm
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
		
		// deterine if y will decrement or increment 
		if(y0temp2 < y1temp2) 
			y_step = 1;
		else
			y_step = -1;
			
	 end // always_comb
	 
	 // calculate detlax and deltay for the algorithm
	 assign deltax = (x1temp2 - x0temp2); 
	 assign deltay = (y1temp2 > y0temp2) ? (y1temp2 - y0temp2) : (y0temp2 - y1temp2); // absolute value
	 
	 always_ff @(posedge clk) begin
		if(reset) begin // reset state, initialize nextX and nextY, error, and doneSignal
			nextX <= x0temp2;
			nextY <= y0temp2;
			error <= -(deltax/2);
			doneSignal <= 0;
		end else if(nextX <= (x1temp2)) begin // for x from x0 to x1 (inclusive)
			nextX <= nextX + 1;
				
			// swap x and y if the slope is steep (prevents multiple y's from being assigned to a single x)
			if(isSteep) begin 
				x <= nextY;
				y <= nextX;
			end else begin
				x <= nextX;
				y <= nextY;
			end
			
			// algorithm to determine if y should be stepped or not for best approximation of the line
			if(error + deltay >= 0) begin
				nextY <= nextY + y_step;
				error <= error + deltay - deltax;
			end else begin
				nextY <= nextY;
				error <= error + deltay;
			end
			
			// if we reached the end point, then line is done drawing
			if((nextX == x1temp2) && (nextY == y1temp2))
				doneSignal <= 1;
	   end // end (nextX <= (x1temp2)
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
	
		// test vertical both ways: A(5,0) B(5,10)
		reset <= 1;	x0 <= 11'd5;  y0 <= 11'd0; x1 <= 11'd5;  y1 <= 11'd10;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd5;  y0 <= 11'd10; x1 <= 11'd5;  y1 <= 11'd0;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test horizontal both ways: A(10, 20) B(20,20)
		reset <= 1;	x0 <= 11'd10;  y0 <= 11'd20; x1 <= 11'd20;  y1 <= 11'd20;                  @(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd20;  y0 <= 11'd20; x1 <= 11'd10;  y1 <= 11'd20;           			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test diagonal both ways (positive): A(0,10) B(10,0)
		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd10; x1 <= 11'd10;  y1 <= 11'd0;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd10;  y0 <= 11'd0; x1 <= 11'd0;  y1 <= 11'd10;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test diagonal both ways (negative): A(0,0) B(10,10)
		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd0; x1 <= 11'd10;  y1 <= 11'd10;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd10;  y0 <= 11'd10; x1 <= 11'd0;  y1 <= 11'd0;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test left-up and right-down, steep slope, both ways: A(1,15) B(3,3)
		reset <= 1;	x0 <= 11'd1;  y0 <= 11'd15; x1 <= 11'd3;  y1 <= 11'd3;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd3;  y0 <= 11'd3; x1 <= 11'd1;  y1 <= 11'd15;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test left-up and right-down, gradual slope, both ways: A(1,15) B(10,10)
		reset <= 1;	x0 <= 11'd1;  y0 <= 11'd15; x1 <= 11'd10;  y1 <= 11'd10;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd10;  y0 <= 11'd10; x1 <= 11'd1;  y1 <= 11'd15;             		@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test right-up and left-down, steep slope, both ways: A(0,0) B(5,10)
		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd0; x1 <= 11'd5;  y1 <= 11'd10;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd5;  y0 <= 11'd10; x1 <= 11'd0;  y1 <= 11'd0;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		
		// test right-up and left-down, gradual slope, both ways: A(0,0) B(10,5)
		reset <= 1;	x0 <= 11'd0;  y0 <= 11'd0; x1 <= 11'd10;  y1 <= 11'd5;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
		reset <= 1;	x0 <= 11'd10;  y0 <= 11'd5; x1 <= 11'd0;  y1 <= 11'd0;            			@(posedge clk);
		reset <= 0;																						 repeat(20) @(posedge clk);
																												$stop;
																								 
	end
	
endmodule 

