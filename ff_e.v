module ff_e(
    input [2:0] funct3D,
    output reg [2:0] funct3E,
    input RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
    input [1:0] ResultSrcD,
    input [2:0] ALUControlD,
    output reg RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
    output reg [1:0] ResultSrcE,
    output reg [2:0] ALUControlE,

    input clk,
    input [11:7] RdD,
    output reg [11:7] RdE,
    input [31:0] RD1D, RD2D, PCD, ImmExtD, PCPlus4D,
    output reg [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E
);

    always @(posedge clk) begin
        funct3E <= funct3D;
        
        RegWriteE <= RegWriteD;
        MemWriteE <= MemWriteD;
        JumpE <= JumpD;
        BranchE <= BranchD;
        ALUSrcE <= ALUSrcD;
        ResultSrcE <= ResultSrcD;
        ALUControlE <= ALUControlD;

        RD1E <= RD1D;
        RD2E <= RD2D;
        PCE <= PCD;
        RdE <= RdD;
        ImmExtE <= ImmExtD;
        PCPlus4E <= PCPlus4D;
        
    end

endmodule