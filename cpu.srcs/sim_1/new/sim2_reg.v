`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/09 10:58:28
// Design Name: 
// Module Name: sim2_reg
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


`timescale 1ns / 1ps

module sim2_reg;

    reg [7:0] data_reg;
    reg wr,rd,rstn;
    reg [3:0] addr;
    wire [7:0] data;
    reg clk;
    assign data = data_reg;
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rstn = 0;
        wr = 0;
        rd = 0;
        data_reg = 8'bzzzzzzzz;
        #5 rstn = 1;
        #10 addr <= 0;
            rd <= 0;
            wr <=1;
            data_reg <= 8'b10101010;
        #10 addr <= 0;
            wr <=0;
            rd <= 1;
            data_reg <= 8'bzzzzzzzz;
    end
    RegFile m1(
        .clk(clk),
        .data_wire(data),
        .wr(wr),
        .rd(rd),
        .rstn(rstn),
        .addr(addr)
    );
endmodule

