module aludec(
    input opb5, funct7b5,
    input [1:0] ALUOp, 
    input [2:0] funct3,
    output reg [2:0] ALUControl
);

    wire RtypeSub;
    assign RtypeSub = funct7b5 & opb5;

    always @(*) begin

        //pick alu operation
        case(ALUOp)
            2'b00: ALUControl = 3'b000; // add ldw, sw
            2'b01: ALUControl = 3'b001; // sub beq
            default: //R or I type
                case(funct3) 
                    3'b000: if (RtypeSub)
                                ALUControl = 3'b001; // sub
                            else
                                ALUControl = 3'b000; //add
                    3'b010: ALUControl = 3'b101; //slt
                    3'b110: ALUControl = 3'b011; //or
                    3'b111: ALUControl = 3'b010; // and
                    default: ALUControl = 3'bxxx;
                endcase
        endcase

    end

endmodule