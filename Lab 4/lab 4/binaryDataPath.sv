`timescale 1 ps / 1 ps
module binaryDataPath (CLOCK_50, compute_M, Set_LSB, Set_MSB, LSB, MSB, M, q, Start, Reset, init, Loc);

input logic CLOCK_50;
input logic Start, Reset, compute_M, Set_LSB, Set_MSB, init;
output logic [4:0] Loc, LSB, MSB, M;
output logic [7:0] q;

always_ff @(posedge CLOCK_50) begin
	if (init) begin
		LSB <= 0;
		M <= 5'd15;
		MSB <= 5'd31;
	end
	if (compute_M) M <= (MSB + LSB) / 2;
	if (Set_LSB) LSB <= M + 1'b1;
	if (Set_MSB) MSB <= M - 1'b1;
end

assign Loc = M;

RAM_32_8_1port RAM (.address(M), .clock(CLOCK_50), .data(0), .wren(0), .q(q));

endmodule