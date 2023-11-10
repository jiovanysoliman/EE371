onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_tb/dut/CLOCK_50
add wave -noupdate -expand /DE1_SoC_tb/dut/SW
add wave -noupdate {/DE1_SoC_tb/dut/KEY[3]}
add wave -noupdate {/DE1_SoC_tb/dut/KEY[0]}
add wave -noupdate {/DE1_SoC_tb/dut/LEDR[9]}
add wave -noupdate {/DE1_SoC_tb/dut/LEDR[0]}
add wave -noupdate /DE1_SoC_tb/dut/HEX0
add wave -noupdate /DE1_SoC_tb/dut/HEX1
add wave -noupdate /DE1_SoC_tb/dut/done
add wave -noupdate /DE1_SoC_tb/dut/result
add wave -noupdate /DE1_SoC_tb/dut/Found
add wave -noupdate /DE1_SoC_tb/dut/DONE
add wave -noupdate /DE1_SoC_tb/dut/Loc
add wave -noupdate /DE1_SoC_tb/dut/Start
add wave -noupdate /DE1_SoC_tb/dut/Reset
add wave -noupdate /DE1_SoC_tb/dut/A
add wave -noupdate /DE1_SoC_tb/dut/out1
add wave -noupdate /DE1_SoC_tb/dut/out2
add wave -noupdate /DE1_SoC_tb/dut/d
add wave -noupdate /DE1_SoC_tb/dut/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {89 ps} 0}
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
WaveRestoreZoom {0 ps} {3470 ps}
