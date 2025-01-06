module ff_m(
    input [2:0] funct3E,
    output reg [2:0] funct3M, 
    input RegWriteE, MemWriteE,
    input [1:0] ResultSrcE,
    output reg RegWriteM, MemWriteM,
    output reg [1:0] ResultSrcM,

    input clk,
    input [11:7] RdE,
    output reg [11:7] RdM,
    input [31:0] ALUResultE, WriteDataE, PCPlus4E,
    output reg [31:0] ALUResultM, WriteDataM, PCPlus4M
);

    always @(posedge clk) begin
        funct3M <= funct3E;

        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE;
        ResultSrcM <= ResultSrcE;

        ALUResultM <= ALUResultE;
        WriteDataM <= WriteDataE;
        RdM <= RdE;
        PCPlus4M <= PCPlus4E;
    end


endmodule