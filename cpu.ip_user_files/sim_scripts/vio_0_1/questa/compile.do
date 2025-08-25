vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl/verilog" "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl" \
"../../../../cpu.srcs/sources_1/ip/vio_0_1/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

