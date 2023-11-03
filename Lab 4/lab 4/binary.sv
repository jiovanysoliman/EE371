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
module binary_tb (); 
    logic clk, start, reset;
    logic [7:0] search; 
    logic [4:0] address;
    logic done, found;

    parameter T = 10;
    initial begin 
        clk <= 1'b0;
        forever #(T / 2) clk <= ~clk;
    end

    binary dut (.*);
    initial begin
        search = 8'd32;
        reset = 1; @(posedge clk);
        reset = 0; @(posedge clk);
        start = 1; @(posedge clk);
        start = 0; @(posedge clk);
        #350
        reset = 1; @(posedge clk);
        reset = 0; @(posedge clk);
        search = 8'd153;
        start = 1; @(posedge clk);
        #350
        $stop;
    end
endmodule