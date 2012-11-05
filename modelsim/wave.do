onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_yamp/clk
add wave -noupdate -radix hexadecimal /tb_yamp/reset
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/fe/pc
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/feout
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/decout
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/exout
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/memout
add wave -noupdate -radix hexadecimal /tb_yamp/cpu/wbout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {13190 ps}
