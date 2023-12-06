/*
This is the game controller module for our number sequence memory game. Depending on what the user
inputs and status signals are, the game controller determines the course of the game by using a
finite state machine and sending control signals to the game datapath module.

EXTERNAL INPUTS
	clk-------- system clock
	reset------ reset the game
	start------ start the game
	restart---- restart the game from the very beginning
	show_again- display the sequence again on the VGA
	key0------- user's input "0"
	key1------- user's input "1"
	key2------- user's input "2"
	key3------- user's input "3"

INPUTS FROM DATAPATH (STATUS SIGNALS)
	seq_end----------- true when 
	end_comp---------- true when all user and generated sequence values have been compared
	show_counter_zero- true when the user cannot repeat the sequence again until the next sequence
	full_input-------- true when the user has entered 7 numbers 
	no_lives---------- true when the user has no more lives
	match------------- true when the user's input sequence matches the generated number sequence
	clk_zero---------- true when the clock cannot be further divided (has reached its fastest speed)
	seq_num----------- used to display the corresponding generated number on the VGA

OUTPUTS TO DATAPATH (CONTROL SIGNALS) 
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

EXTERNAL OUTPUTS
	display- selects the image to show on the VGA
	clear--- clears the VGA screen
	ready--- indicates when the player can input their guess
	victory- true when the player has won the entire game 
*/

module gameControl(clk, 
						 reset, 
						 start, 
						 restart, 
						 show_again,
						 key0,
						 key1,
						 key2,
						 key3,
						 seq_end, 
						 end_comp,
						 show_counter_zero, 
						 full_input, 
						 no_lives, 
						 match, 
						 clk_zero, 
						 seq_num, 
						 display, 
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
						 clear, 
						 ready, 
						 store_input, 
						 decr_show_counter, 
						 read_input, 
						 decr_lives, 
						 decr_clk, 
						 incr_level, 
						 victory,
						 keyVal);
						 
// PORT DEFINITIONS
	// EXTERNAL INPUTS
	input  logic clk, reset, start, restart, show_again, key0, key1, key2, key3; 
	
	// STATUS SIGNALS (INPUTS)
	input  logic seq_end, show_counter_zero, full_input, no_lives, match, clk_zero, end_comp;
	input  logic [1:0] seq_num;
	
	// CONTROL SIGNALS (OUTPUTS)	
	output logic init_show_counter, reset_clk, init_lives, init_seq_counter, init_level, store_num, incr_seq_counter, init_user_counter;
	output logic read_seq, store_input, decr_show_counter, read_input, decr_lives, decr_clk, incr_level, incr_user_counter, init_match_counter;
	output logic [1:0] keyVal;
	
	// EXTERNAL OUTPUTS
	output logic [2:0] display;	
	output logic clear, ready, victory;
	
// STATE NAMES AND VARIABLES
	enum {idle, getSequence, showSeq, showBlank, getInput, compare, live_or_die, results, winner, gameOver} ps, ns;
	
	// key_pressed is true only when 1 key is pressed at a time
	logic key_pressed;
	assign key_pressed = ( key0 & ~key1 & ~key2 & ~key3) | 
							   (~key0 &  key1 & ~key2 & ~key3) | 
							   (~key0 & ~key1 &  key2 & ~key3) | 
							   (~key0 & ~key1 & ~key2 &  key3);
	
// CONTROLLER LOGIC WITH SYNCHRONOUS RESET 
	always_ff @(posedge clk)
		if(reset)
			ps <= idle;
		else
			ps <= ns;
			
