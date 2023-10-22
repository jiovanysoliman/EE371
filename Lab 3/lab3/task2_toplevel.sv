module task2_toplevel (CLOCK_50, SW)

input logic CLOCK_50;
input logic [9:0] SW;
logic output1, output2;
output logic topOutput;



part1 task1 ();
part2 task2 ();

assign topOutput = SW[0] ? output2 : output1;

endmodule