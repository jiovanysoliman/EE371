module counter(reset, clk, addr);
	output logic [4:0] addr; // address of memory location being read
	input  logic reset, clk;
	
	always_ff @(posedge clk) begin
		if(reset)
			addr <= 5'b0;
		else
			begin
				if(addr == 5'b11111)
					addr <= 5'b0;
				else
					addr <= addr + 5'b00001;
			end
	end // always_ff
endmodule
