###################################################################

# Created by write_sdc on Sat Jun  4 15:37:28 2022

###################################################################
set sdc_version 1.9

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports CLK]  -period 1  -waveform {0 0.5}
set_max_delay 0.5  -from [list [get_pins {CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[31]}]          \
[get_pins {CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[30]}] [get_pins             \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[29]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[28]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[27]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[26]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[25]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[24]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[23]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[22]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[21]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[20]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[19]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[18]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[17]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[16]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[15]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[14]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[13]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[12]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[11]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[10]}] [get_pins                       \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[9]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[8]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[7]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[6]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[5]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[4]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[3]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[2]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[1]}] [get_pins                        \
{CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O[0]}]]  -to [list [get_pins {CPU_DP/PC_MUX/O[31]}] [get_pins {CPU_DP/PC_MUX/O[30]}]   \
[get_pins {CPU_DP/PC_MUX/O[29]}] [get_pins {CPU_DP/PC_MUX/O[28]}] [get_pins    \
{CPU_DP/PC_MUX/O[27]}] [get_pins {CPU_DP/PC_MUX/O[26]}] [get_pins              \
{CPU_DP/PC_MUX/O[25]}] [get_pins {CPU_DP/PC_MUX/O[24]}] [get_pins              \
{CPU_DP/PC_MUX/O[23]}] [get_pins {CPU_DP/PC_MUX/O[22]}] [get_pins              \
{CPU_DP/PC_MUX/O[21]}] [get_pins {CPU_DP/PC_MUX/O[20]}] [get_pins              \
{CPU_DP/PC_MUX/O[19]}] [get_pins {CPU_DP/PC_MUX/O[18]}] [get_pins              \
{CPU_DP/PC_MUX/O[17]}] [get_pins {CPU_DP/PC_MUX/O[16]}] [get_pins              \
{CPU_DP/PC_MUX/O[15]}] [get_pins {CPU_DP/PC_MUX/O[14]}] [get_pins              \
{CPU_DP/PC_MUX/O[13]}] [get_pins {CPU_DP/PC_MUX/O[12]}] [get_pins              \
{CPU_DP/PC_MUX/O[11]}] [get_pins {CPU_DP/PC_MUX/O[10]}] [get_pins              \
{CPU_DP/PC_MUX/O[9]}] [get_pins {CPU_DP/PC_MUX/O[8]}] [get_pins                \
{CPU_DP/PC_MUX/O[7]}] [get_pins {CPU_DP/PC_MUX/O[6]}] [get_pins                \
{CPU_DP/PC_MUX/O[5]}] [get_pins {CPU_DP/PC_MUX/O[4]}] [get_pins                \
{CPU_DP/PC_MUX/O[3]}] [get_pins {CPU_DP/PC_MUX/O[2]}] [get_pins                \
{CPU_DP/PC_MUX/O[1]}] [get_pins {CPU_DP/PC_MUX/O[0]}]]
set_max_delay 0.49  -from [list [get_pins {CPU_DP/PC/O[31]}] [get_pins {CPU_DP/PC/O[30]}]         \
[get_pins {CPU_DP/PC/O[29]}] [get_pins {CPU_DP/PC/O[28]}] [get_pins            \
{CPU_DP/PC/O[27]}] [get_pins {CPU_DP/PC/O[26]}] [get_pins {CPU_DP/PC/O[25]}]   \
[get_pins {CPU_DP/PC/O[24]}] [get_pins {CPU_DP/PC/O[23]}] [get_pins            \
{CPU_DP/PC/O[22]}] [get_pins {CPU_DP/PC/O[21]}] [get_pins {CPU_DP/PC/O[20]}]   \
[get_pins {CPU_DP/PC/O[19]}] [get_pins {CPU_DP/PC/O[18]}] [get_pins            \
{CPU_DP/PC/O[17]}] [get_pins {CPU_DP/PC/O[16]}] [get_pins {CPU_DP/PC/O[15]}]   \
[get_pins {CPU_DP/PC/O[14]}] [get_pins {CPU_DP/PC/O[13]}] [get_pins            \
{CPU_DP/PC/O[12]}] [get_pins {CPU_DP/PC/O[11]}] [get_pins {CPU_DP/PC/O[10]}]   \
[get_pins {CPU_DP/PC/O[9]}] [get_pins {CPU_DP/PC/O[8]}] [get_pins              \
{CPU_DP/PC/O[7]}] [get_pins {CPU_DP/PC/O[6]}] [get_pins {CPU_DP/PC/O[5]}]      \
[get_pins {CPU_DP/PC/O[4]}] [get_pins {CPU_DP/PC/O[3]}] [get_pins              \
{CPU_DP/PC/O[2]}] [get_pins {CPU_DP/PC/O[1]}] [get_pins {CPU_DP/PC/O[0]}]]  -to [list [get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[31]}] [get_pins              \
{CPU_DP/PC_ADDER_REG_IF_ID/I[30]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[29]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[28]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[27]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[26]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[25]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[24]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[23]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[22]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[21]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[20]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[19]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[18]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[17]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[16]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[15]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[14]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[13]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[12]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[11]}] [get_pins                                   \
{CPU_DP/PC_ADDER_REG_IF_ID/I[10]}] [get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[9]}] \
[get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[8]}] [get_pins                          \
{CPU_DP/PC_ADDER_REG_IF_ID/I[7]}] [get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[6]}]  \
[get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[5]}] [get_pins                          \
{CPU_DP/PC_ADDER_REG_IF_ID/I[4]}] [get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[3]}]  \
[get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[2]}] [get_pins                          \
{CPU_DP/PC_ADDER_REG_IF_ID/I[1]}] [get_pins {CPU_DP/PC_ADDER_REG_IF_ID/I[0]}]]
