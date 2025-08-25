module sim4_memory;
reg rd,cs,wr;
reg [7:0] addr;
wire [7:0] data_wire;
reg [7:0] data_reg;
reg clk,rstn;
always #5 clk = ~clk;
assign data_wire = data_reg;
initial begin 
    rd = 0;
    cs = 0;
    addr = 0;
    rstn = 0;
    data_reg = 8'bz;
    clk = 0;
    wr = 0;
    #5 rstn = 1;
    #10 addr <= 1;
        data_reg <= 6;
        wr <= 1;
        cs <= 1;
        rd <= 0;
    #10 addr <= 0;
        data_reg <= 8'bz;
        wr <= 0;
        cs <= 1;
        rd <= 1;
    #10 addr <= 1;
        data_reg <= 8'bz;
        wr <= 0;
        cs <= 1;
        rd <= 1;
end

RAM m1(
    .data_wire(data_wire),
    .clk(clk),
    .rd(rd),
    .wr(wr),
    .cs(cs),
    .rstn(rstn),
    .addr(addr)
);
endmodule