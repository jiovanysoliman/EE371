module counter(mem_select, task1mem, task2mem, reset, clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	output logic [2:0] wordContent;
	input  logic mem_select, reset, clk;
	input  logic [2:0] task1mem [31:0];
	input  logic [2:0] task2mem [31:0];
	logic  [4:0] addr; // address of memory location being read
	
	always_ff @(posedge clk) begin
		if(reset)
			addr <= 5'b0;
		else
			begin
				if(addr == 5'b11111)
					addr <= 5'b0;
				else
					begin
					addr <= addr + 5'b00001;
					
					if(mem_select = 0) 
						begin// access task1mem
							wordContent <= task1mem[addr]; 
						end
					else // mem_select = 1 --> access task2mem
						begin
							wordContent <= task2mem[addr];
						end
					end
			 end
	end // always_ff
endmodule