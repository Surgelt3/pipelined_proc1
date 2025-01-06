module TOP(
    input clk, reset,
    output [31:0] PCF, InstrF
    
);

    wire [31:0] ReadDataM, ALUResultM, WriteDataM;
    wire [14:12] funct3M;
    wire MemWriteM;

    RISCV_CORE core(
        .clk(clk), .reset(reset), .PCF(PCF), .InstrF(InstrF), .funct3M(funct3M), .ReadDataM(ReadDataM), 
        .MemWriteM(MemWriteM), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM)
    );

    instruction_memory IM(
        .address(PCF),
        .read_data(InstrF)
    );

    data_mem DM(
        .clk(clk), .WE(MemWriteM), .funct3(funct3M), .A(ALUResultM), .WD(WriteDataM), .RD(ReadDataM)
    );




endmodule