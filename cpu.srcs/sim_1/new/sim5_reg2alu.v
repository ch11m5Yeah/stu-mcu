module reg2alu;

reg clk,rstn,in_a,in_b,out,en;
reg [3:0] operator;

reg [7:0] data_reg;
reg wr,rd;
reg [3:0] addr;
wire [7:0] data_bus;
wire [7:0]  ts1,ts2;

assign data_bus = data_reg;
always #5 clk = ~clk;
initial begin
    clk = 0;
    in_a = 0;
    in_b = 0;
    operator = 0;
    en = 0;
    wr = 0;
    rd = 0;
    addr = 0;
    data_reg = 0;
    out = 0;
    #5 rstn = 1;
    #10
        data_reg <= 5;
        addr <= 0;
        wr <= 1;
        rd <= 0;
    #10
        data_reg <= 3;
        addr <= 1;
        wr <= 1;
        rd <= 0;
    #10 
        data_reg <= 8'bzzzzzzzz;
        operator <= 1;
        rd <= 1;
        wr <= 0;
        addr <= 0;
        in_a <= 1;
        in_b <= 0;
        en <= 0;
        out <= 0;
    #10
        rd <= 1;
        wr <= 0;
        addr <= 1;
        in_a <= 0;
        in_b <= 1;
        en <= 0;
        out <= 0;
    #10
        rd <= 0;
        wr <= 0;
        addr <= 0;
        in_a <= 0;
        in_b <= 0;
        en <= 1;
        out <= 0;
    #10
        rd <= 0;
        wr <= 0;
        addr <= 0;
        in_a <= 0;
        in_b <= 0;
        en <= 0;
        out <= 1;
end
RegFile regfile(
   .clk(clk),
   .rstn(rstn),
   .wr(wr),
   .rd(rd),
   .data_wire(data_bus),
   .addr(addr)
);
ALU alu(
    .in_a(in_a),
    .in_b(in_b),
    .operator(operator),
    .out(out),
    .en(en),
    .a(data_bus),
    .b(data_bus),
    .data_out(data_bus),
    .clk(clk),
    .rstn(rstn),
    .ts1(ts1),
    .ts2(ts2)
);


endmodule