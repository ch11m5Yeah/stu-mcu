module ALU(
    input   wire    [3:0]   operator,
    input   wire    [7:0]   a,b,
    input   wire    type,
    input   wire    in_a,in_b,out,en,
    output  wire     [7:0]  data_out,
    input   wire    clk,
    input   wire    rstn,
    output  wire    [7:0] ts1,ts2,
    output  wire    zero,
    output  wire    greater
);
reg [7:0] acc;
reg [7:0] data_a,data_b;
assign ts1 = data_a;
assign ts2 = data_b;
assign data_out = out? acc : 8'bzzzzzzzz;
assign zero = (acc == 0)?1:0;
assign greater = ((type == 1&&acc>0&&acc[7]==0)||(type==0&&acc!=0))?1:0;
parameter   ADD = 4'b0001,
            SUB = 4'b0010,
            MUL = 4'b0011,
            DIV = 4'b0100,
            AND = 4'b0101,
            OR  = 4'b0110,
            NOT = 4'b0111,
            SHL = 4'b1000,
            SHR = 4'b1001,
            XOR = 4'b1010,
            XAND= 4'b1011;
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
        data_a <= 8'b0000_0000;
        data_b <= 8'b0000_0000;
        acc <= 8'b1000_0000;
    end
    else begin
        if({in_a,in_b,en,out}==4'b1000) begin
            data_a <= a;
        end
        else if({in_a,in_b,en,out}==4'b0100) begin
            data_b <= b;
        end
        else if({in_a,in_b,en,out}==4'b0010) begin
            case(operator)
                ADD: acc <= data_a + data_b;
                SUB: acc <= data_a - data_b;
                MUL: acc <= data_a * data_b;
                DIV: acc <= data_a / data_b;
                AND: acc <= data_a & data_b;
                OR:  acc <= data_a | data_b;
                NOT: acc <= ~data_a;
                SHL: acc <= data_a << data_b;
                SHR: acc <= data_a >> data_b;
                XOR: acc <= data_a ^ data_b;
                XAND:acc <= data_a ~^ data_b;
                default: acc <= 8'bzzzzzzzz;
            endcase    
        end
    end
end
endmodule