onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /binary_tb/dut/CLOCK_50
add wave -noupdate -radix unsigned /binary_tb/dut/Start
add wave -noupdate -radix unsigned /binary_tb/dut/Reset
add wave -noupdate -radix unsigned /binary_tb/dut/A
add wave -noupdate -radix unsigned /binary_tb/dut/Done
add wave -noupdate -radix unsigned /binary_tb/dut/Found
add wave -noupdate -radix unsigned /binary_tb/dut/compute_M
add wave -noupdate -radix unsigned /binary_tb/dut/Set_LSB
add wave -noupdate -radix unsigned /binary_tb/dut/Set_MSB
add wave -noupdate -radix unsigned /binary_tb/dut/init
add wave -noupdate -radix unsigned /binary_tb/dut/Loc
add wave -noupdate -radix unsigned /binary_tb/dut/LSB
add wave -noupdate -radix unsigned /binary_tb/dut/MSB
add wave -noupdate -radix unsigned /binary_tb/dut/M
add wave -noupdate -radix unsigned /binary_tb/dut/q
add wave -noupdate /binary_tb/dut/FSM/ps
add wave -noupdate /binary_tb/dut/FSM/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80 ps} 0}
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
WaveRestoreZoom {0 ps} {793 ps}
