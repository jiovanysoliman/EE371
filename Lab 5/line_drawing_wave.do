onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/reset
add wave -noupdate -radix decimal /tb/x0
add wave -noupdate -radix decimal /tb/y0
add wave -noupdate -radix decimal /tb/x1
add wave -noupdate -radix decimal /tb/y1
add wave -noupdate -radix decimal /tb/x
add wave -noupdate -radix decimal /tb/y
add wave -noupdate -radix decimal /tb/dut/nextX
add wave -noupdate -radix decimal /tb/dut/nextY
add wave -noupdate /tb/done
add wave -noupdate /tb/dut/isSteep
add wave -noupdate -radix decimal /tb/dut/deltax
add wave -noupdate -radix decimal /tb/dut/deltay
add wave -noupdate -radix decimal /tb/dut/absY
add wave -noupdate -radix decimal /tb/dut/absX
add wave -noupdate -radix decimal /tb/dut/error
add wave -noupdate /tb/dut/y_step
add wave -noupdate -expand -group adjustment1 -radix decimal /tb/dut/x0temp1
add wave -noupdate -expand -group adjustment1 -radix decimal /tb/dut/y0temp1
add wave -noupdate -expand -group adjustment1 -radix decimal /tb/dut/x1temp1
add wave -noupdate -expand -group adjustment1 -radix decimal /tb/dut/y1temp1
add wave -noupdate -expand -group adjustment2 -radix decimal /tb/dut/x0temp2
add wave -noupdate -expand -group adjustment2 -radix decimal /tb/dut/y0temp2
add wave -noupdate -expand -group adjustment2 -radix decimal /tb/dut/x1temp2
add wave -noupdate -expand -group adjustment2 -radix decimal /tb/dut/y1temp2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11 ps} 0}
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
WaveRestoreZoom {0 ps} {436 ps}
