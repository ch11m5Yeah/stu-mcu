module Top(
    input clk,
    input rstn,
    output wire [7:0] PC,
    output wire [7:0] test_wire,
    output wire [9:0] addr_data
);
wire [7:0] D;
wire [9:0] A;
wire WR,RD;
wire [3:0] cs;
assign addr_data = A;
CPU8bit m1(
    .sys_clk(clk),
    .sys_rstn(rstn),
    .D(D),
    .A(A),
    .PC(PC),
    .WR(WR),
    .RD(RD),
    .test_wire(test_wire)
);
Selector2to4 m2(
    .cin(A[9:8]),
    .cout(cs)
);
ROM m3(
    .data_wire(D),
    .rd(RD),
    .cs(cs[0]),
    .addr(A[7:0])
);
RAM m4(
    .clk(clk),
    .rstn(rstn),
    .data_wire(D),
    .addr(A[7:0]),
    .rd(RD),
    .wr(WR),
    .cs(cs[1])
);
// vio_0 m5(
//     .clk(sys_clk),
//     .probe_in0(D),
//     .probe_in1(test_wire),
//     .probe_in2(PC),
//     .probe_in3(inner_bus),
//     .probe_in4(A)
// );
endmodule