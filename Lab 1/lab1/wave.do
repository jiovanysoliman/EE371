onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_tb/dut/CLOCK_50
add wave -noupdate /DE1_SoC_tb/dut/HEX0
add wave -noupdate /DE1_SoC_tb/dut/HEX1
add wave -noupdate /DE1_SoC_tb/dut/HEX2
add wave -noupdate /DE1_SoC_tb/dut/HEX3
add wave -noupdate /DE1_SoC_tb/dut/HEX4
add wave -noupdate /DE1_SoC_tb/dut/HEX5
add wave -noupdate /DE1_SoC_tb/dut/V_GPIO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {1617 ps}
