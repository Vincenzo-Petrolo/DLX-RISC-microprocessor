###################################################################

# Created by write_sdc on Wed Jun  8 00:43:03 2022

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports CLK]  -period 1  -waveform {0 0.5}
