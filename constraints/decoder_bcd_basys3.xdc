# Digilent Basys 3 constraints for top-level: decoder_bcd
# Device: Xilinx Artix-7 XC7A35T-1CPG236C

# BCD digit input on slide switches SW0-SW3
set_property PACKAGE_PIN V17 [get_ports {B[0]}]
set_property PACKAGE_PIN V16 [get_ports {B[1]}]
set_property PACKAGE_PIN W16 [get_ports {B[2]}]
set_property PACKAGE_PIN W17 [get_ports {B[3]}]

# Active-high enable on slide switch SW4
set_property PACKAGE_PIN W15 [get_ports {EN}]

# One-hot decimal outputs on user LEDs LD0-LD9
set_property PACKAGE_PIN U16 [get_ports {Y[0]}]
set_property PACKAGE_PIN E19 [get_ports {Y[1]}]
set_property PACKAGE_PIN U19 [get_ports {Y[2]}]
set_property PACKAGE_PIN V19 [get_ports {Y[3]}]
set_property PACKAGE_PIN W18 [get_ports {Y[4]}]
set_property PACKAGE_PIN U15 [get_ports {Y[5]}]
set_property PACKAGE_PIN U14 [get_ports {Y[6]}]
set_property PACKAGE_PIN V14 [get_ports {Y[7]}]
set_property PACKAGE_PIN V13 [get_ports {Y[8]}]
set_property PACKAGE_PIN V3  [get_ports {Y[9]}]

# All switch and LED banks on the Basys 3 are powered at 3.3 V
set_property IOSTANDARD LVCMOS33 [get_ports {B[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {EN}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[*]}]

# Configuration bank voltage (suppresses CFGBVS/CONFIG_VOLTAGE warnings)
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
