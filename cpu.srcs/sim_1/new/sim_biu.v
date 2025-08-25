`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/08 15:02:03
// Design Name: 
// Module Name: sim_biu
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


module sim_biu;
   reg [7:0] data_reg;
   wire [7:0] data_wire;
   reg [7:0] addr;
   reg [4:0] instruction;
   wire [7:0] io;
   wire [9:0] memory_addr;
   wire wr,rd;

   reg clk;
   reg cs;
   reg rstn;
   reg queue_rd;
   wire [7:0] queue_out;
   wire ise,isf;
   always #5 clk = ~clk;
assign data_wire = data_reg;
   initial begin
    clk = 0;
    rstn = 0;
    data_reg = 6;
    addr = 0;
    instruction = 0;
    cs =1;
    queue_rd =0;
    #5 rstn = 1;
    #10
        instruction <= 5'b10001;
        data_reg <= 8'bz;
        addr <= 0;
    #10
        instruction <= 5'b10001;
        data_reg <= 8'bz;
        addr <= 1;
    #10
        instruction <= 0;
    #10
        queue_rd <= 1;
    #20 
        queue_rd <= 0;
   end
   IO m1(
    .data_wire(data_wire),
    .addr_wire(addr),
    .instruction(instruction),
    .io_port(io),
    .memory_addr(memory_addr),
    .wr(wr),
    .rd(rd)
   );
//    RAM m2(
//     .data_wire(io),
//     .clk(clk),
//     .rd(rd),
//     .wr(wr),
//     .cs(cs),
//     .rstn(rstn),
//     .addr(memory_addr[7:0])
//     );
ROM m2(
    .data_wire(io),
    .rd(rd),
    .cs(cs),
    .addr(memory_addr[7:0])
    );
    InstructionQueue m3(
        .clk(clk),
        .rstn(rstn),
        .data_in(data_wire),
        .queue_write(instruction[4]),
        .queue_read(queue_rd),
        .data_out(queue_out),
        .is_empty(ise),
        .is_full(isf)
    );
endmodule
