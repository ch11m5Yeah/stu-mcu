// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Jun 25 21:52:13 2024
// Host        : DESKTOP-TN2OJ1M running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/homework_space/FPGA/CPU8bit/cpu/cpu.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.3" *)
module vio_0(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[7:0],probe_in1[7:0],probe_in2[7:0],probe_in3[7:0],probe_in4[7:0],probe_in5[9:0]" */;
  input clk;
  input [7:0]probe_in0;
  input [7:0]probe_in1;
  input [7:0]probe_in2;
  input [7:0]probe_in3;
  input [7:0]probe_in4;
  input [9:0]probe_in5;
endmodule
