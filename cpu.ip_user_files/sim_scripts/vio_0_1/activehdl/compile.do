vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl/verilog" "+incdir+../../../../cpu.srcs/sources_1/ip/vio_0_1/hdl" \
"../../../../cpu.srcs/sources_1/ip/vio_0_1/sim/vio_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

