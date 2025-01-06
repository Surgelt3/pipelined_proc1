module datapath (
    input clk, reset,
    output [31:0] PCF,
    input [31:0] InstrF, 
    output [31:0] InstrD,
    //inputs from control unit
    input RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
    input [1:0] ResultSrcD, ImmSrcD,
    input [2:0] ALUControlD,
    output [14:12] funct3M,
    input [31:0] ReadDataM,

    //for data memory
    output [31:0] ALUResultM, WriteDataM,
    output MemWriteM
);

    wire [31:0] PCNext, PCD, PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W, ResultW, RD1D, RD2D, ImmExtD;
    wire [31:0] RD1E, RD2E, PCE, ImmExtE;
    wire [11:7] RdW, RdE, RdM;
    wire  [14:12] funct3D, funct3E;
    wire RegWriteE, RegWriteM, RegWriteW, MemWriteE, JumpE, BranchE, ALUSrcE;
    wire [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;

    wire [31:0] SrcBE, ALUResultE, ALUResultW, ReadDataW;
    wire [31:0] PCPlus4F;
    wire [31:0] PCTargetE;

    wire ZeroE;
    wire PCSrcE;

    assign funct3D = InstrD[14:12];

    ff FF(
        .clk(clk), .reset(reset), .d(PCNext), .q(PCF)
    );

    adder pcadd4(PCF, 32'd4, PCPlus4);
    
    always @(*) begin
        $monitor("PCF: %d", PCF);
    end

    ff_id FFD(.clk(clk), .InstrF(InstrF), .PCF(PCF), .PCPlus4F(PCPlus4F), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D));

    regfile rf(.clk(clk), .RegWrite(RegWriteW), .A1(InstrD[19:15]), .A2(InstrD[24:20]), .A3(RdW), .WD3(ResultW), .RD1(RD1D), .RD2(RD2D));

    extend ext(.instr(InstrD[31:7]), .immsrc(ImmSrcD), .immext(ImmExtD));

    ff_e FFE(
        .clk(clk), .funct3D(funct3D), .funct3E(funct3E), .RegWriteD(RegWriteD), .MemWriteD(MemWriteE), .JumpD(JumpD), .BranchD(BranchD), .ALUSrcD(ALUSrcD),
        .ResultSrcD(ResultSrcD), .ALUControlD(ALUControlD), .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .JumpE(JumpE), .BranchE(BranchE), .ALUSrcE(ALUSrcE),
        .RD1D(RD1D), .RD2D(RD2D), .PCD(PCD), .RdD(InstrD[11:7]), .ImmExtD(ImmExtD), .PCPlus4D(PCPlus4D), .RD1E(RD1E), .RD2E(RD2E), .PCE(PCE), .RdE(RdE),
        .ImmExtE(ImmExtE), .PCPlus4E(PCPlus4E), .ALUControlE(ALUControlE), .ResultSrcE(ResultSrcE)
    );

    mux2 emux(
        .in0(RD2E), .in1(ImmExtE), .sel(ALUSrcE), .out(SrcBE)
    );

    alu adder(PCE, ImmExtE, 3'b000, PCTargetE);


    alu ALU(
        .SrcA(RD1E), .SrcB(SrcBE), .ALUControl(ALUControlE), .ALUResult(ALUResultE) , .Zero(ZeroE)
    );

    ff_m FFM(
        .clk(clk), .funct3E(funct3E), .funct3M(funct3M), .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE), .RegWriteM(RegWriteM), .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM),
        .ALUResultE(ALUResultE), .WriteDataE(RD2E), .RdE(RdE), .PCPlus4E(PCPlus4E), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .RdM(RdM), .PCPlus4M(PCPlus4M)
    );

    ff_w FFW(
        .clk(clk), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW),
        .RdM(RdM), .ALUResultM(ALUResultM), .ReadDataM(ReadDataM), .PCPlus4M(PCPlus4M), .RdW(RdW),
        .ALUResultW(ALUResultW), .ReadDataW(ReadDataW), .PCPlus4W(PCPlus4W)
    );

    mux3 MUX3(
        .in0(ALUResultW), .in1(ReadDataW), .in2(PCPlus4W), .sel(ResultSrcW), .out(ResultW)
    );

    assign PCSrcE = (ZeroE & BranchE) | JumpE;

    mux2 MUX2(
        .in0(PCPlus4F), .in1(PCTargetE), .sel(PCSrcE), .out(PCNext)
    );
  

endmodule