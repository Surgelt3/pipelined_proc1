module RISCV_CORE(
    input clk, reset, 
    output [31:0] PCF, 
    input [31:0] InstrF,
    output [14:12] funct3M,
    input [31:0] ReadDataM,

    output MemWriteM,
    output [31:0] ALUResultM, WriteDataM
);

    wire [31:0] InstrD;

    wire RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    wire [1:0] ResultSrcD, ImmSrcD;
    wire [2:0] ALUControlD;

//controller

    control_unit CU(
        .op(InstrD[6:0]), .funct3(InstrD[14:12]), .funct7b5(InstrD[30]), .RegWrite(RegWriteD), .ResultSrc(ResultSrcD), .MemWrite(MemWriteD),
        .Jump(JumpD), .Branch(BranchD), .ALUControl(ALUControlD), .ALUSrc(ALUSrcD), .ImmSrc(ImmSrcD)
    );

    //datapath
    datapath DP(
        .clk(clk), .reset(reset), .PCF(PCF), .InstrF(InstrF), .InstrD(InstrD), 
        .RegWriteD(RegWriteD), .MemWriteD(MemWriteD), .JumpD(JumpD), .BranchD(BranchD),
        .ALUSrcD(ALUSrcD), .ResultSrcD(ResultSrcD), .ImmSrcD(ImmSrcD),
        .ALUControlD(ALUControlD), .funct3M(funct3M), .ALUResultM(ALUResultM), 
        .WriteDataM(WriteDataM), .MemWriteM(MemWriteM)
    );

endmodule