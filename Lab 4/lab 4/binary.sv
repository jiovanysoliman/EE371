module binary #(parameter InputWidth = 8, parameter LocWidth = 5) (CLOCK_50, A, Start, Reset, Loc, Done, Found);

input logic CLOCK_50;
input logic [InputWidth-1:0] A;
input logic Start;
input logic Reset;
output logic [LocWidth-1:0] Loc;
output logic Done;
output logic Found;
logic [LocWidth-1:0] address, addresstemp, temp1;
logic [InputWidth-1:0] q;


always_ff @(posedge CLOCK_50) begin
	temp1 <= addresstemp;
	address <= temp1;
end


always_comb begin

	if (A == q) begin
		Loc = address;
		Done = 1;
		Found = 1;
	end
	
//	elseif (Start && ~Done) begin 
//		addresstemp = 5'b01111;
//		if (A > q) addresstemp = 5'b10111;
//		elseif (A < q) addresstemp = 5'b1000;
//	end
	
	else begin
		Done = 1;
		Found = 0;
	end
	
end 



RAM_32_8_1port RAM (.address(address), .clock(CLOCK_50), .data(0), .wren(0), .q(q));


endmodule