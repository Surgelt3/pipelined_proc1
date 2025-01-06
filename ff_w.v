module ff_w(
    input RegWriteM,
    input [1:0] ResultSrcM,
    output reg RegWriteW,
    output reg [1:0] ResultSrcW,

    input clk,
    input [4:0] RdM,
    input [31:0] ALUResultM, ReadDataM, PCPlus4M,
    output reg [4:0] RdW,
    output reg [31:0] ALUResultW, ReadDataW, PCPlus4W
);

    always @(posedge clk) begin
        RegWriteW <= RegWriteM;
        ResultSrcW <= ResultSrcM;

        RdW <= RdM;
        ALUResultW <= ALUResultM;
        ReadDataW <= ReadDataM;
        PCPlus4W <= PCPlus4M;
    end

endmodule