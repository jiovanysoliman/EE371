module binary #(parameter InputWidth = 8, parameter LocWidth = 5) (CLOCK_50, A, Start, Reset, Loc, Done, Found);

input logic CLOCK_50;
input logic [InputWidth-1:0] A;
input logic Start;
input logic Reset;
output logic [LocWidth-1:0] Loc;
output logic Done;
output logic Found;
logic [LocWidth-1:0] address;
logic [InputWidth-1:0] q;


RAM_32_8_1port RAM (.address(address), .clock(CLOCK_50), .data(0), .wren(0), .q(q));


endmodule