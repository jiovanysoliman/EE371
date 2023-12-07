onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memoryGame_tb/dut/clk
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/reset
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/start
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/restart
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/show_again
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/k0
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/k1
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/k2
add wave -noupdate -expand -group {top level input} /memoryGame_tb/dut/k3
add wave -noupdate -group {top level output} /memoryGame_tb/dut/ready
add wave -noupdate -group {top level output} /memoryGame_tb/dut/level
add wave -noupdate -group {top level output} /memoryGame_tb/dut/display
add wave -noupdate -group {top level output} /memoryGame_tb/dut/clear
add wave -noupdate -group {top level output} /memoryGame_tb/dut/victory
add wave -noupdate /memoryGame_tb/dut/cntrl/ps
add wave -noupdate /memoryGame_tb/dut/cntrl/ns
add wave -noupdate -expand -group {input from top level} /memoryGame_tb/dut/cntrl/reset
add wave -noupdate -expand -group {input from top level} /memoryGame_tb/dut/cntrl/start
add wave -noupdate -expand -group {input from top level} /memoryGame_tb/dut/cntrl/restart
add wave -noupdate -expand -group {input from top level} /memoryGame_tb/dut/cntrl/show_again
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/seq_num
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/show_counter_zero
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/full_input
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/no_lives
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/match
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/clk_zero
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/key_pressed
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/cntrl/seq_end
add wave -noupdate -expand -group {status signals from datapath} /memoryGame_tb/dut/dp/seq_num
add wave -noupdate /memoryGame_tb/dut/cntrl/goShow
add wave -noupdate /memoryGame_tb/dut/cntrl/goBlank
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/display
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/show_ready
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/blank_ready
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/clear
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/init_show_counter
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/reset_clk
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/init_lives
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/init_seq_counter
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/init_level
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/store_num
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/incr_seq_counter
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/read_seq
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/store_input
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/decr_show_counter
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/read_input
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/decr_lives
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/decr_clk
add wave -noupdate -expand -group {output control signals} /memoryGame_tb/dut/cntrl/incr_level
add wave -noupdate -group {control output} /memoryGame_tb/dut/cntrl/display
add wave -noupdate -group {control output} /memoryGame_tb/dut/cntrl/clear
add wave -noupdate -group {control output} /memoryGame_tb/dut/cntrl/ready
add wave -noupdate -group {control output} /memoryGame_tb/dut/cntrl/victory
add wave -noupdate -group LFSR /memoryGame_tb/dut/dp/numGen/Q
add wave -noupdate -group LFSR /memoryGame_tb/dut/dp/numGen/mod
add wave -noupdate -group {user input data} /memoryGame_tb/dut/cntrl/key0
add wave -noupdate -group {user input data} /memoryGame_tb/dut/cntrl/key1
add wave -noupdate -group {user input data} /memoryGame_tb/dut/cntrl/key2
add wave -noupdate -group {user input data} /memoryGame_tb/dut/cntrl/key3
add wave -noupdate -group {user input data} /memoryGame_tb/dut/cntrl/key_pressed
add wave -noupdate -group {user input data} -radix unsigned /memoryGame_tb/dut/cntrl/keyVal
add wave -noupdate -group {user input data} -radix unsigned /memoryGame_tb/dut/dp/user_seq
add wave -noupdate -group {user input data} /memoryGame_tb/dut/dp/read_input
add wave -noupdate -group {user input data} /memoryGame_tb/dut/dp/store_input
add wave -noupdate -group {user input data} /memoryGame_tb/dut/dp/full_input
add wave -noupdate -group {user input data} -radix unsigned /memoryGame_tb/dut/dp/user_counter
add wave -noupdate -expand -group {sequence data} -radix unsigned /memoryGame_tb/dut/dp/seq_num
add wave -noupdate -expand -group {sequence data} /memoryGame_tb/dut/dp/store_num
add wave -noupdate -expand -group {sequence data} -radix unsigned /memoryGame_tb/dut/dp/seq
add wave -noupdate -expand -group {sequence data} /memoryGame_tb/dut/dp/read_seq
add wave -noupdate -radix unsigned /memoryGame_tb/dut/dp/lfsr_num
add wave -noupdate -group {keys/user input} /memoryGame_tb/dut/ready
add wave -noupdate -group {keys/user input} -radix unsigned -childformat {{{/memoryGame_tb/dut/dp/keyVal[1]} -radix unsigned} {{/memoryGame_tb/dut/dp/keyVal[0]} -radix unsigned}} -subitemconfig {{/memoryGame_tb/dut/dp/keyVal[1]} {-height 15 -radix unsigned} {/memoryGame_tb/dut/dp/keyVal[0]} {-height 15 -radix unsigned}} /memoryGame_tb/dut/dp/keyVal
add wave -noupdate -group {show counter} /memoryGame_tb/dut/dp/init_show_counter
add wave -noupdate -group {show counter} /memoryGame_tb/dut/dp/decr_show_counter
add wave -noupdate -group {show counter} /memoryGame_tb/dut/dp/show_counter
add wave -noupdate -group {show counter} /memoryGame_tb/dut/dp/show_counter_zero
add wave -noupdate -group {seq counter} /memoryGame_tb/dut/dp/init_seq_counter
add wave -noupdate -group {seq counter} /memoryGame_tb/dut/dp/incr_seq_counter
add wave -noupdate -group {seq counter} /memoryGame_tb/dut/dp/seq_end
add wave -noupdate -group {seq counter} -radix unsigned /memoryGame_tb/dut/dp/seq_counter
add wave -noupdate -group level /memoryGame_tb/dut/dp/init_level
add wave -noupdate -group level /memoryGame_tb/dut/dp/incr_level
add wave -noupdate -group level -radix unsigned /memoryGame_tb/dut/dp/level
add wave -noupdate -group lives /memoryGame_tb/dut/dp/init_lives
add wave -noupdate -group lives /memoryGame_tb/dut/dp/decr_lives
add wave -noupdate -group lives -radix unsigned /memoryGame_tb/dut/dp/lives
add wave -noupdate -group lives /memoryGame_tb/dut/dp/no_lives
add wave -noupdate -expand -group clock -radix unsigned /memoryGame_tb/dut/dp/divClocks
add wave -noupdate -expand -group clock -radix unsigned /memoryGame_tb/dut/dp/clk_select
add wave -noupdate -expand -group clock /memoryGame_tb/dut/dp/reset_clk
add wave -noupdate -expand -group clock /memoryGame_tb/dut/dp/decr_clk
add wave -noupdate -expand -group clock /memoryGame_tb/dut/dp/clk_zero
add wave -noupdate -expand -group clock /memoryGame_tb/dut/dp/next_clk
add wave -noupdate -group matching -radix unsigned /memoryGame_tb/dut/dp/match_counter
add wave -noupdate -group matching /memoryGame_tb/dut/dp/end_comp
add wave -noupdate -group matching /memoryGame_tb/dut/dp/match
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {355 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
configure wave -valuecolwidth 91
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {7567 ps}
