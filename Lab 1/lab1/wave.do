onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /car_counter_tb/dut/clk
add wave -noupdate /car_counter_tb/dut/reset
add wave -noupdate /car_counter_tb/dut/incr
add wave -noupdate /car_counter_tb/dut/decr
add wave -noupdate /car_counter_tb/dut/HEX0
add wave -noupdate /car_counter_tb/dut/HEX1
add wave -noupdate /car_counter_tb/dut/HEX2
add wave -noupdate /car_counter_tb/dut/HEX3
add wave -noupdate /car_counter_tb/dut/HEX4
add wave -noupdate /car_counter_tb/dut/HEX5
add wave -noupdate /car_counter_tb/dut/ps
add wave -noupdate /car_counter_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {3 ns} {4 ns}
