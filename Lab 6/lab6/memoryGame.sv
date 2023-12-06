/*
This module combines the game control and game datapath modules needed for our number sequence memory game
that challenges the player's ability to memorize a pseudo-random sequence of 7 numbers ranging from 0 to 3.
The player only has 3 chances ("lives") for the whole game to correctly input the sequence, and only 1 chance
per sequence to repeat the generated number sequence on the VGA. When the player guesses the correct sequence,
they advance to the next level and the generated number sequence is displayed at a faster rate on the VGA. When
the player enters the wrong sequence and loses all their lives, the game ends.

INPUTS
	clk-------- system clock
	reset------ reset the game
	k0--------- user input "1"
	k1--------- user input "2"
	k3--------- user input "3"
	k4--------- user input "4"
	start------ start the game
	show_again- display the sequence again on the VGA
	restart---- restart the game from the very beginning

outputs
	level--- what level the user is currently on
	ready--- indicates when the player can input their guess
	victory- true when the player has won the entire game
	display- selects what image to show on the VGA 
	clear--- clears the VGA screen
*/

module memoryGame(clk, reset, k0, k1, k2, k3, start, show_again, restart, level, ready, victory, display, clear, lives, next_clk);
	input  logic clk, reset, k0, k1, k2, k3, start, show_again, restart;
	output logic ready, victory, clear, next_clk;
	output logic [1:0] lives;
	output logic [2:0] display, level;
	
	
	// wires to connect control and datapath
	logic seq_end, show_counter_zero, full_input, no_lives, match, clk_zero, init_user_counter, incr_user_counter;
	logic init_show_counter, reset_clk, init_lives, init_seq_counter, init_level, store_num, incr_seq_counter;
	logic read_seq, store_input, decr_show_counter, read_input, decr_lives, decr_clk, incr_level, init_match_counter, end_comp;
	logic b0, b1, b2, b3;
	logic [1:0] seq_num, keyVal;
	
	
	// instantiate buttons so that they only show true for one clock cycle
	buttons key0 (.clk(clk), .button(k0), .b(b0));
	buttons key1 (.clk(clk), .button(k1), .b(b1));
	buttons key2 (.clk(clk), .button(k2), .b(b2));
	buttons key3 (.clk(clk), .button(k3), .b(b3));
	
	// instantiate game control
	gameControl cntrl (.clk(clk), 
							 .reset(reset), 
							 .start(start), 
							 .restart(restart), 
							 .show_again(show_again), 
							 .key0(b0), 
							 .key1(b1), 
							 .key2(b2), 
							 .key3(b3), 
							 .seq_end(seq_end),
							 .end_comp(end_comp), 
							 .show_counter_zero(show_counter_zero), 
							 .full_input(full_input), 
							 .no_lives(no_lives),  
							 .match(match), 
							 .clk_zero(clk_zero), 
							 .seq_num(seq_num), 
							 .display(display), 
						    .init_show_counter(init_show_counter), 
							 .reset_clk(reset_clk), 
							 .init_lives(init_lives), 
							 .init_seq_counter(init_seq_counter), 
							 .init_user_counter(init_user_counter),
						    .init_level(init_level), 
							 .init_match_counter(init_match_counter),
							 .store_num(store_num), 
							 .incr_seq_counter(incr_seq_counter), 
							 .incr_user_counter(incr_user_counter),
							 .read_seq(read_seq),  
							 .clear(clear), 
							 .ready(ready), 
							 .store_input(store_input), 
							 .decr_show_counter(decr_show_counter), 
							 .read_input(read_input), 
							 .decr_lives(decr_lives), 
							 .decr_clk(decr_clk), 
							 .incr_level(incr_level), 
							 .victory(victory),
							 .keyVal(keyVal));
					 
	// instantiate datapath	
	datapath dp (.clk(clk), 
					 .reset(reset), 
					 .init_show_counter(init_show_counter), 
					 .reset_clk(reset_clk), 
					 .init_lives(init_lives), 
					 .init_seq_counter(init_seq_counter),
					 .init_user_counter(init_user_counter), 
					 .init_level(init_level), 
					 .init_match_counter(init_match_counter),
					 .store_num(store_num), 
					 .incr_seq_counter(incr_seq_counter), 
					 .incr_user_counter(incr_user_counter),
					 .read_seq(read_seq), 
					 .store_input(store_input), 
					 .decr_show_counter(decr_show_counter), 
					 .read_input(read_input), 
					 .decr_lives(decr_lives), 
					 .decr_clk(decr_clk), 
					 .incr_level(incr_level),
					 .keyVal(keyVal),
					 .seq_end(seq_end), 
					 .end_comp(end_comp),
					 .show_counter_zero(show_counter_zero), 
					 .full_input(full_input), 
					 .no_lives(no_lives), 
					 .match(match), 
					 .clk_zero(clk_zero),  
					 .seq_num(seq_num), 
					 .level(level),
					 .lives(lives),
					 .next_clk(next_clk));
