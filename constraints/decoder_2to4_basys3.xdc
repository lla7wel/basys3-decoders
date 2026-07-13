# Digilent Basys 3 constraints for top-level: decoder_2to4
# Device: Xilinx Artix-7 XC7A35T-1CPG236C

# Select inputs on slide switches
set_property PACKAGE_PIN V17 [get_ports {A[0]}]
set_property PACKAGE_PIN V16 [get_ports {A[1]}]

# Active-low decoded outputs on user LEDs.
# The Basys 3 LEDs are active-high, so the selected (low) output
# appears as the single LED that is OFF.
set_property PACKAGE_PIN U16 [get_ports {X[0]}]
set_property PACKAGE_PIN E19 [get_ports {X[1]}]
set_property PACKAGE_PIN U19 [get_ports {X[2]}]
set_property PACKAGE_PIN V19 [get_ports {X[3]}]

# All switch and LED banks on the Basys 3 are powered at 3.3 V
set_property IOSTANDARD LVCMOS33 [get_ports {A[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {X[*]}]

# Configuration bank voltage (suppresses CFGBVS/CONFIG_VOLTAGE warnings)
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
