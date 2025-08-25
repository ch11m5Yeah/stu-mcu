vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl/verilog" "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl" \
"../../../../cpu.srcs/sources_1/ip/vio_0_1/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

