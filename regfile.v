module regfile(
    input clk,
    input RegWrite,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    output [31:0] RD1,
    output [31:0] RD2
);

    //Read register value at address A1
    reg [31:0] registers [31:0];

    initial begin
        registers[0] = 32'b0;
    end

    assign RD1 = registers[A1];

    assign RD2 = registers[A2];

    always @(posedge clk) begin
        if (RegWrite && (A3 != 0))  
            registers[A3] <= WD3;
    end



endmodule