onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part3_tb/CLOCK_50
add wave -noupdate /part3_tb/reset
add wave -noupdate -radix decimal /part3_tb/DataInTop
add wave -noupdate -radix decimal /part3_tb/dut/divided
add wave -noupdate -radix decimal /part3_tb/dut/multiplicator
add wave -noupdate -radix decimal /part3_tb/dut/adder2
add wave -noupdate -radix decimal /part3_tb/dut/accumulator
add wave -noupdate -radix decimal /part3_tb/DataOutTop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 55
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
WaveRestoreZoom {0 ps} {400 ps}
