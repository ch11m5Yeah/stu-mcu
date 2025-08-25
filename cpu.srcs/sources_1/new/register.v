module RegFile(
    input  clk,
    input  [7:0] data_wire_in,
    output  [7:0] data_wire_out,
    input  [3:0] addr,
    input  wr,rd,rstn,
    
    input [3:0] test_addr_wire,
    output [7:0] test_data_wire
);
reg [7:0] reg_file [15:0];
integer i;
initial begin
    reg_file[15] = 0;
end
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        for(i=0;i<16;i=1+i)
            reg_file[addr] <= 0;
    end
    else begin
        if({wr,rd} == 2'b10)begin
            reg_file[addr] <= data_wire_in;
        end
    end
end
assign test_data_wire = reg_file[test_addr_wire];
assign data_wire_out = ({wr,rd}==2'b01&&rstn)? reg_file[addr] : 8'bz;
endmodule
module Cache(
    input clk,
    inout [7:0] data_wire,
    input wr,rd,rstn
);
reg [7:0] single_reg;
always @(posedge clk or negedge rstn)begin
    if(!rstn)
        single_reg <= 0;
    else if({wr,rd}==2'b10)
        single_reg <= data_wire;
end
assign data_wire = ({wr,rd}==2'b01&&rstn)?single_reg:8'bz;
endmodule


