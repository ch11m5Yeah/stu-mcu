module decoder(
    input clk,
    input rstn,

    input [7:0] data_wire_in,
    output [7:0] data_wire_out,

    output [3:0] alu_control,
    output [3:0] alu_operator,
    output alu_type,
    input zero,
    input greater,

    output reg_rd,
    output reg_wr,
    output [3:0] reg_addr,

    output [7:0] addr_wire,
    output [3:0] io_instruction,

    output [7:0] PC_bus,
    output [7:0] test_wire1,
    output [23:0] test_wire2
);

parameter IDLE = 2'b00, IF = 2'b01, BUSY = 2'b10;
parameter   MOVRI = 24'b0100_0000_0000_xxxx_xxxx_xxxx,
            MOVMI = 24'b0000_0101_xxxx_xxxx_xxxx_xxxx,
            MOVRM = 24'b1000_0101_xxxx_xxxx_0000_xxxx,
            MOVMR = 24'b0100_1001_xxxx_xxxx_0000_xxxx,
            MOVCR = 24'b0100_1010_xxxx_xxxx_0000_xxxx,
            NOP   = 24'b0000_0000_0000_0000_0000_0000,
            OPERA = 24'b0001_0000_xxxx_xxxx_xxxx_xxxx,
            OPERAR= 24'b0101_0000_xxxx_xxxx_0000_xxxx,
            JMP   = 24'b0000_1110_xxxx_xxxx_0000_0000,
            CMPX  = 24'b11x1_0000_0010_xxxx_xxxx_xxxx,
            JX    = 24'b11x0_0000_xxxx_xxxx_0000_0000,
            CALL  = 24'b1111_1000_xxxx_xxxx_0000_0000,
            RET   = 24'b1111_1100_0000_0000_0000_0000,
            STOP  = 24'b0000_0000_0000_0000_0111_1111;
reg [23:0] instruction_reg = 24'bz;
reg [7:0] PC = 0;
reg [1:0] state = IDLE;
reg [1:0] counter = 0;
reg [7:0] addr_reg = 8'bz;
reg [3:0] io_reg = 8'bz;
reg [7:0] data_reg = 8'bz;
reg reg_rd_reg = 0;
reg reg_wr_reg = 0;
reg [3:0] reg_addr_reg = 0;
reg [3:0] alu_state = 0;
reg [3:0] alu_op_reg = 8'bz;
reg alu_type_reg =  1'bz;
reg [7:0] SP = 0;
assign test_wire1 = counter;
assign test_wire2 = instruction_reg;
assign PC_bus = PC;

assign reg_addr = reg_addr_reg;
assign reg_wr = reg_wr_reg;
assign reg_rd = reg_rd_reg;

assign io_instruction = io_reg; 
assign addr_wire = addr_reg;
assign data_wire_out = data_reg;

