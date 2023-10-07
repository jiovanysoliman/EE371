// Module that implments a FSM to keep track of the number of cars in the parking lot.
// Max occupancy in parking lot is 16.
// 1 bit inputs are clk, reset, incr, decr
// 7 bits outputs are HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
module car_counter(clk, reset, incr, decr, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input logic clk, reset, incr, decr; // Initialize inputs
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Initialize outputs
    
    // enumerate the possible values for ps and ns
    enum {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16} ps, ns; // Simple PS, NS Counter FSM
    
    //Next state logic based on state diagram
    always_comb begin
        case (ps)
            S0: begin // Clear0
                HEX0 = 7'b1000000;
                HEX1 = 7'b0101111;
                HEX2 = 7'b0001000;
                HEX3 = 7'b0000110;
                HEX4 = 7'b1000111;
                HEX5 = 7'b1000110;
                if (incr == 1 && decr == 0) ns = S1; // Increment if car enters
                else if (incr == 0 && decr == 1) ns = S0; // Decrement if car leaves
                else ns = ps;
            end
            
            S1: begin //1
                HEX0 = 7'b1111001;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S2;
                else if (incr == 0 && decr == 1) ns = S0;
                else ns = ps;
            end
            
            S2: begin //2
                HEX0 = 7'b0100100;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S3;
                else if (incr == 0 && decr == 1) ns = S1;
                else ns = ps;
            end
            
            S3: begin //3
                HEX0 = 7'b0110000;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S4;
                else if (incr == 0 && decr == 1) ns = S2;
                else ns = ps;
            end
            
            S4: begin //4
                HEX0 = 7'b0011001;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S5;
                else if (incr == 0 && decr == 1) ns = S3;
                else ns = ps;
            end
            
            S5: begin //5
                HEX0 = 7'b0010010;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S6;
                else if (incr == 0 && decr == 1) ns = S4;
                else ns = ps;
            end
            
            S6: begin //6
                HEX0 = 7'b0000010;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S7;
                else if (incr == 0 && decr == 1) ns = S5;
                else ns = ps;
            end
            
            S7: begin //7
                HEX0 = 7'b1111000;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S8;
                else if (incr == 0 && decr == 1) ns = S6;
                else ns = ps;
            end
            
            S8: begin //8
                HEX0 = 7'b0000000;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S9;
                else if (incr == 0 && decr == 1) ns = S7;
                else ns = ps;
            end
            
            S9: begin //9
                HEX0 = 7'b0011000;
                HEX1 = 7'b1000000;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S10;
                else if (incr == 0 && decr == 1) ns = S8;
                else ns = ps;
            end
            
            S10: begin //10
                HEX0 = 7'b1000000;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S11;
                else if (incr == 0 && decr == 1) ns = S9;
                else ns = ps;
            end
            
            S11: begin //11
                HEX0 = 7'b1111001;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S12;
                else if (incr == 0 && decr == 1) ns = S10;
                else ns = ps;
            end
            
            S12: begin //12
                HEX0 = 7'b0100100;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S13;
                else if (incr == 0 && decr == 1) ns = S11;
                else ns = ps;
            end
            
            S13: begin //13
                HEX0 = 7'b0110000;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S14;
                else if (incr == 0 && decr == 1) ns = S12;
                else ns = ps;
            end
            
            S14: begin //14
                HEX0 = 7'b0011001;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S15;
                else if (incr == 0 && decr == 1) ns = S13;
                else ns = ps;
            end
            
            S15: begin //15
                HEX0 = 7'b0010010;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1111111;
                HEX3 = 7'b1111111;
                HEX4 = 7'b1111111;
                HEX5 = 7'b1111111;
                if (incr == 1 && decr == 0) ns = S16;
                else if (incr == 0 && decr == 1) ns = S14;
                else ns = ps;
            end
            
            S16: begin // Full16
                HEX0 = 7'b0000010;
                HEX1 = 7'b1111001;
                HEX2 = 7'b1000111;
                HEX3 = 7'b1000111;
                HEX4 = 7'b1000001;
                HEX5 = 7'b0001110;
                if (incr == 1 && decr == 0) ns = S16;
                else if (incr == 0 && decr == 1) ns = S15;
                else ns = ps;
            end
            
            default: ns = S0;
        endcase
    end
    
    //sequential logic (DFFs)
    always_ff @(posedge clk) begin
        if (reset == 1) ps <= S0;
		else ps <= ns;
	end
    
endmodule // car_counter

// testbench for the car counter module
module car_counter_tb();
	logic clk, reset, incr, decr;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	car_counter dut (.*);
	
	// Set up a simulated clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		
		reset <= 1;												@(posedge clk);
		reset <= 0; incr <= 0; decr <= 0; repeat(2)  @(posedge clk);
						incr <= 1;				 repeat(17) @(posedge clk);
		reset <= 1; 											@(posedge clk);
		reset <= 0; incr <= 0; decr <= 0; repeat(2)  @(posedge clk);
									  decr <= 1; repeat(17) @(posedge clk);
																	$stop;
	end
endmodule //car_counter_tb
	
	