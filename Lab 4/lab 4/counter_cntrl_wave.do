onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_cntrl_tb/clk
add wave -noupdate /counter_cntrl_tb/reset
add wave -noupdate /counter_cntrl_tb/s
add wave -noupdate /counter_cntrl_tb/load_A
add wave -noupdate /counter_cntrl_tb/clr_result
add wave -noupdate /counter_cntrl_tb/r_shift_A
add wave -noupdate /counter_cntrl_tb/incr_result
add wave -noupdate /counter_cntrl_tb/got_1
add wave -noupdate /counter_cntrl_tb/A_zero
add wave -noupdate /counter_cntrl_tb/done
add wave -noupdate /counter_cntrl_tb/dut/ps
add wave -noupdate /counter_cntrl_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {176 ps}
