onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_datapath_tb/clk
add wave -noupdate /counter_datapath_tb/load_A
add wave -noupdate /counter_datapath_tb/clr_result
add wave -noupdate /counter_datapath_tb/r_shift_A
add wave -noupdate /counter_datapath_tb/A_zero
add wave -noupdate /counter_datapath_tb/got_1
add wave -noupdate /counter_datapath_tb/incr_result
add wave -noupdate /counter_datapath_tb/result
add wave -noupdate /counter_datapath_tb/A
add wave -noupdate /counter_datapath_tb/dut/a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {240 ps}
