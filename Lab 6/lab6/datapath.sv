/*
This is the game datapath module for our number sequence memory game that performs computations 
based on control signals from the game control module and sends status signals back.

EXTERNAL INPUTS
	clk--- system clock
	reset- reset the game
	
INPUTS FROM CONTROL (CONTROL SIGNALS)
	init_show_counter-- show counter is initialized to 1 and ranges from 0 to 1
   reset_clk---------- reset the divided clock to 25 when the game begins/restarts
	init_lives--------- number of lives the user has is initialized to 3 and has a range from 0 to 3
	init_seq_counter--- sequence counter is initialized to 0 and has a range from 0 to 7
	init_user_counter-- user counter is initialized to 0 and has a range from 0 to 7
	init_level--------- level is initialized to 1
	init_match_counter- match counter is initialized to 0 and ranges from 0 to 7
	store_num---------- true when we want to store a generated number as part of the sequence
	incr_seq_counter--- sequence counter is incremented by 1
	incr_user_counter-- user counter is incremented by 1
	read_seq----------- true when the generated number sequence must be displayed on the VGA
	store_input-------- true when we want to store the user's input as part of their sequence
	decr_show_counter-- show counter is decremented
	read_input--------- true when we want to read the user's sequence and compare to the generated sequence
	decr_lives--------- lives is decremented by 1
	decr_clk----------- clock divider is decremented by 1 (clock is speed up)
	incr_level--------- player may advance to the next level
	keyVal------------- user's input value to be stored as part of their sequence

OUTPUTS TO CONTROL (STATUS SIGNALS)
	seq_end----------- true when 
	end_comp---------- true when all user and generated sequence values have been compared
	show_counter_zero- true when the user cannot repeat the sequence again until the next sequence
	full_input-------- true when the user has entered 7 numbers 
	no_lives---------- true when the user has no more lives
	match------------- true when the user's input sequence matches the generated number sequence
	clk_zero---------- true when the clock cannot be further divided (has reached its fastest speed)
	seq_num----------- used to display the corresponding generated number on the VGA 
	
EXTERNAL OUTPUTS 
	level- what level the user is currently on
	lives- how many lives the player has left
*/

module datapath(clk, 
					 reset, 
					 init_show_counter, 
					 reset_clk, 
					 init_lives, 
					 init_seq_counter, 
					 init_user_counter,
					 init_level,
					 init_match_counter, 
					 store_num, 
					 incr_seq_counter,
					 incr_user_counter,
					 read_seq, 
					 store_input, 
					 decr_show_counter, 
					 read_input, 
					 decr_lives, 
					 decr_clk, 
					 incr_level, 
					 keyVal,
					 seq_end,
					 end_comp,
					 show_counter_zero, 
					 full_input, 
					 no_lives, 
					 match, 
					 clk_zero,
					 seq_num, 
					 level,
					 lives,
					 next_clk);
					 
// PORT DEFINITIONS			 
	// CONTROL SIGNALS (INPUTS)
	input  logic clk, reset, init_show_counter, reset_clk, init_lives, init_seq_counter, init_level, store_num, incr_seq_counter, init_match_counter;
	input  logic read_seq, store_input, decr_show_counter, read_input, decr_lives, decr_clk, incr_level, init_user_counter, incr_user_counter;
	input  logic [1:0] keyVal;
	
	// STATUS SIGNALS (OUTPUTS)
	output logic seq_end, show_counter_zero, full_input, no_lives, match, clk_zero, end_comp, next_clk;
	output logic [1:0] seq_num, lives;
	
	// EXTERNAL OUTPUTS 
	output logic [2:0] level;
	 
	// clock divider
	logic [31:0] divClocks;
	logic [4:0] clk_select;
//	logic next_clk;
	
	clock_divider cd (.clock(clk), .divided_clocks(divClocks));
	
	assign next_clk = divClocks[clk_select]; // slower clock to use
	
	// LFSR for random number generation
	logic [1:0] lfsr_num; // num is input from LFSR
	
	LSFR10 numGen (.mod(lfsr_num), .clk(clk), .reset(reset));
	
	// 2D array for random sequence
	logic [6:0][1:0] seq; // 7 packets of 2 bits
	
	// 2D array for user input sequence
	logic [6:0][1:0] user_seq; // 7 packets of 2 bits
	
	// counters 
	logic [2:0] seq_counter, user_counter, match_counter;
	logic show_counter;
	
// DATAPATH LOGIC
	always_ff @(posedge clk) begin
	
		// show counter only allows player to replay the sequence on the VGA once per sequence
		if(init_show_counter)
			show_counter <= 1;
		else if(decr_show_counter)
			show_counter <= show_counter - 1;
		
		// seq_counter is used to iterate through the generated sequence
		if(init_seq_counter)
			seq_counter <= 0;
		else if(incr_seq_counter)
			seq_counter <= seq_counter + 1;
			
		// user_counter is used to iterate through the user sequence
		if(init_user_counter)
			user_counter <= 0;
		else if(incr_user_counter)
			user_counter <= user_counter + 1;
			
		// match counter is used to determine if user sequence matches generated sequence
		if(init_match_counter)
			match_counter <= 0;
		
		// clk_select determines the difficulty of next level
		if(reset_clk)
			clk_select <= 25; // 0.75Hz
		else if(decr_clk)
			clk_select <= clk_select - 1;
			
		// level is sent to the hex displays so the user can see what level they are on
		if(init_level)
			level <= 1;
		else if(incr_level)
			level <= level + 1;
			
		// store_num allows us to record the generated sequence
		if(store_num)
			seq[seq_counter] <= lfsr_num;
		else if(read_seq)
			seq_num <= seq[seq_counter];
			
		// store_input allows us to record/write the user's input (but only if one key is pressed at a time)
		if(store_input)	
			user_seq[user_counter] <= keyVal;
		else if(read_input) begin
			if(user_seq[user_counter] == seq[seq_counter])
				match_counter <= match_counter + 1;
		end
	end
	
// OUTPUT ASSIGNMENTS
	assign end_comp = ((user_counter == 7) & (seq_counter == 7));
	
	assign full_input = (user_counter == 7);
	
	assign seq_end = (seq_counter == 7);
	
	assign show_counter_zero = (show_counter == 0);
	
	assign match = (match_counter == 7);
	
	assign clk_zero = (clk_select == 0);
	
	// the player only gets 3 lives/chances to guess the sequence correctly throughout the entire game
	always_comb begin
		if(init_lives) begin
			no_lives = 0;
			lives = 3;
		end else if(decr_lives) begin
			lives = lives - 1;
			if(lives == 0)
				no_lives = 1;
		end
	end
	
endmodule 