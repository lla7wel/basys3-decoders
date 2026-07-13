# Non-project batch build: RTL -> bitstream for the Digilent Basys 3.
#
# Usage:
#   vivado -mode batch -source scripts/build_bitstream.tcl -tclargs decoder_2to4
#   vivado -mode batch -source scripts/build_bitstream.tcl -tclargs decoder_bcd
#
# Outputs (per top): build/vivado/<top>.bit plus utilization/timing reports.

if { $argc != 1 } {
    puts "ERROR: expected one argument: the top-level name (decoder_2to4 | decoder_bcd)"
    exit 1
}
set top  [lindex $argv 0]
set part xc7a35tcpg236-1
set out  build/vivado

file mkdir $out

read_vhdl rtl/${top}.vhd
read_xdc  constraints/${top}_basys3.xdc

synth_design -top $top -part $part
opt_design
place_design
route_design

report_utilization    -file ${out}/${top}_utilization.rpt
report_timing_summary -file ${out}/${top}_timing.rpt

write_bitstream -force ${out}/${top}.bit
puts "Bitstream written to ${out}/${top}.bit"
