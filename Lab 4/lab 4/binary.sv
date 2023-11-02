module binary #(parameter A = 5) (CLOCK_50, SW, Loc, Done, Found);

input logic CLOCK_50;
input logic [9:0] SW;
output logic [4:0] Loc;
output logic Done;
output logic Found;


seg7 LocOutMSB (.hex(Loc[4]), .leds(HEX1));
seg7 LocOutLSB (.hex(Loc[3:0]), .leds(HEX0));

endmodule 