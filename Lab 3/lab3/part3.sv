module part3 #(parameter N = 8) (CLOCK_50, reset, DataInTop, DataOutTop); 

	input logic [23:0] DataInTop;
	output logic [23:0] DataOutTop;
	logic [23:0] DataOut;
	input logic CLOCK_50, reset;
	logic [23:0] divided;
	logic [23:0] multiplicator;
	logic [23:0] adder2;
	logic full;
	logic [23:0] accumulator;
	logic empty;
	
	always_comb begin
		divided = {{N{DataInTop[23]}}, DataInTop[23:N]};
//		multiplicator = DataOut * 24'sb1;
        multiplicator = DataOut * -1;
		adder2 = multiplicator + divided + accumulator;
		DataOutTop = adder2;
	end

	always_ff @(posedge CLOCK_50) begin
		if (reset) accumulator <= 0;
		else accumulator <= adder2;
	end 

//	always_ff @(posedge CLOCK_50) begin
//		if(reset) begin
//			adder2 <= 0;
//			accumulator <= 0;
//		end else begin
//			adder2 <= multiplicator + divided;
//			accumulator <= accumulator + adder2;
//		end
//	end
	
	// if we want 8 samples, we need fifo to have 8 addresses (2^3 = 8), otherwise fifo will have 2^8 = 256 addresses?
	fifo #(24, 3) Nbuffer (.clk(CLOCK_50), .reset, .rd(full), .wr(1), .empty, .full, .w_data(divided), .r_data(DataOut));

endmodule

module part3_tb();
	logic [23:0] DataInTop;
	logic [23:0] DataOutTop;
	logic CLOCK_50, reset;
	
	part3 dut(.*);
	
	parameter CLOCK_PERIOD = 10; // arbitrary choice
	initial begin
	CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	
	initial begin
		reset <= 1; DataInTop <= 24'h4ca431; @(posedge CLOCK_50);
		reset <= 0; 								 @(posedge CLOCK_50);
						DataInTop <= 24'h000192; @(posedge CLOCK_50);
						DataInTop <= 24'h5110ca; @(posedge CLOCK_50);
						DataInTop <= 24'h32a33c; @(posedge CLOCK_50);
						DataInTop <= 24'h366fe4; @(posedge CLOCK_50);
						DataInTop <= 24'h7a47e9; @(posedge CLOCK_50);
						DataInTop <= 24'hce9f00; @(posedge CLOCK_50);
						DataInTop <= 24'h55b19c; @(posedge CLOCK_50);
						DataInTop <= 24'he99233; @(posedge CLOCK_50);
						DataInTop <= 24'hb835eb; @(posedge CLOCK_50);
						DataInTop <= 24'hbfe8ea; @(posedge CLOCK_50);
						DataInTop <= 24'h81f084; @(posedge CLOCK_50);
						DataInTop <= 24'h689236; @(posedge CLOCK_50);
						DataInTop <= 24'hde03a7; @(posedge CLOCK_50);
						DataInTop <= 24'hfadb37; @(posedge CLOCK_50);
						DataInTop <= 24'h7480e6; @(posedge CLOCK_50);
						DataInTop <= 24'h36389c; @(posedge CLOCK_50);
						DataInTop <= 24'hcd4758; @(posedge CLOCK_50);
						DataInTop <= 24'h647677; @(posedge CLOCK_50);
						DataInTop <= 24'hb6d10e; @(posedge CLOCK_50);
						DataInTop <= 24'h4dab5b; @(posedge CLOCK_50);
						DataInTop <= 24'h38f7f6; @(posedge CLOCK_50);
						DataInTop <= 24'h716880; @(posedge CLOCK_50);
						DataInTop <= 24'h9c44ae; @(posedge CLOCK_50);
						DataInTop <= 24'hf1f3c7; @(posedge CLOCK_50);
						DataInTop <= 24'h2579f9; @(posedge CLOCK_50);
						DataInTop <= 24'hce9e9d; @(posedge CLOCK_50);
						DataInTop <= 24'h6eefd7; @(posedge CLOCK_50);
						DataInTop <= 24'h834c05; @(posedge CLOCK_50);
						DataInTop <= 24'h19a12c; @(posedge CLOCK_50);
						DataInTop <= 24'he3beba; @(posedge CLOCK_50);
													    $stop;

	end
endmodule 