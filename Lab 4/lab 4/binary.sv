`timescale 1 ps / 1 ps
module binary (CLOCK_50, A, Start, Reset, Done, Found);

	input logic CLOCK_50,Start, Reset;
	input logic [7:0] A;
	output logic Done, Found; // status signals
	logic compute_M, Set_LSB, Set_MSB, init; // control signals
	logic [4:0] Loc, LSB, MSB, M;
	logic [7:0] q;

	binaryFSM FSM (.*);
	binaryDataPath Data (.*);

endmodule

// *****************************************************
// NOT OUR CODE, JUST FOR TESTING PURPOSE. DO NOT SUBMIT.
// *****************************************************
`timescale 1 ps / 1 ps
module binary_tb (); 
    logic CLOCK_50, Start, Reset,Done, Found;
    logic [7:0] A; 

    parameter T = 10;
    initial begin 
        CLOCK_50 <= 1'b0;
        forever #(T / 2) CLOCK_50 <= ~CLOCK_50;
    end

    binary dut (.*);
	 
    initial begin
        A = 8'd4;
        Reset = 1; @(posedge CLOCK_50);
        Reset = 0; @(posedge CLOCK_50);
        Start = 1; @(posedge CLOCK_50);
        Start = 0; @(posedge CLOCK_50);
        #350
        Reset = 1; @(posedge CLOCK_50);
        Reset = 0; @(posedge CLOCK_50);
        A = 8'd153;
        Start = 1; @(posedge CLOCK_50);
        #350
        $stop;
    end
endmodule