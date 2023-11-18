onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/CLOCK_50
add wave -noupdate /testbench/dut/animator_clk
add wave -noupdate /testbench/dut/ps
add wave -noupdate /testbench/dut/ns
add wave -noupdate /testbench/dut/line_reset
add wave -noupdate /testbench/dut/color
add wave -noupdate /testbench/dut/done
add wave -noupdate -radix decimal /testbench/dut/x0
add wave -noupdate -radix decimal /testbench/dut/y0
add wave -noupdate -radix decimal /testbench/dut/x1
add wave -noupdate -radix decimal /testbench/dut/y1
add wave -noupdate -radix decimal /testbench/dut/x
add wave -noupdate -radix decimal /testbench/dut/y
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/y_step
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y1temp2
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y1temp1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y0temp2
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y0temp1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x1temp2
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x1temp1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x0temp2
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x0temp1
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x0
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y0
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/x
add wave -noupdate -expand -group linedrawer -radix unsigned /testbench/dut/lines/y
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/reset
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/nextY
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/nextX
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/isSteep
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/error
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/doneSignal
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/done
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/deltay
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/deltax
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/clk
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/absY
add wave -noupdate -expand -group linedrawer /testbench/dut/lines/absX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1941 ps} 0} {{Cursor 2} {20735 ps} 0} {{Cursor 3} {26966 ps} 0} {{Cursor 4} {36568 ps} 0} {{Cursor 5} {46987 ps} 0} {{Cursor 6} {52196 ps} 0} {{Cursor 7} {63126 ps} 0} {{Cursor 8} {73851 ps} 0}
quietly wave cursor active 8
configure wave -namecolwidth 112
configure wave -valuecolwidth 82
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
WaveRestoreZoom {0 ps} {105005 ps}
