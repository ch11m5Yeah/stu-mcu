module seg_reg_file;
reg clk;
reg rstn;
reg [7:0] data_in;
reg [1:0] addr;
reg wr;
reg out_data;
reg out_seg;
wire [7:0] data_out;
wire [7:0] seg_out;

always #5 clk=~clk;
initial begin
    clk = 0;
    rstn = 0;
    data_in = 1;
    addr = 1;
    wr = 0;
    out_data = 0;
    out_seg = 0;
    #5 rstn = 1;
    #10
        addr <= 1;
        wr <= 1;
        out_seg <= 0;
        out_data <= 0;
        data_in <= 9;
    #10
        addr <= 2;
        wr <= 1;
        out_seg <= 0;
        out_data <= 0;
        data_in <= 1;
    #10 
        addr <= 1;
        wr <= 0;
        out_seg <= 1;
        out_data <= 0;
        data_in <= 9;
    #10 
        addr <= 1;
        wr <= 0;
        out_seg <= 0;
        out_data <= 1;
        data_in <= 5;
end

SegRegFile m1(
    .clk(clk),
    .rstn(rstn),
    .data_in(data_in),
    .wr(wr),
    .out_seg(out_seg),
    .out_data(out_data),
    .addr(addr),
    .data_out(data_out),
    .seg_out(seg_out)
);
endmodule