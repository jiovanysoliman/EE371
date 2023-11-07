onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /binary_tb/dut/CLOCK_50
add wave -noupdate /binary_tb/dut/A
add wave -noupdate /binary_tb/dut/Reset
add wave -noupdate /binary_tb/dut/Start
add wave -noupdate /binary_tb/dut/F
add wave -noupdate /binary_tb/dut/Loc
add wave -noupdate /binary_tb/dut/DONE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {545 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 67
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
WaveRestoreZoom {0 ps} {1727 ps}
