onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_tb/CLOCK_PERIOD
add wave -noupdate /DE1_SoC_tb/SW
add wave -noupdate /DE1_SoC_tb/KEY
add wave -noupdate /DE1_SoC_tb/HEX0
add wave -noupdate /DE1_SoC_tb/HEX1
add wave -noupdate /DE1_SoC_tb/HEX2
add wave -noupdate /DE1_SoC_tb/HEX3
add wave -noupdate /DE1_SoC_tb/HEX4
add wave -noupdate /DE1_SoC_tb/HEX5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28 ps} 0}
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
WaveRestoreZoom {11954 ps} {12792 ps}
