module InstructionQueue(
    input   wire    clk,
    input   wire    rstn,
    input   wire    [7:0]   data_in,
    input   wire    queue_write,
    input   wire    queue_read,
    output  reg     [7:0]   data_out,
    output  reg     is_empty,
    output  reg     is_full
);
reg [7:0] queue [7:0];
reg [2:0] rd_index,wr_index;
reg [3:0] queue_count = 0;
always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        rd_index <= 0;
        wr_index <= 0;
        queue_count <= 0;
    end
    else begin
        if(queue_write && queue_count < 8) begin
            queue[wr_index] <= data_in;
            wr_index <= wr_index + 1;
            queue_count <= queue_count + 1; 
        end
        else if(queue_read && queue_count > 0) begin
            data_out <= queue[rd_index];
            rd_index <= rd_index + 1;
            queue_count <= queue_count - 1;
        end
        else
            data_out <= 8'bz;
    end
end
always @(queue_count)begin
    if(queue_count == 7) begin
        is_empty <= 0;
        is_full <= 1;
    end
    else if(queue_count == 0) begin
        is_empty <= 1;
        is_full <= 0;
    end
    else begin
        is_empty <= 0;
        is_full <= 0;
    end
end     
endmodule



module IO(

    input [7:0] data_wire_in,
    output [7:0] data_wire_out,
    input [7:0] addr_wire,
    input [3:0] instruction,

    input [7:0] io_in,
    output [7:0] io_out,
    output [9:0] memory_addr,
    output wr,
    output rd
);
assign memory_addr = (instruction[1:0]==2'b01)?addr_wire+10'b01_0000_0000:
                    (instruction[1:0]==2'b10)?addr_wire+10'b00_0000_0000:
                    (instruction[1:0]==2'b11)?addr_wire+10'b10_0000_0000:10'b11_0000_0000;
assign data_wire_out = (instruction[3:2]==2'b10)?io_in:8'bz;
assign io_out = (instruction[3:2]==2'b01)?data_wire_in:8'bz;
assign wr = instruction[2];
assign rd = instruction[3];
endmodule
module OneWay(
    input [7:0] in,
    output [7:0] out
);
assign out = in;
endmodule


