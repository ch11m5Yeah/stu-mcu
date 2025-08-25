module RAM (
    input clk,
    input rstn,
    input [7:0] data_wire_in,
    output [7:0] data_wire_out,
    input [7:0] addr,
    input rd,
    input wr,
    input cs,

    input [7:0] test_addr_wire,
    output [7:0] test_data_wire
    
);
reg [7:0]   data_reg [255:0];
integer i;
assign test_data_wire = data_reg[test_addr_wire];
initial begin
    for(i=0;i<256;i=1+i)
        data_reg[i] <= 0;
end
always @(posedge clk or negedge rstn)begin
    if(!rstn)begin
        for(i=0;i<256;i=1+i)
            data_reg[i] <= 0;
    end
    else if(cs&&wr)
        data_reg[addr] <= data_wire_in;
end
assign data_wire_out = (cs&&rd)?data_reg[addr]:8'bz;
endmodule


module ROM (
    output  [7:0] data_wire,
    input  rd,
    input  cs,
    input  [7:0] addr,

    input [7:0] test_addr_wire,
    output [7:0] test_data_wire
);
reg [7:0]   data_reg [255:0];

assign test_data_wire = data_reg[test_addr_wire];
initial begin
    data_reg[0] = 8'b0100_1010;
    data_reg[1] = 8'd128;
    data_reg[2] = 8'h00;

    data_reg[3] = 8'b0100_0000;
    data_reg[4] = 8'b0000_0001;
    data_reg[5] = 8'b0111_1111;

    data_reg[6] = 8'b0000_0101;
    data_reg[7] = 8'b0000_0000;
    data_reg[8] = 8'b0000_1111;

    data_reg[9] = 8'b0100_1001;
    data_reg[10] = 8'b0000_0000;
    data_reg[11] = 8'b0000_0010;

    data_reg[12] = 8'b0001_0000;
    data_reg[13] = 8'b0010_0010;
    data_reg[14] = 8'b0000_0001;

    data_reg[15] = 8'b1101_0000;
    data_reg[16] = 8'b0010_0010;
    data_reg[17] = 8'b0000_0000;

    data_reg[18] = 8'b1110_0000;
    data_reg[19] = 8'b0000_1100;
    data_reg[20] = 8'b0000_0000;

    data_reg[21] = 8'b1111_1000;
    data_reg[22] = 8'b0110_0011;
    data_reg[23] = 8'b0000_0000;

    data_reg[24] = 8'b0000_0000;
    data_reg[25] = 8'b0000_0000;
    data_reg[26] = 8'b0111_1111;

    data_reg[99] = 8'b0101_0000;
    data_reg[100] = 8'b0010_0000;
    data_reg[101] = 8'b0000_0001;

    data_reg[102] = 8'b1111_1100;
    data_reg[103] = 8'b0000_0000;
    data_reg[104] = 8'b0000_0000;

    data_reg[128] = 8'h86;
end

assign data_wire = (rd&&cs)?data_reg[addr]:8'bz;
endmodule
module Selector2to4(
    input [1:0] cin,
    output [3:0] cout
);
    assign cout = (cin == 0)?4'b0001:
                (cin == 1)?4'b0010:
                (cin == 2)?4'b0100:
                (cin == 3)?4'b1000:0000;
endmodule