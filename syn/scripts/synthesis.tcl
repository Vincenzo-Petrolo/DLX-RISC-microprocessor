# First analyze all files
analyze -library WORK -format vhdl {/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-ControlUnit.core/a.a.b-op_func.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-ControlUnit.core/a.a.a-cw_flags.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.a-aluOpCodes.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.d-MUX21.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.c-ADDER.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.b-ALU.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.e-REG.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.f-RF.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.d-INSTRMEM.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.c-DATAMEM.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-DP.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-HWCU.vhd /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a-CPU.vhd}

# Now elaborate
elaborate CPU -architecture STRUCT -library WORK
# Set the wire load
set_wire_load_model -name 5K_hvratio_1_4
# Set clock period to 1ns to achieve 1GHz
set CLK_PERIOD 1
# Create Clock
create_clock -name "CLK" -period $CLK_PERIOD CLK
# Report the clock to check if it was created
report_clock
# Now constraint the path from MEM register to Program Counter because PC works on falling edge of clock
set DUTY_CYCLE [expr {double($CLK_PERIOD)/2}];
set_max_delay $DUTY_CYCLE -from CPU_DP/PC_BRANCH_ADDER_OUT_REG_EX_MEM/O -to CPU_DP/PC_MUX/O
# Create constraints to help reaching the 1GhZ GOAL
set_max_delay 0.49 -from CPU_DP/PC/O  -to CPU_DP/PC_ADDER_REG_IF_ID/I

compile -map_effort high -area_effort high

# Extract the critical path from the timing report
report_timing > timing_report.rpt
report_power > power_report.rpt
write -format verilog -hierarchy -output "DLX_postsyn.v"
write_sdc "DLX.sdc"
# Clean the library WORK
exec rm -rf work
exit
