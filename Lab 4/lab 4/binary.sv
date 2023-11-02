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

enum  {idle, waiting, complete} ps, ns;

always_ff @(posedge CLOCK_50) begin
	temp1 <= addresstemp;
	address <= temp1;
end


always_comb begin
	case (ps)
	
		idle: begin
		
//			if (Start) ns = loop; // correct line
			if (Start) ns = idle;  // Just for testing
			else ns = idle;
			Done = 0;
			Found = 0;
		end
		
//		loop: begin
//		
//			
//		
//		end
		
		waiting: begin
		
			if (A == q) begin 
				ns = complete;
				Found = 1;
			end
//			else ns = loop; // correct line
			else ns = idle; // just for testing
			Done = 0;
			Found = 0;
		
		end
		
		complete: begin
		
			ns = complete;
			if (A == q) Found = 1;
			else Found = 0;
			Done = 1;
		
		end
		
		default: begin
			ns = idle;
			Found = 0;
			Done = 0;
		end
	endcase
end 

always_ff @(posedge CLOCK_50) begin

	if (Reset) ps <= idle;
	else ps <= ns;

end



RAM_32_8_1port RAM (.address(address), .clock(CLOCK_50), .data(0), .wren(0), .q(q));


endmodule