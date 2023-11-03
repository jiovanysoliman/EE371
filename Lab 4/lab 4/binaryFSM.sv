module binaryFSM (CLOCK_50, A, q, Start, compute_M, Set_LSB, Set_MSB, init, LSB, MSB, M, Reset, Done, Found);

input logic CLOCK_50,Start, Reset;
input logic [7:0] A, q;
output logic Done, Found; // status signals
output logic compute_M, Set_LSB, Set_MSB, init; // control signals
input logic [4:0] LSB, MSB, M;

enum logic [2:0] {idle, loop, complete} ps, ns;

always_comb begin
 	case (ps)
		idle: begin
			compute_M = 0;
			Set_MSB = 0;
			Set_LSB = 0;
			init = 1;
			Done = 0;
			Found = 0;
			if (Start) ns = loop; 
			else ns = idle;
		end
		loop: begin
			compute_M = 1;
			init = 0;
			Done = 0;
			Found = 0;
			Set_MSB = 0; 
			Set_LSB = 0;
			if (MSB != LSB) begin
				if (q > A) Set_MSB = 1;
				if (q < A) Set_LSB = 1;
				ns = loop;
			end
			ns = complete;
		end

		complete: begin
			compute_M = 0;
			Set_MSB = 0;
			Set_LSB = 0;
			init = 0;
			Done = 1;
			if (q == A) Found = 1;
			else Found = 0;
			ns = complete;
		end
		default: begin
			compute_M = 0;
			Set_MSB = 0;
			Set_LSB = 0;
			init = 0;
			Done = 0;
			Found = 0;
			ns = idle;
		end
	endcase
end 

always_ff @(posedge CLOCK_50) begin
	if (Reset) ps <= idle;
	else ps <= ns;
end

endmodule 