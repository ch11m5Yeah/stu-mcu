module sim_cpu;
reg clk;
reg rstn;
wire [7:0] PC;
wire [7:0] data_wire;
wire [9:0] addr_wire;
wire [7:0] inner_bus;
wire [7:0] test_wire;
always #10 clk = ~clk;

initial begin
    clk = 0;
    rstn = 0;
    #10
        rstn = 1;
end
Top m1(
    .sys_clk(clk),
    .sys_rstn(rstn),
    .PC(PC),
    .data_wire(data_wire),
    .addr_wire(addr_wire),
    .inner_bus(inner_bus),
    .test_wire(test_wire)
);
endmodule