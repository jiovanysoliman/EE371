`timescale 1 ps / 1 ps
module binaryFSM (CLOCK_50, Reset, Start, exhaustedRAM, Found, gt, Compute_M, Set_LSB, Set_MSB, init);
	// external inputs 
	input logic CLOCK_50;
	input logic Reset, Start;
	
	// status signals
	input logic exhaustedRAM, Found, gt;
	
	// control signals
	output logic Compute_M, Set_LSB, Set_MSB, init;
	
	// define enum states
	enum { idle, loop, done, wait1, wait2, wait3 = 6 } ps, ns;
	
	// next state logic
	always_comb begin
		case(ps)
		
			idle: ns = Start ? loop : idle;
// 			idle: ns = Start ? idle : loop;
			loop: begin
						if(exhaustedRAM)
							ns = done;
						else if(~exhaustedRAM & Found)
							ns = done;
						else // (~exhaustedRAM & ~Found)
//							ns = loop;
							ns = wait1;
					end
			wait1: ns = wait2;
			wait2: ns = wait3;
			wait3: ns = loop;
			done: ns = done; // stay here until user presses Reset
			
			default: ns = idle;
		endcase
	end
	
	// controller logic with synchronous reset
	always_ff @(posedge CLOCK_50) begin
		if(Reset)
			ps <= idle;
		else
			ps <= ns;
	end
	
	// output assignments
	assign Compute_M = (ps == loop) & (gt | ~ gt);
	assign Set_MSB = (ps == loop) & ~gt;
	assign Set_LSB = (ps == loop) & gt;
	assign init = 	(ps == idle) & ~Start;
	
endmodule


`timescale 1 ps / 1 ps
module binaryFSM_tb();
	logic CLOCK_50;
	logic [7:0] A;
	logic Reset, Start;
	logic exhaustedRAM, Found, gt;
	logic Compute_M, Set_LSB, Set_MSB, init;
	
	binaryFSM dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		// test all paths of controller logic -- finding actual target value does not matter
		Reset <= 1; Start <= 0;                   exhaustedRAM <= 0; Found <= 0; gt <= 0;			  @(posedge CLOCK_50);
		Reset <= 0; 													  													  @(posedge CLOCK_50);
						Start <= 1;																				 repeat(3) @(posedge CLOCK_50);
																exhaustedRAM <= 0; Found <= 0; gt <= 1; repeat(3) @(posedge CLOCK_50);
																exhaustedRAM <= 0; Found <= 1; gt <= 0; repeat(3) @(posedge CLOCK_50);
		Reset <= 1; Start <= 0;																				 repeat(3) @(posedge CLOCK_50);
		Reset <= 0; Start <= 1;																				           @(posedge CLOCK_50);
																exhaustedRAM <= 0; Found <= 1; gt <= 1; repeat(3) @(posedge CLOCK_50);
		Reset <= 1; Start <= 0;																				 repeat(3) @(posedge CLOCK_50);
		Reset <= 0; Start <= 1;																							  @(posedge CLOCK_50);
																exhaustedRAM <= 1; Found <= 0; gt <= 0; repeat(3) @(posedge CLOCK_50);
		Reset <= 1; Start <= 0;																				 repeat(3) @(posedge CLOCK_50);
		Reset <= 0; Start <= 1;																				           @(posedge CLOCK_50);
																exhaustedRAM <= 1; Found <= 0; gt <= 1; repeat(3) @(posedge CLOCK_50);
		Reset <= 1; Start <= 0;																				 repeat(3) @(posedge CLOCK_50);
		Reset <= 0; Start <= 1;																				           @(posedge CLOCK_50);
																exhaustedRAM <= 1; Found <= 1; gt <= 0; repeat(3) @(posedge CLOCK_50);
		Reset <= 1; Start <= 0;																				 repeat(3) @(posedge CLOCK_50);
		Reset <= 0; Start <= 1;																				 			  @(posedge CLOCK_50);
																exhaustedRAM <= 1; Found <= 1; gt <= 1; repeat(3) @(posedge CLOCK_50);
																																  $stop;
	end
endmodule

//`timescale 1 ps / 1 ps
//module binaryFSM (CLOCK_50, A, Start, compute_M, Set_LSB, Set_MSB, init, LSB, MSB, M, Reset, Done, Found);

//// external inputs
//input logic CLOCK_50, Start, Reset;
//input logic [7:0] A; 
//
////// inputs from datapath
////input logic [7:0] q;
//output logic Done, Found; // status signals
//output logic compute_M, Set_LSB, Set_MSB, init; // control signals
//input logic [4:0] LSB, MSB, M;
//
//enum logic [2:0] {idle, loop, complete} ps, ns;
//
//always_comb begin
// 	case (ps)
//		idle: begin
//			compute_M = 0;
//			Set_MSB = 0;
//			Set_LSB = 0;
//			init = 1;
//			Done = 0;
//			Found = 0;
//			if (Start) ns = loop; 
//			else ns = idle;
//		end
//		loop: begin
//			compute_M = 1;
//			init = 0;
//			Done = 0;
//			Found = 0;
//			Set_MSB = 0; 
//			Set_LSB = 0;
//			if (MSB != LSB) begin
//				if (q > A) Set_MSB = 1;
//				if (q < A) Set_LSB = 1;
//				ns = loop;
//			end
//			ns = complete;
//		end
//
//		complete: begin
//			compute_M = 0;
//			Set_MSB = 0;
//			Set_LSB = 0;
//			init = 0;
//			Done = 1;
//			if (q == A) Found = 1;
//			else Found = 0;
//			ns = complete;
//		end
//		default: begin
//			compute_M = 0;
//			Set_MSB = 0;
//			Set_LSB = 0;
//			init = 0;
//			Done = 0;
//			Found = 0;
//			ns = idle;
//		end
//	endcase
//end 
//
//always_ff @(posedge CLOCK_50) begin
//	if (Reset) ps <= idle;
//	else ps <= ns;
//end

//endmodule 