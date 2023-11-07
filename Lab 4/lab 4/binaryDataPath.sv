// Module to implement the data path portion of task 2; binary data search.
// CLOCK_50, Compute_M, Set_LSB, Set_MSB, init are single bit inputs.
// A is an 8 bit input
// Loc is a 5 bit output
// DONE is a single bit output
`timescale 1 ps / 1 ps
module binaryDataPath (CLOCK_50, A, Compute_M, Set_LSB, Set_MSB, init, exhaustedRAM, gt, Found, Loc, DONE);

	// external inputs
	input logic CLOCK_50;
	input logic [7:0] A;
	
	// control signals (inputs)
	input logic Compute_M, Set_LSB, Set_MSB, init;
	
	// status signals (outputs)
	output logic exhaustedRAM, gt, Found; // Found will also be an external output
	
	// external outputs
	output logic [4:0] Loc;
	output logic DONE;
	
	// internal variables
	logic [4:0] LSB, MSB, M;
	logic [7:0] q;
	logic [7:0] target;

	// datapath logic
	always_ff @(posedge CLOCK_50) begin
		if (init) begin
			LSB <= 0;
			M <= 5'd15;
			MSB <= 5'd31;
			target <= A;
		end
		
		if (Compute_M)
			M <= (MSB + LSB) / 2;
		if (Set_LSB) 
			LSB <= M + 1'b1;
		if (Set_MSB) 
			MSB <= M - 1'b1;
	end
	
	// retrieve value to compare
	RAM_32_8_1port RAM (.address(M), .clock(CLOCK_50), .data(0), .wren(0), .q(q));

	assign exhaustedRAM = (MSB == LSB);
	assign gt = (target > q);
	assign Found = (target == q);
	assign DONE = (MSB == LSB) | Found; // can be DONE without having found the target 
	assign Loc = M;

endmodule // binaryDataPath

`timescale 1 ps / 1 ps
module binaryDataPath_tb();
	logic CLOCK_50;
	logic [7:0] A;
	logic Compute_M, Set_LSB, Set_MSB, init;
	logic exhaustedRAM, gt, Found;
	logic [4:0] Loc;
	logic DONE;
	
	binaryDataPath dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		A <= 8'b00000100; Compute_M <= 0; Set_LSB <= 0; Set_MSB <= 0; init <= 0; repeat(2) @(posedge CLOCK_50);
																						  init <= 1;           @(posedge CLOCK_50);
							   Compute_M <= 1; init <= 0; 			  @(posedge CLOCK_50);
								
	end
endmodule // binaryDataPath_tb