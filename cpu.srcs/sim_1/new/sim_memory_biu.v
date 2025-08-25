module sim4_memory_biu;
   reg [7:0] data_reg;
   wire [7:0] data_wire;
   reg [7:0] addr;
   reg [4:0] instruction;
   wire [7:0] io;
   wire [9:0] memory_addr;
   wire wr,rd;

   RegFile m1(
        .clk(clk),
        .data_wire(data),
        .wr(wr),
        .rd(rd),
        .rstn(rstn),
        .addr(addr),
        .io_port(io)
    );
endmodule