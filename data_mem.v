module data_mem(
    input clk, WE,
    input [2:0] funct3,
    input [31:0] A, WD,
    output [31:0] RD
);

    reg [7:0] MEM [0:4095];
    reg [3:0] BE;

    assign RD = {MEM[A+3], MEM[A+2], MEM[A+1], MEM[A]};

    always @(*) begin
        case(funct3) 
            3'b000: case(A[1:0])
                            2'b00: BE = 4'b0001;
                            2'b01: BE = 4'b0010;
                            2'b10: BE = 4'b0100;
                            2'b11: BE = 4'b1000;
                        endcase
            3'b000: case(A[1:0])
                            2'b00: BE = 4'b0011;
                            2'b10: BE = 4'b1100;
                        endcase
            3'b010: BE = 4'b1111;
        endcase
    end

    always @(posedge clk) begin
        if (WE) begin
            if (BE[0]) MEM[A] <= WD[7:0];
            if (BE[1]) MEM[A+1] <= WD[15:8];
            if (BE[2]) MEM[A+2] <= WD[23:16];
            if (BE[3]) MEM[A+3] <= WD[31:24];
        end

    end


endmodule