endmodule 

module memoryGame_tb();
	logic clk, reset, k0, k1, k2, k3, start, show_again, restart;
	logic ready, victory, clear, next_clk;
	logic [1:0] lives;
	logic [2:0] display, level;
	
	memoryGame dut(.*);
	
	parameter CLOCK_PERIOD = 10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; 											  															 repeat(2)  @(posedge clk); // start at level 1
		reset <= 0;	start <= 0;	k0 <= 0; k1 <= 0; k2 <= 0; k3 <= 0; show_again <= 0; restart <= 0; repeat(4)  @(posedge clk);
						start <= 1; 															  											@(posedge clk);
						start <= 0; 							  															 repeat(30) @(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  											@(posedge clk);
																k2 <= 1;							  											@(posedge clk);
																k2 <= 0;							  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
																k2 <= 1;							  											@(posedge clk);
																k2 <= 0;							  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  											@(posedge clk);
																k2 <= 1;							  											@(posedge clk);
																k2 <= 0;							  											@(posedge clk);
																																 repeat(40) @(posedge clk); // user sequence matches generated sequence (advance to level 2)
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  							 repeat(15) @(posedge clk); // user loses a life (doesn't match - 2 lives left)
																						show_again <= 1;									@(posedge clk);
																						show_again <= 0;					 repeat(15) @(posedge clk); // user requests to see the sequence again
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  											@(posedge clk);
																k2 <= 1;							  											@(posedge clk);
																k2 <= 0;							  											@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
																k2 <= 1;							  											@(posedge clk);
																k2 <= 0;							  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  											@(posedge clk);
										k0 <= 1;													  											@(posedge clk);
										k0 <= 0;													  							 repeat(20) @(posedge clk); // user loses another life (1 life left)
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
													k1 <= 1;																					@(posedge clk);
													k1 <= 0;																					@(posedge clk);
																k2 <= 1;																		@(posedge clk);
																k2 <= 0;																		@(posedge clk);
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
													k1 <= 1;																					@(posedge clk);
													k1 <= 0;																					@(posedge clk);
																			k3 <= 1;											 				@(posedge clk);
																			k3 <= 0;											 				@(posedge clk);
																k2 <= 1;																		@(posedge clk);
																k2 <= 0;														 repeat(20) @(posedge clk); // user loses last life (game over)
																											  restart <= 1;            @(posedge clk);
																											  restart <= 0;            @(posedge clk);
						start <= 1;																											@(posedge clk);
						start <= 0;																							 repeat(40) @(posedge clk);
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
													k1 <= 1; 				  					  											@(posedge clk);
													k1 <= 0; 				  					  											@(posedge clk);
													k1 <= 1; 			k3 <= 1;				  											@(posedge clk); // does not store value if multiple keys are pressed
													k1 <= 0; 			k3 <= 0;				  											@(posedge clk);
																k2 <= 1;							  							  repeat(4) @(posedge clk); // will only store one value if key is held down 
																k2 <= 0;							  											@(posedge clk);
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
										k0 <= 1;																								@(posedge clk);
										k0 <= 0; 																							@(posedge clk);
													k1 <= 1;																					@(posedge clk);
													k1 <= 0; 																 repeat(40) @(posedge clk); // user loses a life (2 lives left)
																																				$stop;
										
										
	end
endmodule 