assign alu_control = alu_state;
assign alu_operator = alu_op_reg;
assign alu_type = alu_type_reg;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin 
        instruction_reg <= 24'h100000;
        state <= IDLE;
        io_reg <= 0;
        counter <= 0;
        addr_reg <= 8'bz;
        PC <= 0;
        reg_addr_reg <= 8'bz;
        reg_wr_reg <= 0;
        reg_rd_reg <= 0;
        data_reg <= 8'bz;
        alu_state <= 0;
        alu_op_reg <= 8'bz;
        alu_type_reg <= 1;
        SP <= 0;

    end else begin
        case(state)
            IDLE: begin
                data_reg <= 8'bz;
                reg_rd_reg <= 1'b0;
                reg_wr_reg <= 1'b0;
                reg_addr_reg <= 4'bz;

                alu_state <= 0;
                alu_op_reg <= 8'bz;

                instruction_reg <= 24'h100000;
                state <= IF;
                counter <=2;
                addr_reg <= PC;
                io_reg = 4'b1010;
                PC <= PC + 1;
            end
            IF: begin
                    if(counter==2||counter==1)begin
                        instruction_reg <= instruction_reg << 8 | data_wire_in;
                        addr_reg <= PC;
                        io_reg = 4'b1010;
                        PC <= PC + 1;
                        counter <= counter - 1;
                    end
                    else if(counter == 0) begin
                        instruction_reg <= instruction_reg << 8 | data_wire_in;
                        addr_reg <= 8'bz;
                        io_reg = 0;
                        state <= BUSY;
                    end

                end
            BUSY: begin
                casex(instruction_reg)
                    MOVRI:begin 
                        data_reg <= instruction_reg[7:0];
                        reg_rd_reg <= instruction_reg[23];
                        reg_wr_reg <= instruction_reg[22];
                        reg_addr_reg <= instruction_reg[11:8];
                        state <= IDLE; 
                    end
                    MOVMI:begin
                        data_reg <= instruction_reg[7:0];
                        io_reg <= instruction_reg[19:16];
                        addr_reg <= instruction_reg[15:8];
                        state <= IDLE; 
                    end
                    MOVRM:begin
                        reg_rd_reg <= instruction_reg[23];
                        reg_wr_reg <= instruction_reg[22];
                        io_reg <= instruction_reg[19:16];
                        addr_reg <= instruction_reg[15:8];
                        reg_addr_reg <= instruction_reg[3:0];
                        state <= IDLE; 
                    end
                    MOVMR:begin
                        reg_rd_reg <= instruction_reg[23];
                        reg_wr_reg <= instruction_reg[22];
                        io_reg <= instruction_reg[19:16];
                        addr_reg <= instruction_reg[15:8];
                        reg_addr_reg <= instruction_reg[3:0];
                        state <= IDLE; 
                    end
                    MOVCR:begin
                        reg_rd_reg <= instruction_reg[23];
                        reg_wr_reg <= instruction_reg[22];
                        io_reg <= instruction_reg[19:16];
                        addr_reg <= instruction_reg[15:8];
                        reg_addr_reg <= instruction_reg[3:0];
                        state <= IDLE; 
                    end
                    STOP:begin
                        data_reg <= 8'bz;
                        reg_rd_reg <= 0;
                        reg_wr_reg <= 0;
                        reg_addr_reg <= 4'bz;
                        io_reg <= 8'b0;
                        addr_reg <= 8'bz;
                        state <= BUSY;
                    end
                    OPERA:begin
                        if(alu_state == 0)begin
                            alu_state <= 4'b1000;
                            data_reg <= instruction_reg[7:0];
                            alu_op_reg <= instruction_reg[15:12];
                            alu_type_reg <= instruction_reg[21];
                            reg_addr_reg <= 8'bz; 
                        end
                        else if(alu_state == 4'b1000)begin
                            alu_state <= 4'b0100;
                            reg_rd_reg <= 1;
                            reg_wr_reg <= 0;
                            reg_addr_reg <= instruction_reg[11:8];
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b0100)begin
                            alu_state <= 4'b0010;
                            reg_rd_reg <= 0;
                            reg_wr_reg <= 0;
                        end
                        else if(alu_state == 4'b0010) begin
                            reg_rd_reg <= 0;
                            reg_wr_reg <= 1;
                            data_reg <= 8'bz;
                            alu_state <= 4'b0001;
                        end
                        else if(alu_state == 4'b0001)
                            state <= IDLE;
                    end
                    CMPX:begin
                        if(alu_state == 0)begin
                            alu_state <= 4'b1000;
                            data_reg <= instruction_reg[7:0];
                            alu_op_reg <= instruction_reg[15:12];
                            alu_type_reg <= instruction_reg[21];
                            reg_addr_reg <= 8'bz; 
                        end
                        else if(alu_state == 4'b1000)begin
                            alu_state <= 4'b0100;
                            reg_rd_reg <= 1;
                            reg_wr_reg <= 0;
                            reg_addr_reg <= instruction_reg[11:8];
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b0100)begin
                            alu_state <= 4'b0010;
                            reg_rd_reg <= 0;
                            reg_wr_reg <= 0;
                        end
                        else if(alu_state == 4'b0010)
                            state <= IDLE;
                    end
                    JMP:begin
                        PC <= instruction_reg[15:8];
                        state <= IDLE;
                    end
                    JX:begin
                        if(instruction_reg[21]==0&&zero&&!greater)begin
                            PC <= instruction_reg[15:8];
                            state <= IDLE;
                        end
                        else if(instruction_reg[21]==1&&!zero&&greater)begin
                            PC <= instruction_reg[15:8];
                            state <= IDLE;
                        end
                        else state <= IDLE;
                    end
                    CALL:begin
                        PC <= instruction_reg[15:8];
                        SP <= PC;
                        state <= IDLE;
                    end
                    RET:begin
                        PC <= SP;
                        SP <= 0;
                        state <= IDLE;
                    end
                    OPERAR:begin
                        if(alu_state == 0)begin
                            alu_state <= 4'b1000;
                            reg_rd_reg <= 1;
                            reg_wr_reg <= 0;
                            reg_addr_reg <= instruction_reg[3:0];
                            alu_op_reg <= instruction_reg[15:12];
                            alu_type_reg <= instruction_reg[21];
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b1000)begin
                            alu_state <= 4'b0100;
                            reg_rd_reg <= 1;
                            reg_wr_reg <= 0;
                            reg_addr_reg <= instruction_reg[11:8];
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b0100)begin
                            alu_state <= 4'b0010;
                            reg_rd_reg <= 0;
                            reg_wr_reg <= 0;
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b0010) begin
                            reg_rd_reg <= 0;
                            reg_wr_reg <= 1;
                            alu_state <= 4'b0001;
                            data_reg <= 8'bz;
                        end
                        else if(alu_state == 4'b0001)
                            state <= IDLE;
                    end
                    NOP:state <= IDLE;
                endcase
            end
        endcase
    end
end
endmodule