// NEXT STATE LOGIC 
	always_comb begin
		case(ps)
			idle: // start screen
				begin
					ns = start ? getSequence : idle;
				end
			getSequence: // gather generated numbers for the sequence
				begin
					ns = seq_end ? showSeq : getSequence;
				end
			showSeq: // display generated numbers on the VGA
				begin
					ns = showBlank;
				end
			showBlank: // show a blank screen between numbers (for repeats)
				begin
					ns = seq_end ? getInput : showSeq;
				end
			getInput: // get user input from KEYs
				begin
					if(~full_input & show_again & ~show_counter_zero)                    ns = showSeq;
					else if(~full_input & show_again & show_counter_zero & ~key_pressed) ns = getInput;
					else if(~full_input & ~show_again & ~key_pressed)                    ns = getInput;
					else if(~full_input & ~show_again & key_pressed)       					ns = getInput;
					else if(full_input)        														ns = compare;
					else 																						ns = getInput;
				end
			compare: // compare user input with generated sequence
				begin
					if(end_comp & ~match)     ns = live_or_die;
					else if(end_comp & match) ns = results;
					else if(~end_comp)        ns = compare;
					else							  ns = compare;
				end
			live_or_die:
				begin
					ns = no_lives ? gameOver : getInput;
				end
			results:
				begin
					ns = clk_zero ? winner : getSequence;
				end
			winner:
				begin
					ns = restart ? idle : winner;
				end
			gameOver: // game over screen, player lost all lives
				begin
					ns = restart ? idle : gameOver;
				end
			
			default:
				ns = idle;
		endcase
	end // end always_comb
	
// OUTPUT ASSIGNMENTS
	// display assignment
	always_comb begin
		if(ps == idle) 		   display = 3'b100;
		else if(ps == gameOver) display = 3'b101;
		else if(ps == winner) 	display = 3'b111;
		else 							display = {1'b0, seq_num};
	end
	
	// keyVal assignment (user value to be recorded)
	always_comb begin
		if(key0 & ~key1 & ~key2 & ~key3) begin
			keyVal <= 2'b00;
		end else if(~key0 & key1 & ~key2 & ~key3) begin
			keyVal <= 2'b01;
		end else if(~key0 & ~key1 & key2 & ~key3) begin
			keyVal <= 2'b10;
		end else begin
			keyVal <= 2'b11;
		end
	end
	
	// other output assignments
	assign init_user_counter = ((ps == idle) & start) |
										((ps == getInput) & full_input) |
										((ps == results) & ~clk_zero) |
										((ps == live_or_die) & ~no_lives);
									
	assign incr_user_counter = ((ps == getInput) & ((~full_input & ~show_again & key_pressed) |
																	(~full_input & show_again & show_counter_zero & key_pressed))) |
										((ps == compare) & ~end_comp);
		
	assign init_show_counter = ((ps == idle) & start) | 
										((ps == results) & ~clk_zero);
	
	assign init_match_counter = ((ps == getInput) & full_input);
	
	assign reset_clk = ((ps == gameOver) & restart) | 
							 ((ps == winner) & restart) |
							 ((ps == idle) & start);
	
	assign init_lives = (ps == idle) & start;
	
	assign init_seq_counter = ((ps == idle) & start) | 
									  ((ps == getSequence) & seq_end) | 
									  ((ps == getInput) & ((~full_input & show_again & ~show_counter_zero)|(full_input))) |
									  ((ps == results) & ~clk_zero);
									  
	assign init_level = (ps == idle) & start;
	
	assign store_num = (ps == getSequence) & ~seq_end;
	
	assign incr_seq_counter = ((ps == getSequence) & ~seq_end) |
									  ((ps == showBlank) & ~seq_end) |
									  ((ps == compare) & ~end_comp);
									  
	assign read_seq = (ps == showSeq);
	
	assign clear = (ps == getSequence) | (ps == showBlank) | (ps == getInput) | (ps == compare) | (ps == live_or_die) | (ps == results); 
	
	assign ready = (ps == getInput);
	
	assign store_input = (ps == getInput) & ((~full_input & ~show_again & key_pressed) | 
														  (~full_input & show_again & show_counter_zero & key_pressed));
	
	assign decr_show_counter =  (ps == getInput) & ~full_input & show_again & ~show_counter_zero;
	
	assign read_input = (ps == compare);	
	
	assign decr_lives = (ps == compare) & end_comp & ~match;
	
	assign decr_clk = (ps == compare) & end_comp & match;
	
	assign incr_level = (ps == compare) & end_comp & match;
	
	assign victory = (ps == results) & clk_zero;
	
endmodule 