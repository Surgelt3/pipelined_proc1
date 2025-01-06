module control_unit(
    input funct7b5,
    input [2:0] funct3,
    input [6:0] op,
    output MemWrite, ALUSrc, RegWrite, Jump, Branch,
    output [1:0] ResultSrc, ImmSrc,
    output [2:0] ALUControl
);

    wire [1:0] ALUOp;

    maindec md(
        .op(op), .MemWrite(MemWrite), .Branch(Branch), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump), 
        .ResultSrc(ResultSrc), .ImmSrc(ImmSrc), .ALUOp(ALUOp)
    );
    aludec ad(op[5], funct7b5, ALUOp, funct3, ALUControl);    

endmodule