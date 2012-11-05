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
add wave -noupdate -radix hexadecimal -childformat {{/tb_yamp/cpu/dec/rf/ram(0) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(1) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(2) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(3) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(4) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(5) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(6) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(7) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(8) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(9) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(10) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(11) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(12) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(13) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(14) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(15) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(16) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(17) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(18) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(19) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(20) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(21) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(22) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(23) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(24) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(25) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(26) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(27) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(28) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(29) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(30) -radix hexadecimal} {/tb_yamp/cpu/dec/rf/ram(31) -radix hexadecimal}} -expand -subitemconfig {/tb_yamp/cpu/dec/rf/ram(0) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(1) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(2) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(3) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(4) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(5) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(6) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(7) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(8) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(9) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(10) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(11) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(12) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(13) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(14) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(15) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(16) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(17) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(18) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(19) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(20) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(21) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(22) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(23) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(24) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(25) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(26) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(27) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(28) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(29) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(30) {-radix hexadecimal} /tb_yamp/cpu/dec/rf/ram(31) {-radix hexadecimal}} /tb_yamp/cpu/dec/rf/ram
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
WaveRestoreZoom {0 ps} {210 ns}
