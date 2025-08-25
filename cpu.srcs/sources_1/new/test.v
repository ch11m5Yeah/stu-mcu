module test(
    input sys_clk,
    input sys_rstn
);
wire [7:0] PC;
wire [7:0] rom_test_addr_wire;
wire [7:0] ram_test_addr_wire;
wire [3:0] reg_test_addr_wire;
wire [7:0] rom_test_data_wire;
wire [7:0] ram_test_data_wire;
wire [7:0] reg_test_data_wire;

wire [9:0] io_addr_bus;

CPU8bit m1(
    .clk(sys_clk),
    .rstn(sys_rstn),
    .PC(PC),
    .rom_test_addr_wire(rom_test_addr_wire),
    .ram_test_addr_wire(ram_test_addr_wire),
    .reg_test_addr_wire(reg_test_addr_wire),
    .rom_test_data_wire(rom_test_data_wire),
    .ram_test_data_wire(ram_test_data_wire),
    .reg_test_data_wire(reg_test_data_wire)
);
vio_0 m2(
    .clk(sys_clk),
    .probe_in0(PC),
    .probe_in1(rom_test_data_wire),
    .probe_in2(ram_test_data_wire),
    .probe_in3(reg_test_data_wire),
    .probe_out0(rom_test_addr_wire),
    .probe_out1(ram_test_addr_wire),
    .probe_out2(reg_test_addr_wire)

);
endmodule