module sim_alu;
reg clk,rstn,in_a,in_b,out,en;
reg [7:0] a,b;
wire [7:0]  data_out;
reg [3:0] operator;

always #5 clk = ~clk;

initial begin
    clk = 0;
    rstn = 0;
    in_a = 0;
    in_b = 0;
    out = 0;
    en = 0;
    a = 10;
    b = 2;
    operator = 0;
    #5 rstn = 1;
    #10 
    operator <= 2;
    in_a <= 1;
    in_b <= 0;
    out <= 0;
    en <= 0;
    #10
    in_a <= 0;
    in_b <= 1;
    out <= 0;
    en <= 0;
    #10
    in_a <= 0;
    in_b <= 0;
    en <= 1;
    out <= 0;
    #10
    in_a <= 0;
    in_b <= 0;
    en <= 0;
    out <= 1;
    #10
    in_a <= 0;
    in_b <= 0;
    en <= 0;
    out <= 0;    
end

ALU m1(
    .operator(operator),
   .in_a(in_a),
   .in_b(in_b),
   .out(out),
   .en(en),
   .data_out(data_out),
   .clk(clk),
   .rstn(rstn),
   .a(a),
   .b(b)
);

 
endmodule