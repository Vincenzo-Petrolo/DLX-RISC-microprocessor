# First analyze all files
analyze -library WORK -format vhdl {
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-ControlUnit.core/a.a.b-op_func.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-ControlUnit.core/a.a.a-cw_flags.vhd
 /home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.a-aluOpCodes.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.d-MUX21.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.c-ADDER.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.b-fa.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.c-nd2.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.d-iv.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.e-mux21_generic.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.f-rca_generic.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.g-carry_select_block_generic.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.h-pgb.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.i-PG.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.l-G.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.m-sum_generator.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.n-CLA.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.g-p4_adder.core/a.b.g.o-adder_generic.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.b-ALU.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.e-REG.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-Datapath.core/a.b.f-RF.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.b-DP.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a.a-HWCU.vhd
/home/ms22.38/Desktop/DLX-Risc-uProcessor/syn/a-CPU.vhd}

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

#Optimize the design
set_fix_hold "CLK"
compile -map_effort high

# Extract the critical path from the timing report
report_timing > timing_report.rpt
report_power > power_report.rpt
write -format verilog -hierarchy -output "DLX_postsyn.v"
write_sdc "DLX.sdc"
# Clean the library WORK
exec rm -rf work
exit
