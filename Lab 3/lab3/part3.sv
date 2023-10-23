module part3 #(parameter N) (CLOCK_50, reset, DataIn, DataOut, 

	input logic [23:0] DataInTop;
	output logic [23:0] DataOutTop;
	logic [23/N:0] divided;
	logic [23/N:0] multiplicator;
	logic [23/N:0] adder1;
	logic [23/N:0] adder2;
	
	// wrong
	logic accumulator;
	
	// wrong
	always_comb begin
		assign divided = {{N{DataInTop[w-1]}}, DataInTop[w-1:n]};
		assign multiplicator = DataOut * -1;
		assign adder1 =  multiplicator + DataInTop;
		assign adder2 = adder1 + ???;
	end

	// wrong
	always_ff @(posedge CLOCK_50) begin
		assign accumulator <= adder2;
		assign DataOutTop <= adder2;
	end 
	
	// Don't know what to use the rd, wr, empty and full for?
	fifo Nbuffer (24, 17) (.clk(CLOCK_50), .reset, .rd(), .wr(), .empty(), .full(), .w_data(divided), .r_data(DataOut));

endmodule