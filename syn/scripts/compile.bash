vcom ../a.a-ControlUnit.core/a.a.a-cw_flags.vhd
vcom ../a.a-ControlUnit.core/a.a.b-op_func.vhd
vcom ../a.b-Datapath.core/a.b.a-aluOpCodes.vhd
om .
vc./a.a-HWCU.vhd

vcom ../a.b-Datapath.core/a.b.b-ALU.vhd
vcom ../a.b-Datapath.core/a.b.c-ADDER.vhd
vcom ../a.b-Datapath.core/a.b.d-MUX21.vhd
vcom ../a.b-Datapath.core/a.b.e-REG.vhd
vcom ../a.b-Datapath.core/a.b.f-RF.vhd
vcom ../a.b-DP.vhd

vcom ../a.c-DATAMEM.vhd
vcom ../a.d-INSTRMEM.vhd

vcom ../a-CPU.vhd

vcom ../test_bench/TB_CPU.vhd