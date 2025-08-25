`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/06 11:24:09
// Design Name: 
// Module Name: cpu_main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU8bit(
    input clk,
    input rstn,
    input [7:0] rom_test_addr_wire,
    output [7:0] rom_test_data_wire,
    input [7:0] ram_test_addr_wire,
    output [7:0] ram_test_data_wire,
    input [3:0] reg_test_addr_wire,
    output [7:0] reg_test_data_wire,
    output [7:0] PC
    );



wire [7:0] data_in_bus_0,data_in_bus_1,data_in_bus_2;
wire [7:0] data_out_bus_0,data_out_bus_1;
wire [7:0] decode_out;
wire [3:0] alu_control,alu_operator;
wire alu_type;
wire zero,greater;
wire reg_rd,reg_wr;
wire [3:0] reg_addr;
wire [7:0] addr_wire;
wire [3:0] io_instruction;
decoder m1(
    .clk(clk),
    .rstn(rstn),
    .data_wire_in(data_in_bus_0),
    .data_wire_out(decode_out),
    .alu_control(alu_control),
    .alu_operator(alu_operator),
    .alu_type(alu_type),
    .zero(zero),
    .greater(greater),
    .reg_rd(reg_rd),
    .reg_wr(reg_wr),
    .reg_addr(reg_addr),
    .addr_wire(addr_wire),
    .io_instruction(io_instruction),
    .PC_bus(PC)
);
OneWay l0(.in(data_in_bus_0),.out(data_in_bus_1));
assign data_in_bus_1 = decode_out;
assign data_out_bus_0 = decode_out;
wire [7:0] io_in,io_out;
wire [9:0] io_addr;
wire io_wr,io_rd;
IO m2(
    .data_wire_in(data_out_bus_0),
    .data_wire_out(data_in_bus_0),
    .addr_wire(addr_wire),
    .instruction(io_instruction),
    .io_in(io_in),
    .io_out(io_out),
    .memory_addr(io_addr),
    .wr(io_wr),
    .rd(io_rd)
);
wire [3:0] cs;
Selector2to4 m4(.cin(io_addr[9:8]),.cout(cs));
ROM m3(
    .data_wire(io_in),
    .rd(io_rd),
    .cs(cs[0]),
    .addr(io_addr[7:0]),
    .test_addr_wire(rom_test_addr_wire),
    .test_data_wire(rom_test_data_wire)
);
RAM m5(
    .clk(clk),
    .rstn(rstn),
    .data_wire_in(io_out),
    .data_wire_out(io_in),
    .wr(io_wr),
    .rd(io_rd),
    .cs(cs[1]),
    .addr(io_addr[7:0]),
    .test_addr_wire(ram_test_addr_wire),
    .test_data_wire(ram_test_data_wire)
);
OneWay l1(.in(data_in_bus_1),.out(data_in_bus_2));
wire [7:0] alu_b_in;
OneWay l3(.in(data_in_bus_1),.out(alu_b_in));
assign alu_b_in = data_out_bus_1;
ALU m6(
    .operator(alu_operator),
    .type(alu_type),
    .a(data_out_bus_1),
    .b(alu_b_in),
    .zero(zero),
    .greater(greater),
    .in_a(alu_control[2]),
    .in_b(alu_control[3]),
    .en(alu_control[1]),
    .out(alu_control[0]),
    .data_out(data_in_bus_2),
    .clk(clk),
    .rstn(rstn)
);
RegFile m7(
    .clk(clk),
    .rstn(rstn),
    .wr(reg_wr),
    .rd(reg_rd),
    .addr(reg_addr),
    .data_wire_in(data_in_bus_2),
    .data_wire_out(data_out_bus_1),
    .test_addr_wire(reg_test_addr_wire),
    .test_data_wire(reg_test_data_wire)
);
OneWay l2(.in(data_out_bus_1),.out(data_out_bus_0));


endmodule
