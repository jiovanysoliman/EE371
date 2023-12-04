module buttons (clk, button, b);
	
	input logic clk, button;
	output logic b;
	
	enum {off, pe, on} ps, ns;
	
	always_comb begin
		case(ps)
		
			off: begin
				b = 0;
				if (button == 1) ns = pe;
				else ns = off; 
			end
			
			pe: begin
				b = 1;
				if (button == 1) ns = on;
				else ns = off;
			end
			
			on: begin
				b = 0;
				if (button == 0) ns = off;
				else ns = on;
			end
		
		endcase
	end
	
	always_ff @(posedge clk) begin
		ps <= ns;
	end
	
endmodule