module part3 #(parameter N = 8) (CLOCK_50, reset, DataInTop, DataOutTop); 

	input logic [23:0] DataInTop;
	output logic [23:0] DataOutTop;
	logic [23:0] DataOut;
	input logic CLOCK_50, reset;
	logic [23:0] divided;
	logic [23:0] multiplicator;
	logic [23:0] adder1;
	logic [23:0] adder2;
	logic full;
	logic [23:0] accumulator;
	logic empty;
	
	always_comb begin
		divided = {{N{DataInTop[23]}}, DataInTop[23:N]};
		multiplicator = DataOut * 24'sb1;
		adder2 = multiplicator + divided + accumulator;
		DataOutTop = adder2;
	end

	always_ff @(posedge CLOCK_50) begin
		if (reset) accumulator <= 0;
		else accumulator <= adder2;
	end 
	

	fifo #(24, 17) Nbuffer (.clk(CLOCK_50), .reset, .rd(full), .wr(1), .empty, .full, .w_data(divided), .r_data(DataOut));

endmodule